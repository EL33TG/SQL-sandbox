
-- Author: Brenden Boswell
-- MySQL Database Creation
-- Creating Table with Constraint and Triggers
-- Creating Views for psuedo business logic
 
CREATE TABLE IF NOT EXISTS DBO.STATE (
    StateID INT NOT NULL AUTO_INCREMENT,
    StateCode VARCHAR(2) NOT NULL,
    StateName VARCHAR(70) UNIQUE NOT NULL,
    StateTax DOUBLE,
    PRIMARY KEY (StateID)
);

CREATE TABLE IF NOT EXISTS DBO.ADDRESS (
    AddressID INT NOT NULL AUTO_INCREMENT,
    Address1 VARCHAR(100),
    Address2 VARCHAR(100),
    City VARCHAR(14),
    StateID INT,
    ZipCode INT,
    ExtendedZip INT,
    Country VARCHAR(50),
    Modified_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    Created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (AddressID)
);

CREATE TABLE IF NOT EXISTS DBO.ADDRESS_TYPE (
    AddressTypeID INT NOT NULL AUTO_INCREMENT,
    AddressID INT UNIQUE,
	AddressType VARCHAR(40),
    PRIMARY KEY (AddressTypeID)
);

CREATE TABLE IF NOT EXISTS DBO.PERSON (
    PersonID INT NOT NULL AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    MiddleInitial VARCHAR(1),
    LastName VARCHAR(50),
    DOB VARCHAR(8),
    SSN INT(9) NOT NULL UNIQUE,
    -- PersonType VARCHAR(8) NOT NULL,
    PersonTypeID INT,
	Modified_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    Created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (PersonID)
);

CREATE TABLE IF NOT EXISTS DBO.PERSON_TYPE (
    PersonTypeID INT NOT NULL AUTO_INCREMENT,
	-- PersonID INT NOT NULL,
	PersonType VARCHAR(8) UNIQUE,
	PRIMARY KEY (PersonTypeID)
);

CREATE TABLE IF NOT EXISTS DBO.JOB_TITLE (
    JobTitleID INT NOT NULL AUTO_INCREMENT,
	JobTitleTypeID INT,
    PersonID INT NOT NULL,
	PRIMARY KEY (JobTitleID)
);
CREATE TABLE IF NOT EXISTS DBO.JOB_TITLE_TYPE (
    JobTitleTypeID INT NOT NULL AUTO_INCREMENT,
	JobTitleType VARCHAR(40) UNIQUE,
	PRIMARY KEY (JobTitleTypeID)
);

CREATE TABLE IF NOT EXISTS DBO.MANAGER_TYPE (
    ManagerTypeID INT NOT NULL AUTO_INCREMENT,
	ManagerType VARCHAR(10),
  --  LocationID INT NOT NULL,
    PRIMARY KEY (ManagerTypeID)
);

CREATE TABLE IF NOT EXISTS DBO.DIRECT_REPORT (
    DirectReportID INT NOT NULL AUTO_INCREMENT,
    ManagerID INT UNIQUE,
    ManagerFirstName VARCHAR(40),
    ManagerLastName VARCHAR(40),
	-- DirectReport INT,
    -- LocationID INT,
    PRIMARY KEY (DirectReportID)
);

CREATE TABLE IF NOT EXISTS DBO.EMPLOYEE (
    EmployeeID INT NOT NULL AUTO_INCREMENT,
    -- EmployeeNumber INT NOT NULL AUTO_INCREMENT,
    PersonID INT NOT NULL,
    AddressTypeID INT,
    JobTitleTypeID INT,
    DirectReportID INT,
    DepartmentID INT ,
    BenefitID INT,
    FacilityID INT,
    PayID INT,
    PRIMARY KEY (EmployeeID),
    KEY (AddressTypeID)
);


CREATE TABLE IF NOT EXISTS DBO.CUSTOMER (
    CustomerID INT NOT NULL AUTO_INCREMENT,
	PersonID INT NOT NULL,
    AddressTypeID INT ,
    SalesPersonID INT,
    CustDiscGen DOUBLE,
    CustDiscProp CHAR ,
    CustDiscAppr CHAR ,
    ContactDate DATETIME ,
    TaxExempt CHAR,
    PRIMARY KEY (CustomerID),
    KEY (AddressTypeID)
);


