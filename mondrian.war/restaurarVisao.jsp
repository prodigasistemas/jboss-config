<%@page import="java.beans.XMLDecoder"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="org.apache.commons.fileupload.*"%>
<%@page import="com.tonbeller.wcf.bookmarks.BookmarkManager"%>


<%
		byte[] uploadVisao = null;

		DiskFileUpload upload = new DiskFileUpload();
		List items = null;
		try {
			items = upload.parseRequest((HttpServletRequest)request);
		} catch (FileUploadException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		System.out.println(items);
		if (items != null) {

			FileItem item = null;
			Iterator iter = items.iterator();
			while (iter.hasNext()) {
				item = (FileItem) iter.next();
				if (item.getFieldName().equals("uploadVisao")) {
					if (item.get().length != 0) {
						// condiciona ao arquivo ser do tipo XML
						if (item.getName().toUpperCase().endsWith(".XML")) {
							// condiciona o arquivo ser menor que 200Kb ou
							// 204800 Bytes
							if (item.getSize() < 204800) {
								uploadVisao = item.get();
							} else {
								break;
							}

						} else {
							break;
						}
					}
				}

				XMLDecoder d = null;

				
				d = new XMLDecoder(new BufferedInputStream(
						new ByteArrayInputStream(uploadVisao)));

				Object state = d.readObject();

				d.close();

				BookmarkManager.instance(request.getSession())
						.restoreSessionState(state);
				

			}

		}



%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<meta http-equiv="refresh" content="0;url=testpage.jsp">
	</head>
	<body>
		<title>Carregando...</title>
		<h1>Aguarde enquanto a consulta &eacute; restaurada...</h1>
	</body>
</html>

