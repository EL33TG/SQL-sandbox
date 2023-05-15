
-- Author: Brenden Boswell
-- MySQL Database Creation
-- Creating Tables

CREATE SCHEMA IF NOT EXISTS dbo;

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
CREATE TABLE IF NOT EXISTS DBO.MANAGER (
    ManagerID INT NOT NULL,
    AddressID INT NOT NULL,
    StateID INT NOT NULL,
    LocationID INT NOT NULL,
    ManagerTypeID INT NOT NULL,
    DepartmentID INT NOT NULL,
    EmployeeID INT NOT NULL,
    PRIMARY KEY (ManagerID)
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

-- CREATE TABLE IF NOT EXISTS DBO.ORDER_PLACED (
-- OrderID INT NOT NULL AUTO_INCREMENT, 
-- CustomerID INT NOT NULL, -- FK TO CUSTOMER
-- DeliveryID INT, -- FK
-- Filled CHAR,
-- ReviewTime DATETIME NOT NULL DEFAULT(now()),
-- ApprovalCode CHAR NOT NULL DEFAULT('N'),
-- OrderMode INT,
-- Discount DOUBLE,
-- DiscountAuth CHAR,
-- DiscountAuthDate DATETIME,
-- DiscountApproval CHAR DEFAULT('N'),
-- primary key (OrderID)
-- );

#### CREATE DELIVERY ####
-- CREATE TABLE IF NOT EXISTS DBO.DELIVERY (
-- DeliveryID INT NOT NULL, 
-- Shipped CHAR NOT NULL, -- When value --> ShipDateTime automatically pop
-- ShipDate DATETIME NOT NULL DEFAULT(now()),  -- Time included with DateTime
-- Received CHAR NOT NULL, -- When value --> ReceivedDateTime automatically pop
-- ReceivedDate DATETIME NOT NULL DEFAULT(now()),
-- primary key (DeliveryID)
-- );

-- CREATE TABLE IF NOT EXISTS DBO.SALES_REGION (
--     SalesRegionID INT NOT NULL,
--     SalesRegionName VARCHAR(100) NOT NULL,
--     PRIMARY KEY (SalesRegionID)
-- );

-- CREATE TABLE IF NOT EXISTS DBO.FACILITY (
--     FacilityID INT NOT NULL AUTO_INCREMENT,
--     FacilityName VARCHAR(100) NOT NULL UNIQUE,
--     FacilityType VARCHAR(20) NOT NULL,
-- 	Modified_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
--     Created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     -- FacilityLocationID VARCHAR(100) NOT NULL,
--     PRIMARY KEY (FacilityID)
-- );

-- CREATE TABLE IF NOT EXISTS DBO.FACILITY_ADD_LK (
--     FacilityTypeID INT NOT NULL,
--    -- FacilityID INT NOT NULL,
--     AddressTypeID INT,
--     PRIMARY KEY (FacilityTypeID)
-- );

-- CREATE TABLE IF NOT EXISTS DBO.DEPARTMENT (
--     DepartmentID INT NOT NULL AUTO_INCREMENT,
--     DepartmentType VARCHAR(20) UNIQUE NOT NULL,
--     LocationID INT,
--     PRIMARY KEY (DepartmentID)
-- );

-- CREATE TABLE IF NOT EXISTS DBO.PART_ORDER (
--     PartOrderID INT NOT NULL AUTO_INCREMENT,
--     PartID INT NOT NULL,
--     OrderID INT NOT NULL,
--     Quantity INT NOT NULL,
--     OrderDate DATETIME NOT NULL,
--     PRIMARY KEY (PartOrderID)
-- );

#### CREATE ACCOUNTS_PAYABLE ####
CREATE TABLE IF NOT EXISTS DBO.ACCOUNTS_PAYABLE (
DebitTransactionID INT NOT NULL,
PayeeID INT NOT NULL, -- FK
DebitAmt DOUBLE NOT NULL,
DebitDate DOUBLE NOT NULL DEFAULT(now()), -- AutoFill when DebitAmt populated
primary key (DebitTransactionID)
);

#### CREATE ACCOUNTS_RECEIVABLE ####
CREATE TABLE IF NOT EXISTS DBO.ACCOUNTS_RECEIVABLE (
CreditTransactionID INT NOT NULL,
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


-- CREATE TABLE IF NOT EXISTS DBO.MANUFACTURER (
--     ManufacturerID INT NOT NULL,
--     ManufacturerName VARCHAR(50) NOT NULL,
--     PRIMARY KEY (ManufacturerID)
-- );

-- CREATE TABLE IF NOT EXISTS DBO.FEE (
--     FeeTypeId INT NOT NULL AUTO_INCREMENT,
--     FeeType VARCHAR(20) UNIQUE,
--     FeeAmt INT,
--     PRIMARY KEY (FeeTypeID)
-- );

-- CREATE TABLE IF NOT EXISTS DBO.CUSTOMER_COMPLAINT (
--     ComplaintId INT NOT NULL,
--     CustomerId INT NOT NULL,
--     ComplaintSrc VARCHAR(15) NOT NULL,
--     LateFeeAmt DOUBLE NOT NULL,
--     PRIMARY KEY (ComplaintId)
-- );

-- CREATE TABLE IF NOT EXISTS DBO.ORDERED (
--     OrderID INT NOT NULL AUTO_INCREMENT,
-- 	ProductID INT,
--     OrderType VARCHAR(20),
--     PersonID INT,
--     Shipped CHAR,
--     Quantity INT NOT NULL,
--     PRIMARY KEY (OrderID)
-- );

-- CREATE TABLE IF NOT EXISTS DBO.PRODUCT (
--     ProductID INT NOT NULL AUTO_INCREMENT,
--     ProductName VARCHAR(100) NOT NULL,
--     Cost DOUBLE,
--     PRIMARY KEY (ProductID)
-- );

-- CREATE TABLE IF NOT EXISTS DBO.PART (
--     PartID INT NOT NULL AUTO_INCREMENT,
--     PartType VARCHAR(20) NOT NULL,
--     ProductID INT,
--     LocationID INT,
--     Cost DOUBLE,
--     ReorderPoint INT NOT NULL,
--     PRIMARY KEY (PartID)
-- );

-- CREATE TABLE IF NOT EXISTS DBO.CONTAINER (
--     ContainerID INT NOT NULL,
--     LocationID INT,
--     FacilityID INT, -- Warehouse
--     PRIMARY KEY (ContainerID)
-- );

-- CREATE TABLE IF NOT EXISTS DBO.CUSTOMER_ORDERS (
--     OrderID INT NOT NULL AUTO_INCREMENT,
--     CustomerID INT NOT NULL,
--     PRIMARY KEY (OrderID)
-- );
-- CREATE TABLE IF NOT EXISTS DBO.DELIVERY_OF (
--     OrderID INT NOT NULL AUTO_INCREMENT,
--     DeliveryID INT NOT NULL,
--     PRIMARY KEY (OrderID)
-- );

-- CREATE TABLE IF NOT EXISTS DBO.MANAGE_LOCATION (
--     EmployeeID INT NOT NULL AUTO_INCREMENT,
--     LocationID INT NOT NULL,
--     PRIMARY KEY (EmployeeID)
-- );

-- CREATE TABLE IF NOT EXISTS DBO.MANAGE_DEPARTMENT (
--     EmployeeID INT NOT NULL AUTO_INCREMENT,
--     LocationID INT NOT NULL,
--     DepartmentID INT NOT NULL,
--     PRIMARY KEY (EmployeeID)
-- );

-- CREATE TABLE IF NOT EXISTS DBO.SUPERVISES (
--     ManagerID INT NOT NULL AUTO_INCREMENT,
--     EmployeeID INT,
--     LocationID INT,
--     DepartmentID INT,
--     PRIMARY KEY (ManagerID)
-- );
-- CREATE TABLE IF NOT EXISTS DBO.PART_CONTAINER (
--     PartID INT NOT NULL AUTO_INCREMENT,
--     ContainerID INT NOT NULL,
--     PRIMARY KEY (PartID)
-- );

-- CREATE TABLE IF NOT EXISTS DBO.FACTORY_ORDERS (
--     FactoryID INT NOT NULL AUTO_INCREMENT,
--     WarehouseID INT NOT NULL,
--     OrderDate DATE NOT NULL,
--     PRIMARY KEY (FactoryID)
-- );

-- CREATE TABLE IF NOT EXISTS DBO.SALESPERSON_FOR (
--     SalesNumber INT NOT NULL AUTO_INCREMENT, -- Ref EmployeeID was SalesPersonID
--     JobTitleID INT UNIQUE,
--     CustomerID INT,
--     OrderDate DATETIME NOT NULL,
--     PRIMARY KEY (SalesNumber)
-- );

-- CREATE TABLE IF NOT EXISTS DBO.CHARGES_FOR_PART (
--     PartNumber INT NOT NULL AUTO_INCREMENT, -- Ref partID
--     Manufacturer INT NOT NULL,
--     Price DATE NOT NULL,
--     PRIMARY KEY (PartNumber)
-- );

-- REATE TABLE IF NOT EXISTS DBO.ORDER_PARTS_EXPEDITED (
--     OrderPartsID INT NOT NULL AUTO_INCREMENT, -- Ref partID
--     ApprovingManager INT NOT NULL, -- ref employee id
--     Approval CHAR,
--     PRIMARY KEY (OrderPartsID)
-- );

-- CREATE TABLE IF NOT EXISTS DBO.ORDER_PARTS (
--     OrderPartsID INT NOT NULL AUTO_INCREMENT, -- Ref partID
--     Manufacturer VARCHAR(40) NOT NULL,
--     Price DATE NOT NULL,
--     Quantity DATE NOT NULL,
--     Expedited DATE NOT NULL,
--     ShippingLocation INT NOT NULL,
--     DeliveryCharge INT NOT NULL,
--     PRIMARY KEY (OrderPartsID)
-- );

-- CREATE TABLE IF NOT EXISTS DBO.ROUTING_SHEET (
--     AseemblyStepNumber INT NOT NULL AUTO_INCREMENT, -- Ref partID
--     ProductID INT NOT NULL, -- ref employee id
--     RoutingTime DATETIME,
--     PRIMARY KEY (AseemblyStepNumber)
-- );

-- CREATE TABLE IF NOT EXISTS DBO.EMPLOYEE_ASSEMBLE_STEP (
--     EmployeeID INT NOT NULL AUTO_INCREMENT, -- Ref partID
--     ProductID INT NOT NULL, -- ref employee id
--     AseemblyStepNumber INT NOT NULL,
--     StartTime DATETIME,
--     EndTime DATETIME,
--     TotalTime DATETIME,
--     PRIMARY KEY (EmployeeID)
-- );

-- CREATE TABLE IF NOT EXISTS DBO.BILL_OF_MATERIALS (
--     PartID INT NOT NULL AUTO_INCREMENT, -- Ref partID
--     ProductID INT NOT NULL, -- ref employee id
--     Quantity INT NOT NULL,
--     PRIMARY KEY (PartID)
-- );

-- CREATE TABLE IF NOT EXISTS DBO.PAY_TYPE (
--     PayTypeID INT NOT NULL AUTO_INCREMENT,
--     PayType VARCHAR(8) UNIQUE,
--     PRIMARY KEY (PayTypeID)
-- );


-- CREATE TABLE IF NOT EXISTS DBO.PAY (
--     PayID INT NOT NULL AUTO_INCREMENT,
--     PayTypeID INT,
--     HourlyAmt DOUBLE DEFAULT(0.01),
--     SalaryAmt INT DEFAULT(0),
--     PRIMARY KEY (PayID)
-- );

CREATE TABLE IF NOT EXISTS DBO.LOCATION (
    LocationID INT NOT NULL AUTO_INCREMENT,
    LocationType VARCHAR(50) UNIQUE,
    Location VARCHAR(50),
    PRIMARY KEY (LocationID)
);