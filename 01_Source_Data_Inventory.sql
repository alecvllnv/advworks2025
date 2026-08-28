/* ADVENTUREWORKS DW2025
   FILE 1: SOURCE DATA INVENTORY
*/

-- 1. Check database
SELECT DB_NAME() AS CurrentDatabase;
GO


-- 2. List relevant tables
SELECT 
    TABLE_NAME
FROM 
    INFORMATION_SCHEMA.TABLES
WHERE 
    TABLE_TYPE = 'BASE TABLE'
    AND TABLE_NAME IN (
        'FactInternetSales',
        'FactResellerSales',
        'DimSalesTerritory',
        'DimGeography',
        'DimDate',
        'DimCustomer',
        'DimReseller',
        'DimProduct',
        'DimProductSubcategory',
        'DimProductCategory'
    )
ORDER BY 
    TABLE_NAME;


-- 3. Check columns and data types
SELECT
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME IN (
        'FactInternetSales',
        'FactResellerSales',
        'DimSalesTerritory',
        'DimGeography',
        'DimDate',
        'DimCustomer',
        'DimReseller',
        'DimProduct',
        'DimProductSubcategory',
        'DimProductCategory'
    )
ORDER BY 
    TABLE_NAME, 
    ORDINAL_POSITION;


-- 4. Row counts
SELECT 'FactInternetSales'     AS TableName, COUNT(*) AS TotalRows FROM dbo.FactInternetSales
UNION ALL SELECT 'FactResellerSales',        COUNT(*)              FROM dbo.FactResellerSales
UNION ALL SELECT 'DimSalesTerritory',        COUNT(*)              FROM dbo.DimSalesTerritory
UNION ALL SELECT 'DimGeography',             COUNT(*)              FROM dbo.DimGeography
UNION ALL SELECT 'DimDate',                  COUNT(*)              FROM dbo.DimDate
UNION ALL SELECT 'DimCustomer',              COUNT(*)              FROM dbo.DimCustomer
UNION ALL SELECT 'DimReseller',              COUNT(*)              FROM dbo.DimReseller
UNION ALL SELECT 'DimProduct',               COUNT(*)              FROM dbo.DimProduct
UNION ALL SELECT 'DimProductSubcategory',    COUNT(*)              FROM dbo.DimProductSubcategory
UNION ALL SELECT 'DimProductCategory',       COUNT(*)              FROM dbo.DimProductCategory;


-- 5. Basic relationship checks

-- Internet Sales -> Customer
SELECT COUNT(*) AS MatchingRows
FROM dbo.FactInternetSales f
    INNER JOIN dbo.DimCustomer c
        ON f.CustomerKey = c.CustomerKey;

-- Internet Sales -> Product
SELECT COUNT(*) AS MatchingRows
FROM dbo.FactInternetSales f
    INNER JOIN dbo.DimProduct p
        ON f.ProductKey = p.ProductKey;

-- Internet Sales -> Date
SELECT COUNT(*) AS MatchingRows
FROM dbo.FactInternetSales f
    INNER JOIN dbo.DimDate d
        ON f.OrderDateKey = d.DateKey;

-- Internet Sales -> Territory
SELECT COUNT(*) AS MatchingRows
FROM dbo.FactInternetSales f
    INNER JOIN dbo.DimSalesTerritory t
        ON f.SalesTerritoryKey = t.SalesTerritoryKey;

-- Customer -> Geography
SELECT COUNT(*) AS MatchingRows
FROM dbo.DimCustomer c
    INNER JOIN dbo.DimGeography g
        ON c.GeographyKey = g.GeographyKey;

-- Geography -> Territory
SELECT COUNT(*) AS MatchingRows
FROM dbo.DimGeography g
    INNER JOIN dbo.DimSalesTerritory t
        ON g.SalesTerritoryKey = t.SalesTerritoryKey;