#### CREATE DELIVERY ####
CREATE TABLE IF NOT EXISTS DBO.DELIVERY (
DeliveryID INT NOT NULL, 
Shipped CHAR NOT NULL, -- When value --> ShipDateTime automatically pop
ShipDate DATETIME NOT NULL DEFAULT(now()),  -- Time included with DateTime
Received CHAR NOT NULL, -- When value --> ReceivedDateTime automatically pop
ReceivedDate DATETIME NOT NULL DEFAULT(now()),
primary key (DeliveryID)
);

CREATE TABLE IF NOT EXISTS DBO.FACILITY (
    FacilityID INT NOT NULL AUTO_INCREMENT,
    FacilityName VARCHAR(100) NOT NULL UNIQUE,
    FacilityType VARCHAR(20) NOT NULL,
	Modified_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    Created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    -- FacilityLocationID VARCHAR(100) NOT NULL,
    PRIMARY KEY (FacilityID)
);

CREATE TABLE IF NOT EXISTS DBO.FACILITY_ADD_LK (
    FacilityTypeID INT NOT NULL,
   -- FacilityID INT NOT NULL,
    AddressTypeID INT,
    PRIMARY KEY (FacilityTypeID)
);

CREATE TABLE IF NOT EXISTS DBO.DEPARTMENT (
    DepartmentID INT NOT NULL AUTO_INCREMENT,
    DepartmentType VARCHAR(20) UNIQUE NOT NULL,
    LocationID INT,
    PRIMARY KEY (DepartmentID)
);

#### CREATE ACCOUNTS_PAYABLE ####
CREATE TABLE IF NOT EXISTS DBO.ACCOUNTS_PAYABLE (
DebitTransactionID INT NOT NULL AUTO_INCREMENT,
PayeeID INT NOT NULL, -- FK
DebitAmt DOUBLE NOT NULL,
DebitDate DOUBLE NOT NULL DEFAULT(now()), -- AutoFill when DebitAmt populated
primary key (DebitTransactionID)
);

#### CREATE ACCOUNTS_RECEIVABLE ####
CREATE TABLE IF NOT EXISTS DBO.ACCOUNTS_RECEIVABLE (
CreditTransactionID INT NOT NULL AUTO_INCREMENT,
PayeeID INT NOT NULL, -- FK
CreditAmt DOUBLE NOT NULL,
CreditDate DOUBLE NOT NULL DEFAULT(now()), -- AutoFill when DebitAmt populated
primary key (CreditTransactionID)
);

CREATE TABLE IF NOT EXISTS DBO.EMPLOYEE_BENEFITS (
    BenefitID INT NOT NULL AUTO_INCREMENT,
    Medical CHAR DEFAULT ('Y'),
    Dental CHAR DEFAULT ('Y'),
    Vision CHAR DEFAULT ('Y'),
    RetirementPlan CHAR DEFAULT ('Y'),
    PRIMARY KEY (BenefitID)
);

CREATE TABLE IF NOT EXISTS DBO.SURVEY (
    SurveyID INT NOT NULL AUTO_INCREMENT,
    SurveyDate VARCHAR(20) NOT NULL,
    SalespersonScore DOUBLE,
    QualityScore DOUBLE,
    AccuracyScore DOUBLE,
    Complaint VARCHAR(100),
    Comments VARCHAR(100),
    PRIMARY KEY (SurveyID)
);


CREATE TABLE IF NOT EXISTS DBO.FEE (
    FeeTypeId INT NOT NULL AUTO_INCREMENT,
    FeeType VARCHAR(20) UNIQUE,
    FeeAmt INT,
    PRIMARY KEY (FeeTypeID)
);


CREATE TABLE IF NOT EXISTS DBO.ORDERED (
    OrderID INT NOT NULL AUTO_INCREMENT,
	ProductID INT,
    OrderType VARCHAR(20),
    PersonID INT,
    Shipped CHAR,
    Quantity INT NOT NULL,
    PRIMARY KEY (OrderID)
);

