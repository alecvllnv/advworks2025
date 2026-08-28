/* ADVENTUREWORKS DW2025
   FILE 4: DATA DICTIONARY
*/

-- 1. Internet Sales

SELECT
    'CleanedInternetSales'                                                    AS TableName,
    COLUMN_NAME                                                               AS FieldName,
    'FactInternetSales / DimSalesTerritory / DimProduct / DimProductCategory' AS SourceSystem,
    DATA_TYPE                                                                 AS DataType,
    CASE COLUMN_NAME
        WHEN 'SalesOrderNumber'      THEN 'Sales order number'
        WHEN 'SalesOrderLineNumber'  THEN 'Line number of the order'
        WHEN 'ProductKey'            THEN 'Identifies the product'
        WHEN 'CustomerKey'           THEN 'Identifies the customer'
        WHEN 'SalesTerritoryKey'     THEN 'Identifies the sales territory'
        WHEN 'OrderDate'             THEN 'Date when the order was placed'
        WHEN 'SalesYear'             THEN 'Year of the sale'
        WHEN 'SalesMonth'            THEN 'Month of the sale'
        WHEN 'OrderQuantity'         THEN 'Number of units sold'
        WHEN 'UnitPrice'             THEN 'Price of one unit'
        WHEN 'SalesAmount'           THEN 'Total sales amount'
        WHEN 'UnitPriceDiscountPct'  THEN 'Discount applied to the unit price'
        WHEN 'SalesTerritoryRegion'  THEN 'Region of the sales territory'
        WHEN 'SalesTerritoryCountry' THEN 'Country of the sales territory'
        WHEN 'SalesTerritoryGroup'   THEN 'Geographic group of the territory'
        WHEN 'ProductName'           THEN 'Name of the product'
        WHEN 'ProductCategory'       THEN 'Category of the product'
    END AS BusinessDefinition,
    CASE COLUMN_NAME
        WHEN 'OrderDate'             THEN 'Converted to DATE'
        WHEN 'SalesYear'             THEN 'YEAR(OrderDate)'
        WHEN 'SalesMonth'            THEN 'MONTH(OrderDate)'
        WHEN 'ProductName'           THEN 'Renamed from EnglishProductName'
        WHEN 'ProductCategory'       THEN 'Joined through product tables'
        WHEN 'SalesTerritoryRegion'  THEN 'UPPER and NULL replaced with UNKNOWN'
        WHEN 'SalesTerritoryCountry' THEN 'UPPER and NULL replaced with UNKNOWN'
        WHEN 'SalesTerritoryGroup'   THEN 'UPPER and NULL replaced with UNKNOWN'
        WHEN 'OrderQuantity'         THEN 'NULL replaced with 0'
        WHEN 'UnitPrice'             THEN 'NULL replaced with 0'
        WHEN 'SalesAmount'           THEN 'NULL replaced with 0'
        WHEN 'UnitPriceDiscountPct'  THEN 'NULL replaced with 0'
        ELSE 'Direct from source'
    END AS Derivation
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'CleanedInternetSales';


-- 2. Reseller Sales

SELECT
    'CleanedResellerSales'                                                    AS TableName,
    COLUMN_NAME                                                               AS FieldName,
    'FactResellerSales / DimSalesTerritory / DimProduct / DimProductCategory' AS SourceSystem,
    DATA_TYPE                                                                 AS DataType,
    CASE COLUMN_NAME
        WHEN 'SalesOrderNumber'      THEN 'Reseller sales order number'
        WHEN 'SalesOrderLineNumber'  THEN 'Line number of the order'
        WHEN 'ProductKey'            THEN 'Identifies the product'
        WHEN 'ResellerKey'           THEN 'Identifies the reseller'
        WHEN 'SalesTerritoryKey'     THEN 'Identifies the sales territory'
        WHEN 'OrderDate'             THEN 'Date when the order was placed'
        WHEN 'SalesYear'             THEN 'Year of the sale'
        WHEN 'SalesMonth'            THEN 'Month of the sale'
        WHEN 'OrderQuantity'         THEN 'Number of units sold'
        WHEN 'UnitPrice'             THEN 'Price of one unit'
        WHEN 'SalesAmount'           THEN 'Total sales amount'
        WHEN 'UnitPriceDiscountPct'  THEN 'Discount applied to the unit price'
        WHEN 'SalesTerritoryRegion'  THEN 'Region of the sales territory'
        WHEN 'SalesTerritoryCountry' THEN 'Country of the sales territory'
        WHEN 'SalesTerritoryGroup'   THEN 'Geographic group of the territory'
        WHEN 'ProductName'           THEN 'Name of the product'
        WHEN 'ProductCategory'       THEN 'Category of the product'
    END AS BusinessDefinition,
    CASE COLUMN_NAME
        WHEN 'OrderDate'             THEN 'Converted to DATE'
        WHEN 'SalesYear'             THEN 'YEAR(OrderDate)'
        WHEN 'SalesMonth'            THEN 'MONTH(OrderDate)'
        WHEN 'ProductName'           THEN 'Renamed from EnglishProductName'
        WHEN 'ProductCategory'       THEN 'Joined through product tables'
        WHEN 'SalesTerritoryRegion'  THEN 'UPPER and NULL replaced with UNKNOWN'
        WHEN 'SalesTerritoryCountry' THEN 'UPPER and NULL replaced with UNKNOWN'
        WHEN 'SalesTerritoryGroup'   THEN 'UPPER and NULL replaced with UNKNOWN'
        WHEN 'OrderQuantity'         THEN 'NULL replaced with 0'
        WHEN 'UnitPrice'             THEN 'NULL replaced with 0'
        WHEN 'SalesAmount'           THEN 'NULL replaced with 0'
        WHEN 'UnitPriceDiscountPct'  THEN 'NULL replaced with 0'
        ELSE 'Direct from source'
    END AS Derivation
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'CleanedResellerSales';


