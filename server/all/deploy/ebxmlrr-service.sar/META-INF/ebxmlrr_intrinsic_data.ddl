--SQL Load file for creating loading factory defined data for ebXML Registry databse
--This is a bootstrapping step that cannot be done via normal registry interface
--Insert factory defined Users

--RegistryOperator
INSERT INTO User_ VALUES(null, 'urn:uuid:921284f0-bbed-4a4c-9342-ecaf0625f9d7', 'User', 'Farrukh.Najmi@Sun.COM', 'ebxmlrrOrgId', 'Registry', null, 'Operator', 'http://sourceforge.net/projects/ebxmlrr');
INSERT INTO PostalAddress VALUES('Burlington', 'USA', '01803', 'MA', 'Network Dr.', '1', 'urn:uuid:921284f0-bbed-4a4c-9342-ecaf0625f9d7');
INSERT INTO TelephoneNumber VALUES('781', '01', '', '442-0703', 'office', null, 'urn:uuid:921284f0-bbed-4a4c-9342-ecaf0625f9d7');
INSERT INTO EmailAddress VALUES('registryOperator@ebxmlrr.com', 'work', 'urn:uuid:921284f0-bbed-4a4c-9342-ecaf0625f9d7');
-- We make the owner of the User object to be the user itself.
INSERT INTO AuditableEvent VALUES(null, 'urn:uuid:b4d9a59b-baae-4f3a-98f0-8b5f8b38b316', 'AuditableEvent', 'Created', 'urn:uuid:921284f0-bbed-4a4c-9342-ecaf0625f9d7', '2002-09-09 10:58:07.453', 'urn:uuid:921284f0-bbed-4a4c-9342-ecaf0625f9d7');

--RegistryGuest
INSERT INTO User_ VALUES(null, 'urn:uuid:abfa78d5-605e-4dbc-b9ee-a42e99d5f7cf', 'User', 'Farrukh.Najmi@Sun.COM', 'ebxmlrrOrgId', 'Registry', null, 'Guest', 'http://sourceforge.net/projects/ebxmlrr');
INSERT INTO PostalAddress VALUES('Burlington', 'USA', '01803', 'MA', 'Network Dr.', '1', 'urn:uuid:abfa78d5-605e-4dbc-b9ee-a42e99d5f7cf');
INSERT INTO TelephoneNumber VALUES('781', '01', '', '442-0703', 'office', null, 'urn:uuid:abfa78d5-605e-4dbc-b9ee-a42e99d5f7cf');
INSERT INTO EmailAddress VALUES('registryGuest@ebxmlrr.com', 'work', 'urn:uuid:abfa78d5-605e-4dbc-b9ee-a42e99d5f7cf');
-- We make the owner of the User object to be the user itself.
INSERT INTO AuditableEvent VALUES(null, 'urn:uuid:026be466-25f7-40a0-bafd-c6f2cc1f1c8a', 'AuditableEvent', 'Created', 'urn:uuid:abfa78d5-605e-4dbc-b9ee-a42e99d5f7cf', '2002-09-09 10:58:07.453', 'urn:uuid:abfa78d5-605e-4dbc-b9ee-a42e99d5f7cf');

--Test user Farrukh
INSERT INTO User_ VALUES(null, 'urn:uuid:977d9380-00e2-4ce8-9cdc-d8bf6a4157be', 'User', 'Farrukh.Najmi@Sun.COM', 'urn:uuid:dafa4da3-1d92-4757-8fd8-ff2b8ce7a1bf', 'Farrukh', 'Salahudin', 'Najmi', 'http://java.sun.com/xml/jaxr');
INSERT INTO PostalAddress VALUES('Burlington', 'USA', '01803', 'MA', 'Network Dr.', '1', 'urn:uuid:977d9380-00e2-4ce8-9cdc-d8bf6a4157be');
INSERT INTO TelephoneNumber VALUES('781', '01', '', '442-0703', 'office', null, 'urn:uuid:977d9380-00e2-4ce8-9cdc-d8bf6a4157be');
INSERT INTO EmailAddress VALUES('farrukh.najmi@sun.com', 'work', 'urn:uuid:977d9380-00e2-4ce8-9cdc-d8bf6a4157be');
-- We make the owner of the User object to be the user itself.
INSERT INTO AuditableEvent VALUES(null, 'urn:uuid:0d93f93f-b7ac-4e49-bb30-dd4f15db2fd0', 'AuditableEvent', 'Created', 'urn:uuid:977d9380-00e2-4ce8-9cdc-d8bf6a4157be', '2002-09-09 10:58:07.453', 'urn:uuid:977d9380-00e2-4ce8-9cdc-d8bf6a4157be');

--Test user Nikola
INSERT INTO User_ VALUES(null, 'urn:uuid:85428d8e-1bd5-473b-a8c8-b9d595f82728', 'User', 'nikola.stojanovic@taraba.com', 'tarabaOrgId', 'Nikola', null, 'Stojanovic', 'http://java.sun.com/xml/jaxr');
INSERT INTO PostalAddress VALUES('Ithaca', 'France', null, 'NY', 'Terazije', '19', 'urn:uuid:85428d8e-1bd5-473b-a8c8-b9d595f82728');
INSERT INTO TelephoneNumber VALUES('11', '381', '', '222-2222', 'office', null, 'urn:uuid:85428d8e-1bd5-473b-a8c8-b9d595f82728');
INSERT INTO TelephoneNumber VALUES('11', '381', '', '444-4444', 'home', null, 'urn:uuid:85428d8e-1bd5-473b-a8c8-b9d595f82728');
INSERT INTO EmailAddress VALUES('nhomest1@twcny.rr.com', 'work', 'urn:uuid:85428d8e-1bd5-473b-a8c8-b9d595f82728');
-- We make the owner of the User object to be the user itself.
INSERT INTO AuditableEvent VALUES(null, 'urn:uuid:9e4dbee6-a04b-413b-9060-b7f5d2d335d1', 'AuditableEvent', 'Created', 'urn:uuid:85428d8e-1bd5-473b-a8c8-b9d595f82728', '2002-09-09 10:58:07.453', 'urn:uuid:85428d8e-1bd5-473b-a8c8-b9d595f82728');

