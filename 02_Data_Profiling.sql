/* ADVENTUREWORKS DW2025
   FILE 2: DATA PROFILING
*/

-- 1. Row counts
SELECT 'FactInternetSales' AS TableName, COUNT(*) AS TotalRows FROM dbo.FactInternetSales
UNION ALL SELECT 'FactResellerSales',    COUNT(*)              FROM dbo.FactResellerSales
UNION ALL SELECT 'DimSalesTerritory',    COUNT(*)              FROM dbo.DimSalesTerritory
UNION ALL SELECT 'DimGeography',         COUNT(*)              FROM dbo.DimGeography
UNION ALL SELECT 'DimDate',              COUNT(*)              FROM dbo.DimDate
UNION ALL SELECT 'DimCustomer',          COUNT(*)              FROM dbo.DimCustomer
UNION ALL SELECT 'DimReseller',          COUNT(*)              FROM dbo.DimReseller
UNION ALL SELECT 'DimProduct',           COUNT(*)              FROM dbo.DimProduct;


-- 2. Data types
SELECT
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE
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
        'DimProduct'
    )
ORDER BY 
    TABLE_NAME, 
    ORDINAL_POSITION;


-- 3. Null profiling - Internet Sales
SELECT
    COUNT(*) AS TotalRows,
    SUM(CASE WHEN ProductKey IS NULL THEN 1 ELSE 0 END)        AS ProductKeyNull,
    SUM(CASE WHEN OrderDateKey IS NULL THEN 1 ELSE 0 END)      AS OrderDateKeyNull,
    SUM(CASE WHEN CustomerKey IS NULL THEN 1 ELSE 0 END)       AS CustomerKeyNull,
    SUM(CASE WHEN SalesTerritoryKey IS NULL THEN 1 ELSE 0 END) AS TerritoryKeyNull,
    SUM(CASE WHEN SalesAmount IS NULL THEN 1 ELSE 0 END)       AS SalesAmountNull,
    SUM(CASE WHEN OrderQuantity IS NULL THEN 1 ELSE 0 END)     AS QuantityNull
FROM 
    dbo.FactInternetSales;


-- 4. Null rates - Internet Sales
SELECT
    'SalesAmount'                                                           AS FieldName,
    COUNT(*)                                                                AS TotalRows,
    SUM(CASE WHEN SalesAmount IS NULL THEN 1 ELSE 0 END)                    AS NullRows,
    SUM(CASE WHEN SalesAmount IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS NullRate
FROM 
    dbo.FactInternetSales
UNION ALL
SELECT
    'OrderQuantity',
    COUNT(*),
    SUM(CASE WHEN OrderQuantity IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN OrderQuantity IS NULL THEN 1 ELSE 0 END) * 100.0 / COUNT(*)
FROM 
    dbo.FactInternetSales;


-- 5. Null profiling - Reseller Sales
SELECT
    COUNT(*) AS TotalRows,
    SUM(CASE WHEN ProductKey IS NULL THEN 1 ELSE 0 END)        AS ProductKeyNull,
    SUM(CASE WHEN OrderDateKey IS NULL THEN 1 ELSE 0 END)      AS OrderDateKeyNull,
    SUM(CASE WHEN ResellerKey IS NULL THEN 1 ELSE 0 END)       AS ResellerKeyNull,
    SUM(CASE WHEN SalesTerritoryKey IS NULL THEN 1 ELSE 0 END) AS TerritoryKeyNull,
    SUM(CASE WHEN SalesAmount IS NULL THEN 1 ELSE 0 END)       AS SalesAmountNull,
    SUM(CASE WHEN OrderQuantity IS NULL THEN 1 ELSE 0 END)     AS QuantityNull
FROM 
    dbo.FactResellerSales;


-- 6. Null profiling - Customer
SELECT
    COUNT(*) AS TotalRows,
    SUM(CASE WHEN GeographyKey IS NULL THEN 1 ELSE 0 END) AS GeographyNull,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END)       AS GenderNull,
    SUM(CASE WHEN YearlyIncome IS NULL THEN 1 ELSE 0 END) AS IncomeNull
FROM 
    dbo.DimCustomer;


-- 7. Null profiling - Geography
SELECT
    COUNT(*) AS TotalRows,
    SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END)                     AS CityNull,
    SUM(CASE WHEN EnglishCountryRegionName IS NULL THEN 1 ELSE 0 END) AS CountryNull,
    SUM(CASE WHEN SalesTerritoryKey IS NULL THEN 1 ELSE 0 END)        AS TerritoryNull
FROM 
    dbo.DimGeography;


-- 8. Duplicate checks
SELECT CustomerKey,       COUNT(*) AS DuplicateCount FROM dbo.DimCustomer       GROUP BY CustomerKey       HAVING COUNT(*) > 1;
SELECT ProductKey,        COUNT(*) AS DuplicateCount FROM dbo.DimProduct        GROUP BY ProductKey        HAVING COUNT(*) > 1;
SELECT GeographyKey,      COUNT(*) AS DuplicateCount FROM dbo.DimGeography      GROUP BY GeographyKey      HAVING COUNT(*) > 1;
SELECT SalesTerritoryKey, COUNT(*) AS DuplicateCount FROM dbo.DimSalesTerritory GROUP BY SalesTerritoryKey HAVING COUNT(*) > 1;


