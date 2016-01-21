/*
 * JBoss, the OpenSource EJB server
 *
 * Distributable under LGPL license.
 * See terms of license at gnu.org.
 */
package org.jboss.jaxr.servlet;


import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.StringWriter;
import java.io.StringReader;
import java.security.PrivateKey;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import javax.activation.DataHandler;
import javax.mail.BodyPart;
import javax.mail.MessagingException;
import javax.mail.internet.ContentType;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.ParseException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.soap.AttachmentPart;
import javax.xml.soap.MessageFactory;
import javax.xml.soap.MimeHeaders;
import javax.xml.soap.SOAPException;
import javax.xml.soap.SOAPMessage;
import javax.xml.soap.MimeHeader;

import com.sun.ebxml.registry.RegistryException;
import com.sun.ebxml.registry.interfaces.Request;
import com.sun.ebxml.registry.interfaces.Response;
import com.sun.ebxml.registry.repository.RepositoryItem;
import com.sun.ebxml.registry.repository.RepositoryManagerFactory;
import com.sun.ebxml.registry.security.SecurityUtil;
import com.sun.ebxml.registry.security.authentication.AuthenticationServiceImpl;
import com.sun.ebxml.registry.util.RegistryProperties;
import com.sun.ebxml.registry.util.Utility;

import org.apache.xml.security.signature.XMLSignature;
import org.exolab.castor.xml.Marshaller;
import org.exolab.castor.xml.Unmarshaller;

import org.jboss.logging.Logger;
import org.oasis.ebxml.registry.bindings.query.GetContentRequest;
import org.oasis.ebxml.registry.bindings.rim.ObjectRefListItem;
import org.oasis.ebxml.registry.bindings.rs.RegistryResponse;
import org.oasis.ebxml.registry.bindings.rs.SubmitObjectsRequest;
import org.oasis.ebxml.registry.bindings.rs.types.StatusType;
import org.dom4j.io.SAXReader;
import org.dom4j.Document;
import org.dom4j.Node;

/**
 * @author Scott.Stark@jboss.org
 * @version $Revision:$
 */