--Test user CY
INSERT INTO User_ VALUES(null, 'urn:uuid:b2691323-4aad-46da-9dc7-a842b7e4b1ae', 'User', 'cyng@csis.hku.hk', 'uhkOrgId', 'Ng', 'Chi', 'Yuen', 'http://www.hku.hk');
INSERT INTO PostalAddress VALUES('Burlington', 'Hong Kong', '01803', 'MA', 'Network Dr.', '1', 'urn:uuid:b2691323-4aad-46da-9dc7-a842b7e4b1ae');
INSERT INTO TelephoneNumber VALUES('781', '01', '', '442-0703', 'office', null, 'urn:uuid:b2691323-4aad-46da-9dc7-a842b7e4b1ae');
INSERT INTO EmailAddress VALUES('cyng@csis.hku.hk', 'work', 'urn:uuid:b2691323-4aad-46da-9dc7-a842b7e4b1ae');
-- We make the owner of the User object to be the user itself.
INSERT INTO AuditableEvent VALUES(null, 'urn:uuid:64482d52-20e9-4d7f-b2c4-c1cfc28055fe', 'AuditableEvent', 'Created', 'urn:uuid:b2691323-4aad-46da-9dc7-a842b7e4b1ae', '2002-09-09 10:58:07.453', 'urn:uuid:b2691323-4aad-46da-9dc7-a842b7e4b1ae');

--Test user Adrian
INSERT INTO User_ VALUES(null, 'urn:uuid:bab82b84-7d63-44dd-b914-e72e0476c043', 'User', 'achong@eti.hku.hk', 'uhkOrgId', 'Adrian', null, 'Chong', 'http://www.hku.hk');
INSERT INTO PostalAddress VALUES('Burlington', 'Hong Kong', '01803', 'MA', 'Network Dr.', '1', 'urn:uuid:bab82b84-7d63-44dd-b914-e72e0476c043');
INSERT INTO TelephoneNumber VALUES('781', '01', '', '442-0703', 'office', null, 'urn:uuid:bab82b84-7d63-44dd-b914-e72e0476c043');
INSERT INTO EmailAddress VALUES('achong@eti.hku.hk', 'work', 'urn:uuid:bab82b84-7d63-44dd-b914-e72e0476c043');
-- We make the owner of the User object to be the user itself.
INSERT INTO AuditableEvent VALUES(null, 'urn:uuid:8cc26a1e-22ac-4538-8f85-fc48b16e2f8b', 'AuditableEvent', 'Created', 'urn:uuid:bab82b84-7d63-44dd-b914-e72e0476c043', '2002-09-09 10:58:07.453', 'urn:uuid:bab82b84-7d63-44dd-b914-e72e0476c043');

--CTS USERS FOR JBOSS
insert into USER_ values (null, 'cts', 'User', 'cts@jboss.org', 'JBoss Inc.', 'CTS', null, 'Tests', 'http://www.jboss.org');
insert into USER_ values (null, 'cts2', 'User', 'cts@jboss.org', 'JBoss Inc.', 'CTS', null, 'Tests', 'http://www.jboss.org');

--JBoss related change by Anil: The following id was always being complianed by ebxmlrr load scripts. Need to find out who actually loads it
INSERT INTO User_ VALUES(null, 'urn:uuid:4a13dacb-a9e8-4819-bd1a-faf50976e5d4', 'User', ' ', 'uhkOrgId', 'Jboss', null, 'Admin', 'http://www.jboss.org');
INSERT INTO PostalAddress VALUES('Atlanta', 'USA', '01803', 'MA', 'Network Dr.', '1', 'urn:uuid:4a13dacb-a9e8-4819-bd1a-faf50976e5d4');
INSERT INTO TelephoneNumber VALUES('781', '01', '', '442-0703', 'office', null, 'urn:uuid:4a13dacb-a9e8-4819-bd1a-faf50976e5d4');
INSERT INTO EmailAddress VALUES('jaxr@jboss.com', 'work', 'urn:uuid:4a13dacb-a9e8-4819-bd1a-faf50976e5d4');
-- We make the owner of the User object to be the user itself.
INSERT INTO AuditableEvent VALUES(null, 'urn:uuid:8cx26a1e-22ac-4638-8f85-fc58b16e2f8b', 'AuditableEvent', 'Created', 'urn:uuid:4a13dacb-a9e8-4819-bd1a-faf50976e5d4', '2004-08-27 10:58:07.453', 'urn:uuid:4a13dacb-a9e8-4819-bd1a-faf50976e5d4');

--Anil: Need to find out where the following entry into table ClassScheme gets loaded
insert into classscheme values(null,'urn:uuid:6902675f-2f18-44b8-888b-c91db8b96b4d','ClassificationScheme',null,1,0,null,'Approved',null,'Y','UniqueCode');