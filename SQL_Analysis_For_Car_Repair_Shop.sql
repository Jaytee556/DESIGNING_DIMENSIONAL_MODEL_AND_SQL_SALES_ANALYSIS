
-- CREATE A RELATIONAL DATABASE TO STORE THE DATA FOR THE CAR REPAIR SHOP
CREATE DATABASE "Car_Repair_Shop_Jaytee";

USE Car_Repair_Shop_Jaytee;


--We would create tables to store each of the data represented in our csv files (customer, invoice, job, parts and vehicle)

-- CREATING THE CUSTOMER TABLE
CREATE TABLE Customers (
Customer_ID INT PRIMARY KEY,
Name VARCHAR(255),
Address VARCHAR(255),
Phone NVARCHAR (20)
);

-- CREATING THE VEHICLE TABLE
CREATE TABLE Vehicles (
Vehicle_ID INT PRIMARY KEY,
Make VARCHAR(255),
Model VARCHAR(255),
Year INT,
Color VARCHAR(50),
VIN VARCHAR(50),
Reg# VARCHAR(50),
Mileage INT,
OwnerName VARCHAR(255)
);


-- CREATING THE INVOICE TABLE
CREATE TABLE Invoices (
Invoice_ID INT PRIMARY KEY,
InvoiceDate DATE,
Subtotal DECIMAL(10, 2),
Sales_tax_rate DECIMAL(5, 2),
SalesTax DECIMAL(10, 2),
TotalLaboUr DECIMAL(10, 2),
TotalParts DECIMAL(10, 2),
Total DECIMAL(10, 2),
Customer_ID INT,
Vehicle_ID INT, 
FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
FOREIGN KEY (Vehicle_ID) REFERENCES Vehicles(Vehicle_ID)
);

-- CREATING JOB TABLE
CREATE TABLE Jobs (
Job_ID INT PRIMARY KEY,
Vehicle_ID INT,
Description VARCHAR(255),
Hours DECIMAL(5, 2),
Rate INT,
Amount DECIMAL(10, 2),
Invoice_ID INT,
FOREIGN KEY (Invoice_ID) REFERENCES Invoices(Invoice_ID),
FOREIGN KEY (Vehicle_ID) REFERENCES Vehicles(Vehicle_ID)
);



-- CREATING PARTS TABLE
CREATE TABLE Parts (
Part_ID INT PRIMARY KEY,
Job_ID INT,
Part# VARCHAR(50),
PartName VARCHAR(255),
Quantity INT,
UnitPrice DECIMAL(10, 2),
Amount DECIMAL(10, 2),
Invoice_ID INT,
FOREIGN KEY (Job_ID) REFERENCES Jobs(Job_ID),
FOREIGN KEY (Invoice_ID) REFERENCES Invoices(Invoice_ID)
);


--IMPORTING DATA FROM CSV FILES 
--Load Data into the Customer Table
BULK INSERT dbo.Customers
FROM 'C:\Users\HP\Documents\HNG INTERNSHIP\Customer.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n', 
    FIRSTROW = 2
);

ALTER TABLE Customers
ALTER COLUMN Phone NVARCHAR(MAX);

--Viewing the Customers Table
SELECT *
FROM Customers


--Load Data into the Vehicle Table
BULK INSERT dbo.Vehicles
FROM 'C:\Users\HP\Documents\HNG INTERNSHIP\Vehicle.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',   
    FIRSTROW = 2            
);

--Viewing the Vehicle Table
SELECT *
FROM Vehicles


--Load Data into the Invoice Table
BULK INSERT dbo.Invoices
FROM 'C:\Users\HP\Documents\HNG INTERNSHIP\Invoice.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',   
    FIRSTROW = 2            
);

--Viewing the Invoice Data
SELECT *
FROM Invoices


--Load Data into the Parts Table
BULK INSERT dbo.Parts
FROM 'C:\Users\HP\Documents\HNG INTERNSHIP\Parts.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',   
    FIRSTROW = 2            
);

--Viewing the Parts Data
SELECT *
FROM Parts


--Load Data into the Job Table
BULK INSERT dbo.Jobs
FROM 'C:\Users\HP\Documents\HNG INTERNSHIP\Job.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',   
    FIRSTROW = 2            
);

--Viewing the Jobs Data
SELECT *
FROM Jobs