-- 3. Customer

SELECT
    'CleanedCustomer'            AS TableName,
    COLUMN_NAME                  AS FieldName,
    'DimCustomer / DimGeography' AS SourceSystem,
    DATA_TYPE                    AS DataType,
    CASE COLUMN_NAME
        WHEN 'CustomerKey'       THEN 'Unique customer identifier'
        WHEN 'FirstName'         THEN 'Customer first name'
        WHEN 'LastName'          THEN 'Customer last name'
        WHEN 'Gender'            THEN 'Customer gender'
        WHEN 'YearlyIncome'      THEN 'Customer yearly income'
        WHEN 'TotalChildren'     THEN 'Number of children'
        WHEN 'NumberCarsOwned'   THEN 'Number of cars owned'
        WHEN 'Education'         THEN 'Customer education level'
        WHEN 'Occupation'        THEN 'Customer occupation'
        WHEN 'HouseOwnerFlag'    THEN 'Indicates whether the customer owns a house'
        WHEN 'DateFirstPurchase' THEN 'Date of first purchase'
        WHEN 'City'              THEN 'Customer city'
        WHEN 'StateProvinceName' THEN 'Customer state or province'
        WHEN 'Country'           THEN 'Customer country'
    END AS BusinessDefinition,
    CASE COLUMN_NAME
        WHEN 'Education'         THEN 'Renamed and standardized using UPPER'
        WHEN 'Occupation'        THEN 'Renamed and standardized using UPPER'
        WHEN 'Gender'            THEN 'Standardized using UPPER'
        WHEN 'City'              THEN 'Joined from DimGeography'
        WHEN 'StateProvinceName' THEN 'Joined from DimGeography'
        WHEN 'Country'           THEN 'Joined from DimGeography'
        WHEN 'DateFirstPurchase' THEN 'Converted to DATE'
        WHEN 'YearlyIncome'      THEN 'NULL replaced with 0'
        WHEN 'TotalChildren'     THEN 'NULL replaced with 0'
        WHEN 'NumberCarsOwned'   THEN 'NULL replaced with 0'
        ELSE 'Direct from source'
    END AS Derivation
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'CleanedCustomer';


-- 4. Product

SELECT
    'CleanedProduct'                                          AS TableName,
    COLUMN_NAME                                               AS FieldName,
    'DimProduct / DimProductSubcategory / DimProductCategory' AS SourceSystem,
    DATA_TYPE                                                 AS DataType,
    CASE COLUMN_NAME
        WHEN 'ProductKey'            THEN 'Unique product identifier'
        WHEN 'ProductName'           THEN 'Name of the product'
        WHEN 'ProductSubcategoryKey' THEN 'Identifies the product subcategory'
        WHEN 'ProductSubcategory'    THEN 'Product subcategory'
        WHEN 'ProductCategory'       THEN 'Product category'
        WHEN 'StandardCost'          THEN 'Standard cost of the product'
        WHEN 'ListPrice'             THEN 'Listed selling price'
        WHEN 'Color'                 THEN 'Product color'
        WHEN 'Size'                  THEN 'Product size'
        WHEN 'Weight'                THEN 'Product weight'
        WHEN 'DaysToManufacture'     THEN 'Days needed to manufacture the product'
    END AS BusinessDefinition,
    CASE COLUMN_NAME
        WHEN 'ProductName'           THEN 'Renamed from EnglishProductName'
        WHEN 'ProductSubcategory'    THEN 'Joined from DimProductSubcategory'
        WHEN 'ProductCategory'       THEN 'Joined from DimProductCategory'
        WHEN 'StandardCost'          THEN 'NULL replaced with 0'
        WHEN 'ListPrice'             THEN 'NULL replaced with 0'
        WHEN 'Color'                 THEN 'Standardized using UPPER'
        WHEN 'Size'                  THEN 'NULL replaced with UNKNOWN'
        WHEN 'Weight'                THEN 'NULL replaced with 0'
        WHEN 'DaysToManufacture'     THEN 'NULL replaced with 0'
        ELSE 'Direct from source'
    END AS Derivation
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'CleanedProduct';