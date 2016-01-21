--$Header: /cvsroot/jboss/contrib/varia/src/resources/jaxr/ebxmlrr_create.ddl,v 1.1 2004/09/01 03:25:15 osdchicago Exp $
--SQL Load file for creating the starter ebXML Registry databse

-- Workaround for the databases:
--
--  Oracle:
--      - Oracle does not support boolean field. So the we have to use VARCHAR(1)         
--      - Timestamp field does not allow to have timezone (e.g. +8). We use 
--        VARCHAR(30) to store timestamp. The field type 'timestamp with time
--        zone' is not available in other databases. 
--  DB2:
--      - Some of the names of tables and indexed have been shortened to below 18 
--        characters to accommodate the limit

CREATE TABLE Association ( accessControlPolicy	VARCHAR(64), id				VARCHAR(64) NOT NULL PRIMARY KEY, objectType		VARCHAR(64) , associationType	VARCHAR(128) NOT NULL, sourceObject		VARCHAR(64) NOT NULL, targetObject  	VARCHAR(64) NOT NULL, isConfirmedBySourceOwner    VARCHAR(1), isConfirmedByTargetOwner	VARCHAR(1));

CREATE TABLE AuditableEvent ( accessControlPolicy	VARCHAR(64), id				VARCHAR(64) NOT NULL PRIMARY KEY, objectType		VARCHAR(64) , eventType			VARCHAR(128) NOT NULL, registryObject	VARCHAR(64) NOT NULL, timeStamp_        VARCHAR(30) NOT NULL, user_				VARCHAR(64) NOT NULL);

CREATE TABLE Classification ( accessControlPolicy	VARCHAR(64), id				VARCHAR(64) NOT NULL PRIMARY KEY, objectType		VARCHAR(64), classificationNode		VARCHAR(64), classificationScheme		VARCHAR(64), classifiedObject			VARCHAR(64) NOT NULL, nodeRepresentation		VARCHAR(128));


CREATE TABLE ClassificationNode ( accessControlPolicy	VARCHAR(64), id				VARCHAR(64) NOT NULL PRIMARY KEY, objectType		VARCHAR(64), code					VARCHAR(64), parent				VARCHAR(64), path					VARCHAR(1024));


CREATE TABLE ClassScheme ( accessControlPolicy	VARCHAR(64), id				VARCHAR(64) NOT NULL PRIMARY KEY, objectType		VARCHAR(64), expiration		VARCHAR(30), majorVersion		INT NOT NULL, minorVersion		INT NOT NULL, stability			VARCHAR(128), status			VARCHAR(128) NOT NULL, userVersion		VARCHAR(64), isInternal		VARCHAR(1) NOT NULL, nodeType			VARCHAR(32) NOT NULL);

CREATE TABLE ExternalIdentifier ( accessControlPolicy	VARCHAR(64), id				VARCHAR(64) NOT NULL PRIMARY KEY, objectType		VARCHAR(64), registryObject	VARCHAR(64) NOT NULL, identificationScheme		VARCHAR(64) NOT NULL, value				VARCHAR(64) NOT NULL);

CREATE TABLE ExternalLink ( accessControlPolicy	VARCHAR(64), id				VARCHAR(64) NOT NULL PRIMARY KEY, objectType		VARCHAR(64), externalURI		VARCHAR(256) NOT NULL	  );

CREATE TABLE ExtrinsicObject ( accessControlPolicy	VARCHAR(64), id				VARCHAR(64) NOT NULL PRIMARY KEY, objectType		VARCHAR(64), expiration		VARCHAR(30), majorVersion		INT NOT NULL, minorVersion		INT NOT NULL, stability			VARCHAR(128), status			VARCHAR(128) NOT NULL, userVersion		VARCHAR(64), isOpaque			VARCHAR(1) NOT NULL, mimeType			VARCHAR(128));

CREATE TABLE Name_ ( charset			VARCHAR(32), lang				VARCHAR(32) NOT NULL, value				VARCHAR(256) NOT NULL, parent			VARCHAR(64) NOT NULL,	PRIMARY KEY (parent, lang, value));

CREATE TABLE Description ( charset			VARCHAR(32), lang				VARCHAR(32) NOT NULL, value				VARCHAR(256) NOT NULL, parent			VARCHAR(64) NOT NULL,	PRIMARY KEY (parent, lang, value)	);

CREATE TABLE UsageDescription ( charset			VARCHAR(32), lang				VARCHAR(32) NOT NULL, value				VARCHAR(256) NOT NULL, parent			VARCHAR(64) NOT NULL,	PRIMARY KEY (parent, lang, value)	);

