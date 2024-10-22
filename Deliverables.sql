/* CREATE TABLE QUERIES */

CREATE TABLE Table_India (
    Customer_Name VARCHAR(255) NOT NULL,
    Customer_Id VARCHAR(18) NOT NULL,
    Open_Date DATE NOT NULL,
    Last_Consulted_Date DATE,
    Vaccination_Id CHAR(5),
    Dr_Name VARCHAR(255),
    State CHAR(5),
    Country CHAR(5),
    DOB DATE,
    Is_Active CHAR(1),
    Age INT GENERATED ALWAYS AS (YEAR(CURDATE()) - YEAR(DOB)),
    Days_Since_Last_Consulted INT GENERATED ALWAYS AS (DATEDIFF(CURDATE(), Last_Consulted_Date))
);

/* CREATE THE ABOVE TABLES WITH ADDITIONAL DERIVED COLUMNS : AGE AND DAYS SINCE LAST CONSULATED > 30 */

CREATE TABLE Table_India (
    Customer_Name VARCHAR(255) NOT NULL,
    Customer_Id VARCHAR(18) NOT NULL PRIMARY KEY,
    Open_Date DATE NOT NULL,
    Last_Consulted_Date DATE,
    Vaccination_Id CHAR(5),
    Dr_Name VARCHAR(255),
    State CHAR(5),
    Country CHAR(5),
    DOB DATE,
    Is_Active CHAR(1),
    -- Derived Columns
    Age INT GENERATED ALWAYS AS (YEAR(CURDATE()) - YEAR(DOB)),
    Days_Since_Last_Consulted INT GENERATED ALWAYS AS (DATEDIFF(CURDATE(), Last_Consulted_Date)),
    Is_Last_Consulted_Greater_Than_30_Days BOOLEAN GENERATED ALWAYS AS 
    (DATEDIFF(CURDATE(), Last_Consulted_Date) > 30)
);

/* CREATE NECESSARY VALIDATIONS */

-- NOT NULL 
CREATE TABLE Table_India (
    Customer_Name VARCHAR(255) NOT NULL,  -- Name cannot be null
    Customer_Id VARCHAR(18) NOT NULL PRIMARY KEY,  -- Unique and mandatory
    Open_Date DATE NOT NULL,  -- Mandatory field
    Last_Consulted_Date DATE, -- Optional
    Vaccination_Id CHAR(5),   -- Optional
    Dr_Name VARCHAR(255),     -- Optional
    State CHAR(5),            -- Optional
    Country CHAR(5) NOT NULL, -- Mandatory, as it dictates the country table
    DOB DATE,                 -- Mandatory for age calculation
    Is_Active CHAR(1) CHECK (Is_Active IN ('A', 'I')), -- Must be 'A' (Active) or 'I' (Inactive)
    
    -- Derived columns
    Age INT GENERATED ALWAYS AS (YEAR(CURDATE()) - YEAR(DOB)),
    Days_Since_Last_Consulted INT GENERATED ALWAYS AS (DATEDIFF(CURDATE(), Last_Consulted_Date)),
    Is_Last_Consulted_Greater_Than_30_Days BOOLEAN GENERATED ALWAYS AS (DATEDIFF(CURDATE(), Last_Consulted_Date) > 30)
);
-- UNIQUE CONSTRAINT FOR CUSTOMER ID 
ALTER TABLE Table_India ADD CONSTRAINT UC_Customer UNIQUE(Customer_Id);
-- DATE FORMAT VALIDATION
ALTER TABLE Table_India 
ADD CONSTRAINT CHK_OpenDate_Format CHECK (Open_Date REGEXP '^[0-9]{4}[0-9]{2}[0-9]{2}$');