CREATE TABLE IF NOT EXISTS DBO.PRODUCT (
    ProductID INT NOT NULL AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Cost DOUBLE,
    PRIMARY KEY (ProductID)
);

CREATE TABLE IF NOT EXISTS DBO.PART (
    PartID INT NOT NULL AUTO_INCREMENT,
    PartType VARCHAR(20) NOT NULL,
    ProductID INT,
    LocationID INT,
    Cost DOUBLE,
    ReorderPoint INT NOT NULL,
    PRIMARY KEY (PartID)
);

CREATE TABLE IF NOT EXISTS DBO.CONTAINER (
    ContainerID INT NOT NULL,
    LocationID INT,
    FacilityID INT, -- Warehouse
    PRIMARY KEY (ContainerID)
);

CREATE TABLE IF NOT EXISTS DBO.PART_CONTAINER (
    PartID INT NOT NULL AUTO_INCREMENT,
    ContainerID INT NOT NULL,
    PRIMARY KEY (PartID)
);


CREATE TABLE IF NOT EXISTS DBO.SALESPERSON_FOR (
    SalesNumber INT NOT NULL AUTO_INCREMENT, -- Ref EmployeeID was SalesPersonID
    JobTitleID INT UNIQUE,
    CustomerID INT,
    OrderDate DATETIME NOT NULL,
    PRIMARY KEY (SalesNumber)
);

CREATE TABLE IF NOT EXISTS DBO.PAY_TYPE (
    PayTypeID INT NOT NULL AUTO_INCREMENT,
    PayType VARCHAR(8) UNIQUE,
    PRIMARY KEY (PayTypeID)
);


CREATE TABLE IF NOT EXISTS DBO.PAY (
    PayID INT NOT NULL AUTO_INCREMENT,
    PayTypeID INT,
    HourlyAmt DOUBLE DEFAULT(0.01),
    SalaryAmt INT DEFAULT(0),
    PRIMARY KEY (PayID)
);

CREATE TABLE IF NOT EXISTS DBO.LOCATION (
    LocationID INT NOT NULL AUTO_INCREMENT,
    LocationType VARCHAR(50) UNIQUE,
    Location VARCHAR(50),
    PRIMARY KEY (LocationID)
);


## CONSTRAINTS

ALTER TABLE DBO.CUSTOMER
ADD CONSTRAINT fk_cust_delete_ref 
    FOREIGN KEY (PersonID)
        REFERENCES dbo.PERSON (PersonID)
        ON DELETE CASCADE;
        
ALTER TABLE DBO.DIRECT_REPORT
ADD CONSTRAINT fk_dr_delete_ref 
    FOREIGN KEY (ManagerID)
        REFERENCES dbo.EMPLOYEE (EmployeeID)
        ON DELETE CASCADE;

      
ALTER TABLE DBO.ADDRESS_TYPE
ADD CONSTRAINT fk_add_delete_ref 
    FOREIGN KEY (AddressID)
        REFERENCES dbo.ADDRESS (AddressID)
        ON DELETE CASCADE;
        
        
## ALL INCREMEMENTED VALUES ##
	ALTER TABLE DBO.PERSON AUTO_INCREMENT = 201900; -- ALl people in system start with 201900
    ALTER TABLE DBO.EMPLOYEE AUTO_INCREMENT = 11000; -- All emp numbers in system start with 11000
    ALTER TABLE DBO.EMPLOYEE_BENEFITS AUTO_INCREMENT = 9000; -- ALl employee benefits id in system start with 9000
    ALTER TABLE DBO.ADDRESS_TYPE AUTO_INCREMENT = 10;  -- ALl address id in system start with 10
    ALTER TABLE DBO.FACILITY AUTO_INCREMENT = 100; -- ALl Facility id in system start with 100
    ALTER TABLE DBO.JOB_TITLE_TYPE AUTO_INCREMENT = 10;  -- ALl Job id in system start with 10
    
    ## PERSON TABLE INDERST TRIGGER ###