CREATE TABLE Organization ( accessControlPolicy	VARCHAR(64), id				VARCHAR(64) NOT NULL PRIMARY KEY, objectType		VARCHAR(64) , parent			VARCHAR(64),	primaryContact	VARCHAR(64) NOT NULL);

CREATE TABLE RegistryPackage ( accessControlPolicy	VARCHAR(64), id				VARCHAR(64) NOT NULL PRIMARY KEY, objectType		VARCHAR(64) , expiration		VARCHAR(30), majorVersion		INT NOT NULL, minorVersion		INT NOT NULL, stability			VARCHAR(128), status			VARCHAR(128) NOT NULL, userVersion		VARCHAR(64));

CREATE TABLE PostalAddress ( city				VARCHAR(64), country			VARCHAR(64), postalCode		VARCHAR(64), state				VARCHAR(64), street			VARCHAR(64), streetNumber		VARCHAR(32), parent			VARCHAR(64) NOT NULL);

CREATE TABLE EmailAddress ( address			VARCHAR(64) NOT NULL, type				VARCHAR(32), parent			VARCHAR(64) NOT NULL);
 
CREATE TABLE Service ( accessControlPolicy	VARCHAR(64), id				VARCHAR(64) NOT NULL PRIMARY KEY, objectType		VARCHAR(64) , expiration		VARCHAR(30), majorVersion		INT NOT NULL, minorVersion		INT NOT NULL, stability			VARCHAR(128), status			VARCHAR(128) NOT NULL, userVersion		VARCHAR(64));

CREATE TABLE ServiceBinding ( accessControlPolicy	VARCHAR(64), id				VARCHAR(64) NOT NULL PRIMARY KEY, objectType		VARCHAR(64), service			VARCHAR(64) NOT NULL, accessURI			VARCHAR(256), targetBinding		VARCHAR(64));

--Multiple rows of Slot make up a single Slot
CREATE TABLE Slot ( sequenceId		INT NOT NULL, name_				VARCHAR(128) NOT NULL, slotType			VARCHAR(128),			value				VARCHAR(128), parent			VARCHAR(64) NOT NULL, PRIMARY KEY (parent, name_, sequenceId));

CREATE TABLE SpecificationLink ( accessControlPolicy	VARCHAR(64), id				VARCHAR(64) NOT NULL PRIMARY KEY, objectType		VARCHAR(64), service			VARCHAR(64) NOT NULL, serviceBinding	VARCHAR(64) NOT NULL, specificationObject VARCHAR(64) NOT NULL);

CREATE TABLE UsageParameter ( value				VARCHAR(256) NOT NULL, parent			VARCHAR(64) NOT NULL);

CREATE TABLE TelephoneNumber ( areaCode			VARCHAR(4), countryCode		VARCHAR(4), extension			VARCHAR(8), number_			VARCHAR(16), phoneType			VARCHAR(32), url				VARCHAR(256), parent			VARCHAR(64) NOT NULL);

CREATE TABLE User_ ( accessControlPolicy	VARCHAR(64), id				VARCHAR(64) NOT NULL PRIMARY KEY, objectType		VARCHAR(64), email				VARCHAR(128) NOT NULL, organization		VARCHAR(64) NOT NULL, personName_firstName	VARCHAR(64), personName_middleName	VARCHAR(64), personName_lastName	VARCHAR(64), url				VARCHAR(256));

CREATE VIEW RegistryObject ( accessControlPolicy, id, objectType) AS SELECT accessControlPolicy, id, objectType FROM Association UNION SELECT accessControlPolicy, id, objectType FROM AuditableEvent UNION SELECT accessControlPolicy, id, objectType FROM Classification UNION SELECT accessControlPolicy, id, objectType FROM ClassificationNode UNION SELECT accessControlPolicy, id, objectType FROM ClassScheme UNION SELECT accessControlPolicy, id, objectType FROM ExternalIdentifier UNION SELECT accessControlPolicy, id, objectType FROM ExternalLink UNION SELECT accessControlPolicy, id, objectType FROM ExtrinsicObject UNION SELECT accessControlPolicy, id, objectType FROM Organization UNION SELECT accessControlPolicy, id, objectType FROM RegistryPackage UNION SELECT accessControlPolicy, id, objectType FROM Service UNION SELECT accessControlPolicy, id, objectType FROM ServiceBinding UNION SELECT accessControlPolicy, id, objectType FROM SpecificationLink UNION SELECT accessControlPolicy, id, objectType FROM User_ ;

