# AdventureWorks DW2025 | Sales Data Analysis & Data Preparation

## Project Overview

This project focuses on exploring, profiling, and preparing sales data from the AdventureWorksDW2025 data warehouse using Microsoft SQL Server.

The project examines both Internet Sales and Reseller Sales to establish a structured and reliable dataset for future business analysis. It involves source data inventory, data profiling, data cleaning, transformation, and data dictionary development.

The goal is to prepare consistent and analysis-ready datasets that can support business intelligence, sales performance evaluation, and data-driven decision-making.

## Objectives

- Explore the AdventureWorksDW2025 database and identify relevant fact and dimension tables.
- Examine data structures, column attributes, and relationships between tables.
- Perform data profiling to assess data quality and identify potential inconsistencies.
- Clean and transform sales, customer, and product datasets.
- Develop a data dictionary documenting field definitions and transformation logic.
- Prepare structured datasets for subsequent analysis and visualization.

## Tools & Technologies

- **Microsoft SQL Server** – Database management and SQL execution
- **T-SQL** – Data exploration, profiling, cleaning, and transformation
- **AdventureWorksDW2025** – Source data warehouse

## Project Workflow

### 1. Source Data Inventory

Identified and examined relevant tables within the AdventureWorksDW2025 database.

Tables covered:

**Fact Tables**
- FactInternetSales
- FactResellerSales

**Dimension Tables**
- DimSalesTerritory
- DimGeography
- DimDate
- DimCustomer
- DimReseller
- DimProduct
- DimProductSubcategory
- DimProductCategory

Activities included:
- Database verification
- Table identification
- Column and data type inspection
- Row count assessment
- Relationship and join validation

### 2. Data Profiling

Conducted data quality assessments across the source tables to identify potential issues and understand the characteristics of the datasets.

Profiling activities included:
- Row count and data type inspection
- NULL value assessment
- Duplicate record detection
- Outlier and statistical checks
- Negative sales value identification
- Invalid discount and quantity checks
- Invalid unit price checks
- Referential integrity validation
- Sales date coverage assessment
- Calendar value validation

These checks provided a foundation for determining the necessary data preparation steps.

### 3. Data Cleaning & Transformation

Created cleaned datasets using SQL queries, incorporating relevant attributes from fact and dimension tables.

**Cleaned datasets created:**

| Dataset | Description |
|---|---|
| CleanedInternetSales | Prepared Internet Sales records |
| CleanedResellerSales | Prepared Reseller Sales records |
| CleanedCustomer | Standardized customer information |
| CleanedProduct | Consolidated product information |

Key transformation techniques:
- `SELECT DISTINCT` to retrieve distinct records
- `ISNULL()` to handle missing values
- `UPPER()` to standardize text fields
- `CAST()` to convert date fields
- `YEAR()` and `MONTH()` to derive sales date attributes
- `INNER JOIN` and `LEFT JOIN` to integrate related tables
- `SELECT INTO` to create cleaned tables

Additional transformation steps included standardizing descriptive fields, replacing selected NULL values with default values, and excluding sales records associated with Sales Territory Key 11.

### 4. Data Dictionary Development

Developed a data dictionary for the cleaned datasets to document their structure and business meaning.

The documentation includes:
- Table names
- Field names
- Source systems
- Data types
- Business definitions
- Data derivation and transformation logic

This provides a reference for understanding the prepared datasets and supports consistency in subsequent analytical work.

## Key SQL Concepts Demonstrated

- Database exploration and metadata queries
- Data profiling and quality assessment
- Aggregate functions
- Conditional statements (`CASE WHEN`)
- NULL handling
- Duplicate detection
- Statistical functions (`MIN`, `MAX`, `AVG`, `STDEV`)
- Table joins and relationship validation
- Data type conversion
- Data standardization
- Table creation and transformation

## Project Structure

```text
AdventureWorks-DW2025/
│
├── 01_Source_Data_Inventory.sql
├── 02_Data_Profiling.sql
├── 03_Data_Transformation.sql
└── 04_Data_Dictionary.sql
```

## Expected Deliverables

- Source data inventory and relationship assessment
- Data profiling queries and quality checks
- Four cleaned datasets
- Data dictionary documenting the cleaned tables
- SQL scripts documenting the data preparation workflow

## Learning Outcomes

Through this project, I developed practical experience in SQL-based data exploration, data quality assessment, data transformation, and database documentation.

It strengthened my understanding of how raw data warehouse tables can be examined and prepared for analytical applications and business intelligence.

---

**Project Focus:** Data Analytics | SQL | Data Cleaning | Data Profiling | Business Intelligence

**Author:** Alecsandra Z. Villanueva

**Academic Program:** BS Data Science and Analytics

**University:** University of Santo Tomas