DROP TRIGGER IF EXISTS dbo . ins_type;
DROP TRIGGER IF EXISTS dbo . delete_addr;
DROP TRIGGER IF EXISTS dbo . ins_facil;
DROP TRIGGER IF EXISTS dbo . ins_jobtype;
DROP TRIGGER IF EXISTS dbo . up_customer;

DELIMITER $$
CREATE TRIGGER  dbo . ins_type AFTER INSERT ON DBO.PERSON FOR EACH ROW 
BEGIN

DECLARE pid INT;
DECLARE paid INT;
DECLARE aID INT;
DECLARE addID INT;
DECLARE cid INT;
DECLARE firstType VARCHAR(8);
--
SELECT max(PersonID) FROM dbo.person limit 1
INTO pid;
--
SELECT PersonTypeID FROM dbo.person Order By PersonID DESC limit 1
INTO firstType;
	-- INSERT INTO DBO.PERSON_TYPE (PersonID, PersonType) VALUES (pid, firstType);
	INSERT INTO DBO.ADDRESS () VALUES(); -- INITIATE EMPTY ROW
SELECT AddressID FROM dbo.ADDRESS Order By AddressID DESC limit 1
INTO addID;
	INSERT INTO DBO.ADDRESS_TYPE (AddressID, AddressType) VALUES(addID,"Residential");
SELECT AddressTypeID FROM dbo.ADDRESS_TYPE Order By AddressTypeID DESC limit 1
INTO aID;

IF firstType = 1 THEN

 -- INSERT INTO DBO.PAY () VALUES();
 SELECT PayID FROM DBO.PAY Order By PayID DESC limit 1
 into PAID;
 
	INSERT INTO DBO.EMPLOYEE_BENEFITS () VALUES();
    INSERT INTO DBO.EMPLOYEE (PersonID, AddressTypeID, BenefitID, PayID) VALUES(pid, aID, (select BenefitID from dbo.employee_benefits ORDER BY BenefitID DESC limit 1), PAID);
    INSERT INTO DBO.JOB_TITLE (PersonID) VALUES(pid);
    
ELSEIF firstType = 2 THEN 

	 INSERT INTO DBO.CUSTOMER (PersonID, AddressTypeID) VALUES(pid,aID);
     SELECT CustomerID FROM dbo.CUSTOMER Order By CustomerID DESC limit 1 INTO cid;
     INSERT INTO DBO.SALESPERSON_FOR (CustomerID, OrderDate) VALUES(cid,now());

END IF;

END $$
DELIMITER 

## BEFORE DELETING A VALUE DBO.PERSON ##
## DELETES ADDRESS TABLE UPON PERON DELETION ##

DELIMITER $$
CREATE TRIGGER  dbo . delete_addr BEFORE DELETE ON DBO.PERSON FOR EACH ROW 
BEGIN

DECLARE holder INT;
DECLARE pType VARCHAR(8);
SET holder = old.PersonID;
SET pType = old.PersonTypeID;

IF pType = 1 THEN

DELETE FROM DBO.ADDRESS WHERE AddressID = 
(select adt.addressID from dbo.employee e 
join dbo.address_type adt on e.AddressTypeID = adt.AddressTypeID
where e.PersonID = holder);

ELSEIF pType = 2 THEN 

DELETE FROM DBO.ADDRESS WHERE AddressID = 
(select adt.addressID from dbo.customer c 
join dbo.address_type adt on c.AddressTypeID = adt.AddressTypeID
where c.PersonID = holder);

END IF;

END $$
DELIMITER 


## FACILITY TABLE INSERT TRIGGER

DELIMITER $$

CREATE TRIGGER  dbo . ins_facil AFTER INSERT ON DBO.FACILITY FOR EACH ROW 
BEGIN

DECLARE fid INT;
DECLARE aID INT;
DECLARE addID INT;
DECLARE facil VARCHAR(100);
--
SELECT max(FacilityID) FROM DBO.FACILITY limit 1
INTO fid;
--
INSERT INTO DBO.ADDRESS () VALUES(); -- INITIATE EMPTY ROW
SELECT AddressID FROM dbo.ADDRESS Order By AddressID DESC limit 1
INTO addID;
INSERT INTO DBO.ADDRESS_TYPE (AddressID, AddressType) VALUES(addID, "Business");
SELECT AddressTypeID FROM dbo.ADDRESS_TYPE Order By AddressTypeID DESC limit 1
INTO aID;
INSERT INTO DBO.FACILITY_ADD_LK (FacilityTypeID, AddressTypeID) VALUES(fid, aID);