---- Indexing for efficient querying
CREATE INDEX idx_Customer_ID ON Invoices(Customer_ID);
CREATE INDEX idx_Vehicle_ID_invoice ON Invoices(Vehicle_ID);
CREATE INDEX idx_Invoice_ID ON Jobs(Invoice_ID);
CREATE INDEX idx_Vehicle_ID ON Jobs(Vehicle_ID);
CREATE INDEX idx_Job_ID ON Parts(Job_ID);
CREATE INDEX idx_Invoice_ID_parts ON Parts(Invoice_ID);

/*DATA ANALYSIS SECTION
We would run the analysis for each objective/problem statement below:

Customer Analysis
Vehicle Analysis
Job Performance Analysis, 
Part Usage Analysis
Financial Analysis */

--Customer Analysis
--Identify the top 5 customers who have spent the most on vehicle repairs and parts.
Select TOP 5 Cus.Name, SUM(Inv.Total) as Total_spent
FROM Customers Cus
JOIN Invoices Inv
ON Cus.Customer_ID = Inv.Customer_ID
GROUP BY Cus.Name
ORDER BY Total_spent DESC;

--Determine the average spending of customers on repairs and parts.
Select AVG(Total) AS Avg_Spending
FROM Invoices

--Analyze the frequency of customer visits and identify any patterns.
Select Cus.Name, COUNT(Inv.Invoice_ID) as Num_of_visit
FROM Customers Cus
JOIN Invoices Inv
ON Cus.Customer_ID = Inv.Customer_ID
GROUP BY Cus.Name
ORDER BY Num_of_visit DESC

--VEHICLE ANALYSIS
--Calculate the average mileage of vehicles serviced.
SELECT AVG(Mileage) AS Average_mileage
FROM Vehicles


--Identify the most common vehicle makes and models brought in for service.
SELECT Make, Model, COUNT (*) AS count
FROM Vehicles
GROUP BY Make, Model
ORDER BY count DESC;

--Analyze the distribution of vehicle ages and identify any trends in service requirements based on vehicle age.
SELECT veh.Make, veh.Model, (YEAR(inv.InvoiceDate) - veh.year) AS vehicle_age, COUNT(*) AS vehicle_count_in_service,
COUNT(jb.Job_ID) AS job_performed_count  -- Count of services per vehicle age
FROM Vehicles veh
JOIN Invoices inv ON veh.Vehicle_ID = inv.Vehicle_ID
LEFT JOIN Jobs jb
ON veh.Vehicle_ID = jb.Vehicle_ID  -- Join with service records
WHERE inv.InvoiceDate IS NOT NULL
GROUP BY (YEAR(inv.InvoiceDate) - veh.year), veh.Make, veh.Model
ORDER BY vehicle_age;


--Job Performance Analysis
--Determine the most common types of jobs performed and their frequency.
SELECT Description, Count(Description) AS job_frequency
FROM Jobs
GROUP BY Description
ORDER BY job_frequency DESC;

--Calculate the total revenue generated from each type of job.
SELECT Description, SUM(Amount) AS total_revenue
FROM Jobs
GROUP BY Description
ORDER BY total_revenue DESC;

--Identify the jobs with the highest and lowest average costs.
SELECT Description, AVG(Amount) as Average_cost
FROM Jobs
GROUP BY Description
ORDER BY Average_cost DESC


--Part Usage Analysis
--List the top 5 most frequently used parts and their total usage.
SELECT TOP 5 PartName, SUM(Quantity) AS total_usage
FROM Parts
GROUP BY PartName
ORDER BY total_usage DESC;

--Calculate the average cost of parts used in repairs.
SELECT AVG(Amount) AS Avg_Cost
FROM Parts

--Determine the total revenue generated from parts sales.
SELECT SUM(Amount) AS Total_parts_revenue
FROM Parts


--FINANCIAL ANALYSIS
--Calculate the total revenue generated from labor and parts for each month.
SELECT FORMAT(InvoiceDate, 'yyyy-MM') AS Month, SUM(TotalLaboUr) AS Total_labor_revenue, 
SUM(TotalParts) AS Total_parts_revenue, 
SUM(Total) AS Total_revenue --Sales tax included in the total
FROM Invoices 
GROUP BY FORMAT(InvoiceDate, 'yyyy-MM')
ORDER BY Month;


--Determine the overall profitability of the repair shop.
SELECT SUM(Total) AS Total_Revenue, 
SUM(TotalLaboUr + TotalParts) AS Total_Costs,
SUM(Total) - SUM(TotalLaboUr + TotalParts) AS Profit
FROM Invoices


-- Analyze the impact of sales tax on the total revenue.
SELECT SUM(SalesTax) AS Total_sales_tax,
SUM(Total) AS Total_revenue,
SUM(Total) - SUM(SalesTax) AS Revenue_before_tax
FROM Invoices