CREATE VIEW RegistryEntry ( accessControlPolicy, id, objectType, expiration, majorVersion, minorVersion, stability, status, userVersion) AS SELECT accessControlPolicy, id, objectType, expiration, majorVersion, minorVersion, stability, status, userVersion FROM ClassScheme UNION SELECT accessControlPolicy, id, objectType, expiration, majorVersion, minorVersion, stability, status, userVersion FROM ExtrinsicObject UNION SELECT accessControlPolicy, id, objectType, expiration, majorVersion, minorVersion, stability, status, userVersion FROM RegistryPackage;

--Following is a partial list of indexes. Will need to add more.
--name index
CREATE INDEX Name_i1 ON Name_(value);
CREATE INDEX Name_i2 ON Name_(lang, value);
--description index
CREATE INDEX Description_i1 ON Description(value);
CREATE INDEX Description_i2 ON Description(lang, value);
--UsageDescription index
CREATE INDEX UsageDescription_i1 ON UsageDescription(value);
CREATE INDEX UsageDescription_i2 ON UsageDescription(lang, value);
--Indexes on Association
CREATE INDEX Association_i1 ON Association(sourceObject);
CREATE INDEX Association_i2 ON Association(targetObject);
CREATE INDEX Association_i3 ON Association(associationType);
--Indexes on Classification
CREATE INDEX Classification_i1 ON Classification(classifiedObject);
CREATE INDEX Classification_i2 ON Classification(classificationNode);
--Indexes on ClassificationNode
CREATE INDEX ClassificationNode_i1 ON ClassificationNode(parent);
CREATE INDEX ClassificationNode_i2 ON ClassificationNode(code);
CREATE INDEX ClassificationNode_i3 ON ClassificationNode(path);
--Indexes on ExternalIdentifier
CREATE INDEX ExternalIdentifier_i1 ON ExternalIdentifier(registryObject);
--Indexes on ExternalLink
CREATE INDEX ExternalLink_i1 ON ExternalLink(externalURI);
--Indexes on ExtrinsicObject
CREATE INDEX ExtrinsicObject_i1 ON ExtrinsicObject(status);
--Indexes on Organization
CREATE INDEX Organization_i1 ON Organization(parent);
--Indexes on PostalAddress
CREATE INDEX PostalAddress_i1 ON PostalAddress(parent);
CREATE INDEX PostalAddress_i2 ON PostalAddress(city);
CREATE INDEX PostalAddress_i3 ON PostalAddress(country);
CREATE INDEX PostalAddress_i4 ON PostalAddress(postalCode);
--Indexes on EmailAddress
CREATE INDEX EmailAddress_i1 ON EmailAddress(parent);
--Indexes on ServiceBinding
CREATE INDEX ServiceBinding_i1 ON ServiceBinding(service);
--Indexes on Slot
CREATE INDEX Slot_i1 ON Slot(parent);
CREATE INDEX Slot_i2 ON Slot(name_);
--Indexes on SpecificationLink
CREATE INDEX SpecificationLink_i1 ON SpecificationLink(service);
CREATE INDEX SpecificationLink_i2 ON SpecificationLink(serviceBinding);
CREATE INDEX SpecificationLink_i3 ON SpecificationLink(specificationObject);
--Indexes on TelephoneNumber
CREATE INDEX TelephoneNumber_i1 ON TelephoneNumber(parent);
--Indexes on User
CREATE INDEX User_i1 ON User_(organization);
CREATE INDEX User_i2 ON User_(personName_lastName);

--id index
-- FOR ORACLE, YOU MUST COMMMENT ALL THE FOLLOWING LINES BECAUSE ORACLE DOES
-- NOT ALLOW CREATE INDEX ON PRIMARY KEYS
--
CREATE INDEX Association_id ON Association(id);
CREATE INDEX AuditableEvent_id ON AuditableEvent(id);
CREATE INDEX Classification_id ON Classification(id);
CREATE INDEX ClassificationNode_id ON ClassificationNode(id);
CREATE INDEX ClassScheme_id ON ClassScheme(id);
CREATE INDEX ExternalIdentifier_id ON ExternalIdentifier(id);
CREATE INDEX ExternalLink_id ON ExternalLink(id);
CREATE INDEX ExtrinsicObject_id ON ExtrinsicObject(id);
CREATE INDEX Organization_id ON Organization(id);
CREATE INDEX RegistryPackage_id ON RegistryPackage(id);
CREATE INDEX Service_id ON Service(id);
CREATE INDEX ServiceBinding_id ON ServiceBinding(id);
CREATE INDEX SpecificationLink_id ON SpecificationLink(id);
CREATE INDEX User_id ON User_(id);