END $$
DELIMITER

## EMPLOYEE TABLE INSERT TRIGGER

DELIMITER $$

CREATE TRIGGER  dbo . ins_jobtype AFTER UPDATE ON DBO.EMPLOYEE FOR EACH ROW 
BEGIN

DECLARE jobCode INT;
DECLARE jTitle INT;
DECLARE fName VARCHAR(40);
DECLARE lName VARCHAR(40);

SELECT NEW.JobTitleTypeID FROM DBO.EMPLOYEE limit 1
INTO jobCode;
SELECT FirstName FROM DBO.PERSON WHERE PersonID = NEW.PersonID limit 1
INTO fName;
SELECT LastName FROM DBO.PERSON WHERE PersonID = NEW.PersonID limit 1
INTO lName;

IF (jobCode = 3 OR jobCode = 4 OR jobCode = 5) THEN

INSERT INTO DBO.DIRECT_REPORT (ManagerID, ManagerFirstName,ManagerLastName) 
VALUES(NEW.EmployeeID, fName,lName); -- Manager id is EmployeeID for managers only

ELSEIF jobCode = 2 THEN

-- select JobTitleID from job_title Where PersonID = NEW.PersonID limit 1 
-- into jTitle;

update dbo.job_title set JobTitleTypeID = 2 where PersonID = NEW.PersonID;

-- INSERT INTO DBO.SALESPERSON_FOR (JobTitleID, OrderDate) VALUES(jTitle, now());

END IF;

END $$
DELIMITER

## WHEN UPDATE ON SALESPERSONID --> UPDATE SALESPERSON_FOR table ##

DELIMITER $$
CREATE TRIGGER  dbo . up_customer AFTER UPDATE ON DBO.CUSTOMER FOR EACH ROW 
BEGIN
DECLARE SID INT;

SELECT NEW.SalesPersonID FROM DBO.CUSTOMER limit 1
INTO SID;

UPDATE dbo.salesperson_for SET JobTitleID = SID WHERE CustomerID = NEW.CustomerID;

END $$
-- DELIMITER

## ALL CUSTOMERS FULL NAME AND ADDRESS VIEW
DROP VIEW IF EXISTS DBO.CUSTOMERS;
CREATE VIEW DBO.CUSTOMERS AS
SELECT  a.AddressID, p.FirstName, p.MiddleInitial, p.LastName, a.Address1, a.City, s.StateName As State, a.ZipCode, a.ExtendedZip, a.Country
FROM DBO.PERSON p
INNER JOIN dbo.customer c on c.PersonID = p.PersonID
INNER JOIN dbo.address_type aty on aty.addressTypeID = c.addressTypeID
INNER JOIN dbo.address a on a.addressID = aty.addressID
LEFT JOIN dbo.state s on a.StateID = s.StateID
WHERE p.personTypeID = 2; -- Customer

## ALL EMPLOYEES FULL NAME AND ADDRESS VIEW
DROP VIEW IF EXISTS DBO.EMPLOYEES;
CREATE VIEW DBO.EMPLOYEES AS
SELECT  a.AddressID, p.FirstName, p.MiddleInitial, p.LastName, a.Address1, a.City, s.StateName As State, a.ZipCode, a.ExtendedZip, a.Country
FROM DBO.PERSON p
INNER JOIN dbo.employee e on e.PersonID = p.PersonID
INNER JOIN dbo.address_type aty on aty.addressTypeID = e.addressTypeID
INNER JOIN dbo.address a on a.addressID = aty.addressID
LEFT JOIN dbo.state s on a.StateID = s.StateID
WHERE p.personTypeID = 1; -- Employee

DROP VIEW IF EXISTS DBO.MORE_THAN_TEN_QUANTIY;
CREATE VIEW DBO.MORE_THAN_TEN_QUANTIY AS
Select * FROM DBO.ORDERED WHERE Quantity > 10;
 