CREATE DATABASE "DA-Jaytee";

USE "DA-Jaytee";


/*The above database "DA-Jaytee" as been created to create the a dimensional model by
specifying/identifying the Facts and Dimensions.*/

/*DESIGN FACTS AND DIMENSION TABLE USING THE SAMPLE INVOICE INFORMATION. 
FACTS - This table contains/store quantitative data related to sales(Total sales, Labor cost (job/service rendered"), Part cost ....
DIMENSIONS - This table contains/store qualitative data for customers, vehicles, services (job), parts, locations, and dates. */

--CREATING THE TABLE FOR EACH DIMENSION

--Customer Dimension

CREATE TABLE Customer_Dim (
Customer_ID INT PRIMARY KEY,
Customer_Name VARCHAR(100),
Address VARCHAR(255),
Contact VARCHAR(15)
);

--Vehicle Dimension 
CREATE TABLE Vehicle_Dim (
Vehicle_ID INT PRIMARY KEY,
Make VARCHAR(50),
Model VARCHAR(50),
Year INT,
Color VARCHAR(50),
Mileage INT
);


-- Job (Or Service) Dimension 
CREATE TABLE Job_Dim (
Job_ID INT PRIMARY KEY,
Job_Description VARCHAR (255), 
Hourly_Rate DECIMAL (10, 2)
);


--Parts Dimension
CREATE TABLE Part_Dim (
Part_ID INT PRIMARY KEY,
Part_Number VARCHAR(50),
Part_Name VARCHAR(100),
UnitPrice DECIMAL(10, 2)
);

--Location Dimension 
CREATE TABLE Location_Dim (
Location_ID INT PRIMARY KEY,
Shop_Name VARCHAR(100),
Address VARCHAR(255),
City VARCHAR (100)
);

-- Date Dimension
CREATE TABLE Date_Dim (
Date_ID INT PRIMARY KEY,
Date DATE,
Month INT,
Year INT,
Day INT
);


-- --CREATING THE TABLE FOR SALES FACT (using the invoice number as the invoice ID since its unique)
CREATE TABLE Sales_Fact (
Invoice_ID INT PRIMARY KEY,
Customer_ID INT,
Vehicle_ID INT,
Job_ID INT,
Part_ID INT,
Location_ID INT,
Date_ID INT,
Total_Sales_Amount DECIMAL(10, 2),
Total_Labor_Cost DECIMAL(10, 2),
Total_Parts_Cost DECIMAL(10, 2),
Quantities_Sold INT,
Hours_Worked DECIMAL (10, 2),
Sales_Tax DECIMAL(10, 2),
FOREIGN KEY (Customer_ID) REFERENCES Customer_Dim(Customer_ID),
FOREIGN KEY (Vehicle_ID) REFERENCES Vehicle_Dim(Vehicle_ID),
FOREIGN KEY (Job_ID) REFERENCES Job_Dim(Job_ID),
FOREIGN KEY (Part_ID) REFERENCES Part_Dim(Part_ID),
FOREIGN KEY (Location_ID) REFERENCES Location_Dim(Location_ID),
FOREIGN KEY (Date_ID) REFERENCES Date_Dim(Date_ID)
);

/*The above query shows the desigin for the Fact table and the Dimension table 
where the Fact table includes foreign keys to link to the dimension tables and the dimension table
are designed to support the fact table and facilitate detailed analysis.
- For each table, the primary key is defined
- The foreign key relationships between the fact table and dimension tables were establlished.*/

--The code below was used to import the data to LucidChart to plot the Entity Relationship Diagram (ERD)

SELECT 'sqlserver' dbms,t.TABLE_CATALOG,t.TABLE_SCHEMA,t.TABLE_NAME,c.COLUMN_NAME,c.ORDINAL_POSITION,c.DATA_TYPE,c.CHARACTER_MAXIMUM_LENGTH,n.CONSTRAINT_TYPE,k2.TABLE_SCHEMA,k2.TABLE_NAME,k2.COLUMN_NAME FROM INFORMATION_SCHEMA.TABLES t LEFT JOIN INFORMATION_SCHEMA.COLUMNS c ON t.TABLE_CATALOG=c.TABLE_CATALOG AND t.TABLE_SCHEMA=c.TABLE_SCHEMA AND t.TABLE_NAME=c.TABLE_NAME LEFT JOIN(INFORMATION_SCHEMA.KEY_COLUMN_USAGE k JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS n ON k.CONSTRAINT_CATALOG=n.CONSTRAINT_CATALOG AND k.CONSTRAINT_SCHEMA=n.CONSTRAINT_SCHEMA AND k.CONSTRAINT_NAME=n.CONSTRAINT_NAME LEFT JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS r ON k.CONSTRAINT_CATALOG=r.CONSTRAINT_CATALOG AND k.CONSTRAINT_SCHEMA=r.CONSTRAINT_SCHEMA AND k.CONSTRAINT_NAME=r.CONSTRAINT_NAME)ON c.TABLE_CATALOG=k.TABLE_CATALOG AND c.TABLE_SCHEMA=k.TABLE_SCHEMA AND c.TABLE_NAME=k.TABLE_NAME AND c.COLUMN_NAME=k.COLUMN_NAME LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE k2 ON k.ORDINAL_POSITION=k2.ORDINAL_POSITION AND r.UNIQUE_CONSTRAINT_CATALOG=k2.CONSTRAINT_CATALOG AND r.UNIQUE_CONSTRAINT_SCHEMA=k2.CONSTRAINT_SCHEMA AND r.UNIQUE_CONSTRAINT_NAME=k2.CONSTRAINT_NAME WHERE t.TABLE_TYPE='BASE TABLE';

--Testing and validation by inserting values into the table ( using the exact information in the sample receipt)
INSERT INTO Customer_Dim (Customer_ID, Customer_Name, Address, Contact)
VALUES (1, 'Jennifer Robinson', '126 Nain Ave, Winnipeg, MB, R3J 3C4', '204-771-0784');

SELECT *
FROM Customer_Dim


INSERT INTO Vehicle_Dim (Vehicle_ID, Make, Model, Year, Color, Mileage)
VALUES (1, 'BMW', 'X5', 2012, 'Black', 16495)

SELECT *
FROM Vehicle_Dim


INSERT INTO Job_Dim (Job_ID, Job_Description, Hourly_Rate)
VALUES (1, 'Replace front CV Axel', 125)

SELECT *
FROM Job_Dim

INSERT INTO Part_Dim (Part_ID, Part_Number, Part_Name, UnitPrice)
VALUES (1, '23435', 'CV-Axel', 876.87)

SELECT *
FROM Part_Dim


INSERT INTO Location_Dim (Location_ID, Shop_Name, Address, City)
VALUES (1, 'Latino Garage', '111 MCPhillips Winnipeg Manitoba', 'Winnipeg')

SELECT *
FROM Location_Dim


INSERT INTO Date_Dim (Date_ID, Date, Month, Year, Day)
VALUES (1, '2023-09-10', 9, 2023, 10)

SELECT *
FROM Date_Dim

INSERT INTO Sales_Fact (Invoice_ID, Customer_ID, Vehicle_ID, Job_ID, Part_ID, Location_ID, Date_ID,
Total_Sales_Amount, Total_Labor_Cost,Total_Parts_Cost, Quantities_Sold, Hours_Worked, Sales_Tax)
VALUES 
(12345, 1, 1, 1, 1, 1, 1, 1521.37, 437.50, 876.87, 1, 3.5, 207);

SELECT *
FROM Sales_Fact

--TESTING COMPLETE (NECCSSSARY TO ENFORCE INTEGRITY)