-- 9. Duplicate Internet Sales records
SELECT
    SalesOrderNumber,
    SalesOrderLineNumber,
    COUNT(*) AS DuplicateCount
FROM 
    dbo.FactInternetSales
GROUP BY 
    SalesOrderNumber, 
    SalesOrderLineNumber
HAVING 
    COUNT(*) > 1;


-- 10. Duplicate Reseller Sales records
SELECT
    SalesOrderNumber,
    SalesOrderLineNumber,
    COUNT(*) AS DuplicateCount
FROM 
    dbo.FactResellerSales
GROUP BY 
    SalesOrderNumber, 
    SalesOrderLineNumber
HAVING 
    COUNT(*) > 1;


-- 11. Outlier/value checks
SELECT
    'Internet Sales'   AS Dataset,
    MIN(SalesAmount)   AS MinimumSales,
    MAX(SalesAmount)   AS MaximumSales,
    AVG(SalesAmount)   AS AverageSales,
    STDEV(SalesAmount) AS StandardDeviation
FROM 
    dbo.FactInternetSales
UNION ALL
SELECT
    'Reseller Sales',
    MIN(SalesAmount),
    MAX(SalesAmount),
    AVG(SalesAmount),
    STDEV(SalesAmount)
FROM 
    dbo.FactResellerSales;


-- 12. Negative sales
SELECT 'Internet Sales' AS Dataset, COUNT(*) AS NegativeSales FROM dbo.FactInternetSales WHERE SalesAmount < 0
UNION ALL 
SELECT 'Reseller Sales',            COUNT(*)                  FROM dbo.FactResellerSales WHERE SalesAmount < 0;


-- 13. Invalid discount values
SELECT 'Internet Sales' AS Dataset, COUNT(*) AS InvalidDiscount 
FROM dbo.FactInternetSales 
WHERE UnitPriceDiscountPct < 0 OR UnitPriceDiscountPct > 1
UNION ALL
SELECT 'Reseller Sales',            COUNT(*) 
FROM dbo.FactResellerSales 
WHERE UnitPriceDiscountPct < 0 OR UnitPriceDiscountPct > 1;


-- 14. Referential gaps
SELECT 'InternetSales -> Customer' AS CheckName, COUNT(*) AS MissingRows
FROM dbo.FactInternetSales f
    LEFT JOIN dbo.DimCustomer c 
        ON f.CustomerKey = c.CustomerKey
WHERE c.CustomerKey IS NULL;

SELECT 'InternetSales -> Product' AS CheckName, COUNT(*) AS MissingRows
FROM dbo.FactInternetSales f
    LEFT JOIN dbo.DimProduct p 
        ON f.ProductKey = p.ProductKey
WHERE p.ProductKey IS NULL;

SELECT 'InternetSales -> Date' AS CheckName, COUNT(*) AS MissingRows
FROM dbo.FactInternetSales f
    LEFT JOIN dbo.DimDate d 
        ON f.OrderDateKey = d.DateKey
WHERE d.DateKey IS NULL;

SELECT 'InternetSales -> Territory' AS CheckName, COUNT(*) AS MissingRows
FROM dbo.FactInternetSales f
    LEFT JOIN dbo.DimSalesTerritory t 
        ON f.SalesTerritoryKey = t.SalesTerritoryKey
WHERE t.SalesTerritoryKey IS NULL;

SELECT 'ResellerSales -> Product' AS CheckName, COUNT(*) AS MissingRows
FROM dbo.FactResellerSales f
    LEFT JOIN dbo.DimProduct p 
        ON f.ProductKey = p.ProductKey
WHERE p.ProductKey IS NULL;

SELECT 'ResellerSales -> Date' AS CheckName, COUNT(*) AS MissingRows
FROM dbo.FactResellerSales f
    LEFT JOIN dbo.DimDate d 
        ON f.OrderDateKey = d.DateKey
WHERE d.DateKey IS NULL;

SELECT 'ResellerSales -> Territory' AS CheckName, COUNT(*) AS MissingRows
FROM dbo.FactResellerSales f
    LEFT JOIN dbo.DimSalesTerritory t 
        ON f.SalesTerritoryKey = t.SalesTerritoryKey
WHERE t.SalesTerritoryKey IS NULL;


-- 15. Date coverage
SELECT MIN(OrderDate) AS EarliestDate, MAX(OrderDate) AS LatestDate FROM dbo.FactInternetSales;
SELECT MIN(OrderDate) AS EarliestDate, MAX(OrderDate) AS LatestDate FROM dbo.FactResellerSales;


-- 16. NA territory
SELECT
    SalesTerritoryKey,
    SalesTerritoryRegion,
    SalesTerritoryCountry,
    SalesTerritoryGroup
FROM 
    dbo.DimSalesTerritory
WHERE 
    SalesTerritoryKey = 11;