public class SAAJServlet
   extends HttpServlet
{
   private static Logger log = Logger.getLogger(SAAJServlet.class);

   public void init(ServletConfig servletConfig) throws ServletException
   {
      super.init(servletConfig);
      init();
   }

   public void init() throws ServletException
   {
      try
      {
         log.info("init");
         //initialise XML Security library
         org.apache.xml.security.Init.init();
      }
      catch(Exception ex)
      {
         log.fatal("Init Failed:", ex);
         throw new ServletException("Init Failed:", ex);
      }
   }

   protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException
   {
      SOAPMessage msg = null;
      SOAPMessage soapResponse = null;
      try
      {
         MessageFactory factory = MessageFactory.newInstance();
         MimeHeaders headers = new MimeHeaders();
         Enumeration names = request.getHeaderNames();
         while(names.hasMoreElements())
         {
            String name = (String) names.nextElement();
            Enumeration values = request.getHeaders(name);
            while(values.hasMoreElements())
            {
               String value = (String) values.nextElement();
               headers.addHeader(name, value);
            }
         }

         InputStream is = request.getInputStream();
         ByteArrayOutputStream copy = new ByteArrayOutputStream(is.available());
         byte[] tmp = new byte[1024];
         int length;
         while((length = is.read(tmp)) > 0)
         {
            copy.write(tmp, 0, length);
         }
         copy.close();
         byte[] msgBytes = copy.toByteArray();
         msg = factory.createMessage(headers, new ByteArrayInputStream(msgBytes));

         /* Firstly we put save the attached repository items in a map. Later
          we will remove the attachments.
          */
         HashMap idToRepositoryItemMap = new HashMap();

         //Now get any repository items that may be attached
         Iterator apIter = msg.getAttachments();
         while(apIter.hasNext())
         {
            AttachmentPart ap = (AttachmentPart) apIter.next();
            //Get the DSIG and content for the attachment
            RepositoryItem ri = processAttachment(ap);
            idToRepositoryItemMap.put(ri.getId(), ri);
         }

         /*
         Due to the suspected bugs in JAXM, we have to call writeTo method of the
         input message that has been received to write the content
         to a ByteArrayOutputStream and re-instantiate another SOAPMessage
         to make the XML signature properly verified.
          */

         /*
         If we do not remove the attachment, the SOAPMessage.writeTo() mehtod
         will output a MIME-encoded form of the message, not pure SOAP part.
          */
         if(msg.countAttachments() > 0)
         {
            msg.removeAllAttachments();
            if(msg.saveRequired())
            {
               msg.saveChanges();
            }
         }

         copy = new ByteArrayOutputStream(copy.size());
         msg.writeTo(copy);
         copy.close();
         msgBytes = copy.toByteArray();
         msg = Utility.getInstance().createSOAPMessageFromSOAPStream(new ByteArrayInputStream(msgBytes));

         // Get the header signature (if any) from the SOAPHeader
         XMLSignature headerSignature = SecurityUtil.getInstance().verifySOAPMessage(msg);

         //System.err.println("Getting ebXML Registry request");

         SAXReader xmlReader = new SAXReader();
         Document xmlDoc = xmlReader.read(new ByteArrayInputStream(msgBytes));
         List soapBody = xmlDoc.selectNodes("//soap-env:Body/*");
         if(soapBody.size() != 1)
         {
            throw new RegistryException("InvalidRequest: must have one child element");
         }

         Node requestNode = (Node) soapBody.get(0);
         String requestRootElement = requestNode.getName();

         /*
         SOAPPart sp = msg.getSOAPPart();
         SOAPEnvelope se = sp.getEnvelope(); //<-------------------------------
         SOAPBody sb = se.getBody();
         SOAPElement requestElement = null;
         Iterator iter = sb.getChildElements();
         String requestRootElement = null;
         int i = 0;
         while (iter.hasNext())
         {
            Object obj = iter.next();
            if (!(obj instanceof SOAPElement))
            {
               continue;
            }

            if (i++ == 0)
            {
               requestElement = (SOAPElement) obj;
               Name name = requestElement.getElementName();
               requestRootElement = name.getLocalName();
            }
            else
            {
               throw new RegistryException("InvalidRequest: Cannot have more than one child element");
            }
         }
*/
         Object requestObj = getRequestObject(requestRootElement, requestNode);
         Request ebxmlRequest = new Request(headerSignature, requestObj,
            idToRepositoryItemMap);

         Response ebxmlResponse = ebxmlRequest.process();
         soapResponse = createResponseSOAPMessage(ebxmlResponse);
         if(ebxmlRequest.getMessage() instanceof GetContentRequest &&
            ebxmlResponse.getMessage().getStatus().getType() == StatusType.SUCCESS_TYPE)
         {
            ObjectRefListItem[] items = ((GetContentRequest) ebxmlRequest.getMessage()).getObjectRefList()
               .getObjectRefListItem();
            for(int j = 0; j < items.length; j++)
            {
               String id = items[j].getObjectRef().getId();
               if(id.startsWith("urn:uuid:"))
               {
                  id = id.substring(9);
               }

               RepositoryItem repositoryItem =
                  RepositoryManagerFactory.getInstance()
                  .getRepositoryManager().getRepositoryItem(id);

               DataHandler contentDataHandler =
                  repositoryItem.getDataHandler();

               String xmlsigStr = repositoryItem.signatureToString();

               MimeMultipart mp = new MimeMultipart();
                    
               // Payload signature
               MimeBodyPart bp1 = new MimeBodyPart();
               // Can't set
               bp1.setHeader("Content-Type", "text/xml; charset=UTF-8");
               // Can't set
               bp1.addHeader("Content-Transfer-Encoding", "8bit");
               bp1.setHeader("Content-ID", "payload1");
               bp1.setContent(xmlsigStr, "text/plain");
               mp.addBodyPart(bp1);
        
               // Repository item
               MimeBodyPart bp2 = new MimeBodyPart();
               bp2.setDataHandler(contentDataHandler);
               bp2.setHeader("Content-Type", contentDataHandler.getContentType());
               bp2.setHeader("Content-ID", "payload2");
               mp.addBodyPart(bp2);

               AttachmentPart ap = soapResponse.createAttachmentPart(mp, "multipart/related");
               // Can't add type=text/xml; start="urn:uuid:1234567" ??
               ap.setContentType(ap.getContentType() + "; type=text/xml; start=\"urn:uuid:" + id + "\"");
               // Not in spec??
               ap.setContentId("urn:uuid:" + id);

               ContentType contentTypeMP = new ContentType(mp.getContentType());

               String boundary = contentTypeMP.getParameter("boundary");
               ContentType contentType = new ContentType("multipart/related");
               contentType.setParameter("boundary", boundary);
               ap.setContentType(contentType.toString());
               soapResponse.addAttachmentPart(ap);
            }
         }

         soapResponse.saveChanges();
      }
      catch(RegistryException e)
      {
         log.error("Caught exception: " + e.getMessage(), e);
         soapResponse = createResponseSOAPMessage(e);
      }
      catch(SOAPException e)
      {
         log.error("Caught exception: " + e.getMessage(), e);
         soapResponse = createResponseSOAPMessage(e);
      }
      catch(MessagingException e)
      {
         log.error("Caught exception: " + e.getMessage(), e);
         soapResponse = createResponseSOAPMessage(e);
      }
      catch(Exception e)
      {
         log.error("Caught exception: " + e.getMessage(), e);
         soapResponse = createResponseSOAPMessage(e);
      }
      catch(Throwable t)
      {
         log.error("Caught exception: " + t.getMessage(), t);
         soapResponse = createResponseSOAPMessage(t);
      }

      try
      {
         // Need to saveChanges 'cos we're going to use the
         // MimeHeaders to set HTTP response information. These
         // MimeHeaders are generated as part of the save.
         if(soapResponse.saveRequired())
         {
            soapResponse.saveChanges();
         }

         response.setStatus(HttpServletResponse.SC_OK);

         putHeaders(soapResponse.getMimeHeaders(), response);

         OutputStream os = response.getOutputStream();
         soapResponse.writeTo(os);
         os.flush();
      }
      catch(Throwable t)
      {
         throw new ServletException("Failed to write SOAP response", t);
      }
   }

   private SOAPMessage createResponseSOAPMessage(Object obj)
   {
      SOAPMessage msg = null;
      try
      {
         msg = MessageFactory.newInstance().createMessage();

         RegistryResponse resp = null;
         if(obj instanceof com.sun.ebxml.registry.interfaces.Response)
         {
            Response r = (Response) obj;
            resp = r.getMessage();
         }
         else if(obj instanceof java.lang.Throwable)
         {
            Throwable t = (Throwable) obj;
            resp = Utility.getInstance().createRegistryResponseFromThrowable(t, "SAAJServlet", "Unknown");
         }
            
         //Now add resp to SOAPMessage
         StringWriter sw = new StringWriter();
         Marshaller marshaller = new Marshaller(sw);
         marshaller.marshal(resp);
            
         //Now get the RegistryResponse as a String
         String respStr = sw.toString();
         //System.err.println("respStr = " + respStr);
            
         // Use Unicode (utf-8) to getBytes (server and client). Rely on platform default encoding is not safe.
         ByteArrayInputStream utf8 = new ByteArrayInputStream(respStr.getBytes("utf-8"));
         InputStream soapStream = Utility.getInstance().createSOAPStreamFromRequestStream(utf8);

         boolean signRequired = Boolean.valueOf(RegistryProperties.getInstance()
            .getProperty("ebxmlrr.interfaces.soap.signedResponse"))
            .booleanValue();

         if(signRequired)
         {
            AuthenticationServiceImpl auService = AuthenticationServiceImpl.getInstance();
            PrivateKey privateKey = auService.getPrivateKey(AuthenticationServiceImpl.
               ALIAS_REGISTRY_OPERATOR, AuthenticationServiceImpl.ALIAS_REGISTRY_OPERATOR);
            java.security.cert.Certificate[] certs = auService.getCertificateChain(
               AuthenticationServiceImpl.ALIAS_REGISTRY_OPERATOR);
            ByteArrayOutputStream os = new ByteArrayOutputStream();
            // File soapFile = new File("signedResponse.xml");
            // FileOutputStream os = new FileOutputStream(soapFile);
            SecurityUtil.getInstance().signSOAPMessage(soapStream, os, privateKey, certs,
               org.apache.xml.security.signature.XMLSignature.ALGO_ID_SIGNATURE_DSA);
            soapStream = new ByteArrayInputStream(os.toByteArray());
         }

         msg = Utility.getInstance().createSOAPMessageFromSOAPStream(soapStream);
         // msg.writeTo(new FileOutputStream(new File("signedResponse.xml")));
         soapStream.close();
      }
      catch(IOException e)
      {
         e.printStackTrace();
      }
      catch(SOAPException e)
      {
         e.printStackTrace();
      }
      catch(org.exolab.castor.xml.MarshalException e)
      {
         e.printStackTrace();
      }
      catch(org.exolab.castor.xml.ValidationException e)
      {
         e.printStackTrace();
      }
      catch(ParseException e)
      {
         e.printStackTrace();
      }
      catch(RegistryException e)
      {
         e.printStackTrace();
      }

      return msg;
   }

   private RepositoryItem processAttachment(AttachmentPart ap) throws RegistryException
   {
      RepositoryItem ri = null;

      try
      {
         //Make sure it is a multipart/related
         //if (!(ap.getContentType().equalsIgnoreCase("multipart/related"))) {
         //	throw new RegistryException("Attachement's must have content type 'multipart/related'");
         //}
            
         //ContentId is the id of the repositoryItem
         String id = ap.getContentId();
         System.err.println("Processing attachment with contentId: '" + id + "'");

         Object obj = ap.getContent();

         if(!(obj instanceof javax.mail.internet.MimeMultipart))
         {
            throw new RegistryException("Expected javax.mail.internet.MimeMultipart got " + obj.getClass().getName());
         }
            
         //The Multipart should have two BodyParts. First is the signature, second is the payload
         MimeMultipart mp = (MimeMultipart) obj;

         if(mp.getCount() != 2)
         {
            throw new RegistryException(
               "Found " +
               mp.getCount() +
               " BodyParts. A Multipart for a RepositoryItem must have exactly 2 BodyParts. First is the signature, second is the repository item.");
         }

         BodyPart bp1 = mp.getBodyPart(0);	//The XMLSignature
         BodyPart bp2 = mp.getBodyPart(1);	//The repository item
         //System.out.println("bp2.getContentType() =======> " + bp2.getContentType());
            
         //Need to populate the sig and dh from the bp1 and bp2
         javax.xml.parsers.DocumentBuilderFactory dbf =
            javax.xml.parsers.DocumentBuilderFactory.newInstance();

         dbf.setNamespaceAware(true);
         javax.xml.parsers.DocumentBuilder db = dbf.newDocumentBuilder();
         org.w3c.dom.Document sigDoc = db.parse(bp1.getInputStream());
            
            
         /*
         Here we create a XMLSignature object and Document just for the sake for saving the signature
         to disk. It is inefficient why not we just get the bytes and save it directly???? It involves
         some changes in RepositoryItem and RepositoryManager.
          */
         XMLSignature payloadSignature = new XMLSignature(sigDoc.getDocumentElement(), "");
            
         //Verify that the repository item has not been tampered with during transit
         System.err.println("Verifying payload signature for the payload with id ='" + id + "'");
         if(!SecurityUtil.getInstance().verifyPayloadSignature(id, mp))
         {
            throw new RegistryException("Failed to verify payload signature on incoming SOAP message" +
               " for contentId = '" + id + "'.");
         }

         DataHandler dh = bp2.getDataHandler();
         //System.out.println("dh.getContentType() =======> " + dh.getContentType());
            
         ri = new RepositoryItem(id, payloadSignature, dh);

      }
      catch(SOAPException e)
      {
         throw new RegistryException(e);
      }
      catch(MessagingException e)
      {
         throw new RegistryException(e);
      }
      catch(javax.xml.parsers.ParserConfigurationException e)
      {
         throw new RegistryException(e);
      }
      catch(IOException e)
      {
         throw new RegistryException(e);
      }
      catch(org.xml.sax.SAXException e)
      {
         throw new RegistryException(e);
      }

      catch(org.apache.xml.security.signature.XMLSignatureException e)
      {
         throw new RegistryException(e);
      }

      catch(org.apache.xml.security.exceptions.XMLSecurityException e)
      {
         throw new RegistryException(e);
      }

      return ri;
   }

   public Object getRequestObject(String rootElement, Node message)
      throws RegistryException
   {
      Class reqType = null;
      Object req = null;

      try
      {
         if(rootElement.equals("AdhocQueryRequest"))
         {
            reqType = org.oasis.ebxml.registry.bindings.query.AdhocQueryRequest.class;
         }
         else if(rootElement.equals("GetContentRequest"))
         {
            reqType = org.oasis.ebxml.registry.bindings.query.GetContentRequest.class;
         }
         else if(rootElement.equals("ApproveObjectsRequest"))
         {
            reqType = org.oasis.ebxml.registry.bindings.rs.ApproveObjectsRequest.class;
         }
         else if(rootElement.equals("DeprecateObjectsRequest"))
         {
            reqType = org.oasis.ebxml.registry.bindings.rs.DeprecateObjectsRequest.class;
         }
         else if(rootElement.equals("AddSlotsRequest"))
         {
            reqType = org.oasis.ebxml.registry.bindings.rs.AddSlotsRequest.class;
         }
         else if(rootElement.equals("RemoveObjectsRequest"))
         {
            reqType = org.oasis.ebxml.registry.bindings.rs.RemoveObjectsRequest.class;
         }
         else if(rootElement.equals("RemoveSlotsRequest"))
         {
            reqType = org.oasis.ebxml.registry.bindings.rs.RemoveSlotsRequest.class;
         }
         else if(rootElement.equals("SubmitObjectsRequest"))
         {
            reqType = SubmitObjectsRequest.class;
         }
         else if(rootElement.equals("UpdateObjectsRequest"))
         {
            reqType = org.oasis.ebxml.registry.bindings.rs.UpdateObjectsRequest.class;
         }
         else
         {
            throw new RegistryException("InvalidRequest: Unknown element " + rootElement);
         }

         Unmarshaller unmarshaller = new Unmarshaller(reqType);
         StringReader sr = new StringReader(message.asXML());
         req = unmarshaller.unmarshal(sr);
      }
      catch(org.exolab.castor.xml.MarshalException e)
      {
         throw new RegistryException(e);
      }
      catch(org.exolab.castor.xml.ValidationException e)
      {
         throw new RegistryException(e);
      }

      return req;
   }

   static void putHeaders(MimeHeaders headers, HttpServletResponse res)
   {
      Iterator it = headers.getAllHeaders();
      while(it.hasNext())
      {
         MimeHeader header = (MimeHeader) it.next();

         String[] values = headers.getHeader(header.getName());
         if(values.length == 1)
         {
            res.setHeader(header.getName(), header.getValue());
         }
         else
         {
            StringBuffer concat = new StringBuffer();
            int i = 0;
            while(i < values.length)
            {
               if(i != 0)
               {
                  concat.append(',');
               }
               concat.append(values[i++]);
            }

            res.setHeader(header.getName(), concat.toString());
         }
      }
   }
}
