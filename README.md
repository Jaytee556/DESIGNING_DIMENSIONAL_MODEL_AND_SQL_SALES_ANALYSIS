# DESIGNING_DIMENSIONAL_MODEL_AND_SQL_SALES_ANALYSIS
This repository entails designing a dimensional model that gives a logical business view of data to analyze data relevant to sales analysis. It also involves performing a comprehensive analysis of a car repair shop's operation using SQL to extract meaningful insight. 

- ### DIMENSIONAL MODELING
  The dimensional model is designed to facilitate the analysis of sales data. Key metrics (facts) and attributes (dimensions) have been identified to allow detailed and flexible analysis.
  This project session focuses on creating/designing a dimensional data model for analyzing the sales performance of car repair centers across western Canada using information from a sample invoice. The goal is to create a database schema that allows for efficient querying and reporting on various aspects of sales, including customer behavior, vehicle types, job performance, parts sales, and location effectiveness. The model should enable a flexible analysis of services and parts sales by customer, vehicle brand/model/year, and shop location.

`OBJECTIVES`

• Review the sample invoice: Identify key pieces of information relevant to sales analysis. 

• Types of analysis: Determine the type of analysis needed by the business such as sales by customer, vehicle brand/model/year, services, parts, and shop locations.

• Identify key metrics (facts): Identify the facts to analyze, including service charges, parts charges, total sales, and sales tax.

• Identify attributes (dimensions): Identify the dimensions to slice and dice metrics, including customer information, vehicle details, service types, part details, location information, and 
date/time of the transaction.

• Create a fact table: Create a fact table to store quantitative data related to sales and include foreign keys to link to the dimension tables.

• Create dimension tables: Create a dimension table to store qualitative data for customers, vehicles, services, parts, locations, and dates, ensuring they support the fact table and facilitate 
detailed analysis.

• Create tables for each fact and dimension in any SQL Workbench, define primary keys, establish foreign key relationships, ensure all necessary relationships between tables, ensure referential 
integrity, and develop an ER diagram (Entity relationship diagram).


• `Tools Used`:

o Microsoft SQL Server

o Lucidchart for ER diagram creation


- ### SQL ANALYSIS
This session of this project (part B) focuses on the findings from the data analysis of a car repair shop's operations. The analysis aims to identify key patterns and insights related to customer behavior, vehicle characteristics, job performance, parts usage, and financial metrics. Using SQL queries, we derived insights to help optimize operations and enhance profitability. Key findings include identifying the top five customers by spending, analyzing vehicle age distributions, and assessing the impact of sales tax on overall revenue. The goal is to provide actionable recommendations to optimize the repair shop's operations and improve profitability. 

`OBJECTIVES`

- Create a relationship database and import the provided CSV files into it.
- Identify the top 5 customers who have spent the most on vehicle repairs and parts.
- Determine the average spending of customers on repairs and parts.
- Analyze the frequency of customer visits and identify any patterns.
- Calculate the average mileage of vehicles serviced.
- Identify the most common vehicle makes and models brought in for service.
- Analyze the distribution of vehicle ages and identify trends in service requirements based on vehicle age.
- Determine the most common types of jobs performed and their frequency.
- Calculate the total revenue generated from each type of job.
- Identify the jobs with the highest and lowest average costs.
- List the top 5 most frequently used parts and their total usage.
- Calculate the average cost of parts used in repairs.
- Determine the total revenue generated from parts sales.
- Calculate the total revenue generated from labor and parts for each month.
- Determine the overall profitability of the repair shop.
- Analyze the impact of sales tax on the total revenue.
- Provide actionable recommendations to optimize operations.


`METHODOLOGY`

`TOOL USED`: MICROSOFT SQL SERVER

• Data Ingestion:

- Created a new database called Car_Repair_Shop_Jaytee using the CREATE DATABASE syntax.
- Used the CREATE TABLE syntax, five tables were created for each of the data contained in each CSV file which includes the Customer table, Invoice table, Job table, Parts table, and 
the Vehicle table.
- Imported CSV files into a relational database.
- Data Cleaning: Ensured data was clean, properly formatted (to the same data time for consistency), and indexed.
- Data Analysis: Conducted analysis using SQL queries to extract relevant insights.
- Data Visualization: Created visualizations in Excel to illustrate key findings.
