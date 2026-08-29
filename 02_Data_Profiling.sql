/* ADVENTUREWORKS DW2025
   FILE 2: DATA PROFILING
*/

USE AdventureWorksDW2025;
GO


-- 1. Row counts

SELECT 'FactInternetSales' AS TableName, COUNT(*) AS TotalRows 
FROM dbo.FactInternetSales

UNION ALL 
SELECT 'FactResellerSales', COUNT(*) 
FROM dbo.FactResellerSales

UNION ALL 
SELECT 'DimSalesTerritory', COUNT(*) 
FROM dbo.DimSalesTerritory

UNION ALL 
SELECT 'DimGeography', COUNT(*) 
FROM dbo.DimGeography

UNION ALL 
SELECT 'DimDate', COUNT(*) 
FROM dbo.DimDate

UNION ALL 
SELECT 'DimCustomer', COUNT(*) 
FROM dbo.DimCustomer

UNION ALL 
SELECT 'DimReseller', COUNT(*) 
FROM dbo.DimReseller

UNION ALL 
SELECT 'DimProduct', COUNT(*) 
FROM dbo.DimProduct

UNION ALL 
SELECT 'DimProductSubcategory', COUNT(*) 
FROM dbo.DimProductSubcategory

UNION ALL 
SELECT 'DimProductCategory', COUNT(*) 
FROM dbo.DimProductCategory;


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
        'DimProduct',
        'DimProductSubcategory',
        'DimProductCategory'
    )
ORDER BY 
    TABLE_NAME, 
    ORDINAL_POSITION;


-- 3. Null profiling - Internet Sales

SELECT
    COUNT(*) AS TotalRows,

    SUM(CASE WHEN SalesOrderNumber IS NULL THEN 1 ELSE 0 END)     AS SalesOrderNumberNull,
    SUM(CASE WHEN SalesOrderLineNumber IS NULL THEN 1 ELSE 0 END) AS SalesOrderLineNumberNull,
    SUM(CASE WHEN ProductKey IS NULL THEN 1 ELSE 0 END)           AS ProductKeyNull,
    SUM(CASE WHEN OrderDateKey IS NULL THEN 1 ELSE 0 END)         AS OrderDateKeyNull,
    SUM(CASE WHEN CustomerKey IS NULL THEN 1 ELSE 0 END)          AS CustomerKeyNull,
    SUM(CASE WHEN SalesTerritoryKey IS NULL THEN 1 ELSE 0 END)    AS TerritoryKeyNull,
    SUM(CASE WHEN OrderQuantity IS NULL THEN 1 ELSE 0 END)        AS QuantityNull,
    SUM(CASE WHEN UnitPrice IS NULL THEN 1 ELSE 0 END)            AS UnitPriceNull,
    SUM(CASE WHEN SalesAmount IS NULL THEN 1 ELSE 0 END)          AS SalesAmountNull,
    SUM(CASE WHEN UnitPriceDiscountPct IS NULL THEN 1 ELSE 0 END) AS DiscountNull,
    SUM(CASE WHEN TaxAmt IS NULL THEN 1 ELSE 0 END)               AS TaxAmtNull,
    SUM(CASE WHEN Freight IS NULL THEN 1 ELSE 0 END)              AS FreightNull
FROM 
    dbo.FactInternetSales;


-- 4. Null profiling - Reseller Sales

SELECT
    COUNT(*) AS TotalRows,

    SUM(CASE WHEN SalesOrderNumber IS NULL THEN 1 ELSE 0 END)     AS SalesOrderNumberNull,
    SUM(CASE WHEN SalesOrderLineNumber IS NULL THEN 1 ELSE 0 END) AS SalesOrderLineNumberNull,
    SUM(CASE WHEN ProductKey IS NULL THEN 1 ELSE 0 END)           AS ProductKeyNull,
    SUM(CASE WHEN OrderDateKey IS NULL THEN 1 ELSE 0 END)         AS OrderDateKeyNull,
    SUM(CASE WHEN ResellerKey IS NULL THEN 1 ELSE 0 END)          AS ResellerKeyNull,
    SUM(CASE WHEN SalesTerritoryKey IS NULL THEN 1 ELSE 0 END)    AS TerritoryKeyNull,
    SUM(CASE WHEN OrderQuantity IS NULL THEN 1 ELSE 0 END)        AS QuantityNull,
    SUM(CASE WHEN UnitPrice IS NULL THEN 1 ELSE 0 END)            AS UnitPriceNull,
    SUM(CASE WHEN SalesAmount IS NULL THEN 1 ELSE 0 END)          AS SalesAmountNull,
    SUM(CASE WHEN UnitPriceDiscountPct IS NULL THEN 1 ELSE 0 END) AS DiscountNull,
    SUM(CASE WHEN TaxAmt IS NULL THEN 1 ELSE 0 END)               AS TaxAmtNull,
    SUM(CASE WHEN Freight IS NULL THEN 1 ELSE 0 END)              AS FreightNull
FROM 
    dbo.FactResellerSales;


-- 5. Null profiling - Customer

SELECT
    COUNT(*) AS TotalRows,

    SUM(CASE WHEN CustomerKey IS NULL THEN 1 ELSE 0 END)       AS CustomerKeyNull,
    SUM(CASE WHEN GeographyKey IS NULL THEN 1 ELSE 0 END)      AS GeographyKeyNull,
    SUM(CASE WHEN FirstName IS NULL THEN 1 ELSE 0 END)         AS FirstNameNull,
    SUM(CASE WHEN LastName IS NULL THEN 1 ELSE 0 END)          AS LastNameNull,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END)             AS GenderNull,
    SUM(CASE WHEN YearlyIncome IS NULL THEN 1 ELSE 0 END)      AS IncomeNull,
    SUM(CASE WHEN TotalChildren IS NULL THEN 1 ELSE 0 END)     AS ChildrenNull,
    SUM(CASE WHEN NumberCarsOwned IS NULL THEN 1 ELSE 0 END)   AS CarsOwnedNull,
    SUM(CASE WHEN EnglishEducation IS NULL THEN 1 ELSE 0 END)  AS EducationNull,
    SUM(CASE WHEN EnglishOccupation IS NULL THEN 1 ELSE 0 END) AS OccupationNull,
    SUM(CASE WHEN HouseOwnerFlag IS NULL THEN 1 ELSE 0 END)    AS HouseOwnerNull,
    SUM(CASE WHEN DateFirstPurchase IS NULL THEN 1 ELSE 0 END) AS FirstPurchaseNull
FROM 
    dbo.DimCustomer;


-- 6. Null profiling - Geography

SELECT
    COUNT(*) AS TotalRows,

    SUM(CASE WHEN GeographyKey IS NULL THEN 1 ELSE 0 END)             AS GeographyKeyNull,
    SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END)                    AS CityNull,
    SUM(CASE WHEN StateProvinceName IS NULL THEN 1 ELSE 0 END)       AS StateProvinceNull,
    SUM(CASE WHEN EnglishCountryRegionName IS NULL THEN 1 ELSE 0 END) AS CountryNull,
    SUM(CASE WHEN SalesTerritoryKey IS NULL THEN 1 ELSE 0 END)       AS TerritoryNull
FROM 
    dbo.DimGeography;


-- 7. Null profiling - Sales Territory

SELECT
    COUNT(*) AS TotalRows,

    SUM(CASE WHEN SalesTerritoryKey IS NULL THEN 1 ELSE 0 END)      AS TerritoryKeyNull,
    SUM(CASE WHEN SalesTerritoryRegion IS NULL THEN 1 ELSE 0 END)  AS RegionNull,
    SUM(CASE WHEN SalesTerritoryCountry IS NULL THEN 1 ELSE 0 END) AS CountryNull,
    SUM(CASE WHEN SalesTerritoryGroup IS NULL THEN 1 ELSE 0 END)   AS GroupNull
FROM 
    dbo.DimSalesTerritory;


-- 8. Null profiling - Reseller

SELECT
    COUNT(*) AS TotalRows,

    SUM(CASE WHEN ResellerKey IS NULL THEN 1 ELSE 0 END)       AS ResellerKeyNull,
    SUM(CASE WHEN ResellerName IS NULL THEN 1 ELSE 0 END)      AS ResellerNameNull,
    SUM(CASE WHEN BusinessType IS NULL THEN 1 ELSE 0 END)     AS BusinessTypeNull,
    SUM(CASE WHEN Phone IS NULL THEN 1 ELSE 0 END)             AS PhoneNull,
    SUM(CASE WHEN GeographyKey IS NULL THEN 1 ELSE 0 END)     AS GeographyKeyNull
FROM 
    dbo.DimReseller;


-- 9. Null profiling - Product

SELECT
    COUNT(*) AS TotalRows,

    SUM(CASE WHEN ProductKey IS NULL THEN 1 ELSE 0 END)              AS ProductKeyNull,
    SUM(CASE WHEN ProductSubcategoryKey IS NULL THEN 1 ELSE 0 END)  AS SubcategoryKeyNull,
    SUM(CASE WHEN EnglishProductName IS NULL THEN 1 ELSE 0 END)     AS ProductNameNull,
    SUM(CASE WHEN StandardCost IS NULL THEN 1 ELSE 0 END)           AS StandardCostNull,
    SUM(CASE WHEN ListPrice IS NULL THEN 1 ELSE 0 END)              AS ListPriceNull,
    SUM(CASE WHEN Color IS NULL THEN 1 ELSE 0 END)                  AS ColorNull,
    SUM(CASE WHEN Size IS NULL THEN 1 ELSE 0 END)                   AS SizeNull,
    SUM(CASE WHEN Weight IS NULL THEN 1 ELSE 0 END)                 AS WeightNull,
    SUM(CASE WHEN DaysToManufacture IS NULL THEN 1 ELSE 0 END)      AS DaysToManufactureNull
FROM 
    dbo.DimProduct;


-- 10. Null profiling - Product Subcategory

SELECT
    COUNT(*) AS TotalRows,

    SUM(CASE WHEN ProductSubcategoryKey IS NULL THEN 1 ELSE 0 END) 
        AS SubcategoryKeyNull,

    SUM(CASE WHEN EnglishProductSubcategoryName IS NULL THEN 1 ELSE 0 END) 
        AS SubcategoryNameNull,

    SUM(CASE WHEN ProductCategoryKey IS NULL THEN 1 ELSE 0 END) 
        AS CategoryKeyNull
FROM 
    dbo.DimProductSubcategory;


-- 11. Null profiling - Product Category

SELECT
    COUNT(*) AS TotalRows,

    SUM(CASE WHEN ProductCategoryKey IS NULL THEN 1 ELSE 0 END) 
        AS CategoryKeyNull,

    SUM(CASE WHEN EnglishProductCategoryName IS NULL THEN 1 ELSE 0 END) 
        AS CategoryNameNull
FROM 
    dbo.DimProductCategory;


-- 12. Null profiling - Date

SELECT
    COUNT(*) AS TotalRows,

    SUM(CASE WHEN DateKey IS NULL THEN 1 ELSE 0 END) 
        AS DateKeyNull,

    SUM(CASE WHEN FullDateAlternateKey IS NULL THEN 1 ELSE 0 END) 
        AS FullDateNull,

    SUM(CASE WHEN DayNumberOfWeek IS NULL THEN 1 ELSE 0 END) 
        AS DayNumberOfWeekNull,

    SUM(CASE WHEN EnglishDayNameOfWeek IS NULL THEN 1 ELSE 0 END) 
        AS DayNameNull,

    SUM(CASE WHEN DayNumberOfMonth IS NULL THEN 1 ELSE 0 END) 
        AS DayNumberOfMonthNull,

    SUM(CASE WHEN DayNumberOfYear IS NULL THEN 1 ELSE 0 END) 
        AS DayNumberOfYearNull,

    SUM(CASE WHEN WeekNumberOfYear IS NULL THEN 1 ELSE 0 END) 
        AS WeekNumberNull,

    SUM(CASE WHEN EnglishMonthName IS NULL THEN 1 ELSE 0 END) 
        AS MonthNameNull,

    SUM(CASE WHEN MonthNumberOfYear IS NULL THEN 1 ELSE 0 END) 
        AS MonthNumberNull,

    SUM(CASE WHEN CalendarQuarter IS NULL THEN 1 ELSE 0 END) 
        AS CalendarQuarterNull,

    SUM(CASE WHEN CalendarYear IS NULL THEN 1 ELSE 0 END) 
        AS CalendarYearNull,

    SUM(CASE WHEN CalendarSemester IS NULL THEN 1 ELSE 0 END) 
        AS CalendarSemesterNull,

    SUM(CASE WHEN FiscalQuarter IS NULL THEN 1 ELSE 0 END) 
        AS FiscalQuarterNull,

    SUM(CASE WHEN FiscalYear IS NULL THEN 1 ELSE 0 END) 
        AS FiscalYearNull,

    SUM(CASE WHEN FiscalSemester IS NULL THEN 1 ELSE 0 END) 
        AS FiscalSemesterNull
FROM 
    dbo.DimDate;


-- 13. Duplicate checks - Dimension Keys

SELECT 
    CustomerKey, 
    COUNT(*) AS DuplicateCount 
FROM dbo.DimCustomer
GROUP BY CustomerKey
HAVING COUNT(*) > 1;


SELECT 
    ProductKey, 
    COUNT(*) AS DuplicateCount 
FROM dbo.DimProduct
GROUP BY ProductKey
HAVING COUNT(*) > 1;


SELECT 
    GeographyKey, 
    COUNT(*) AS DuplicateCount 
FROM dbo.DimGeography
GROUP BY GeographyKey
HAVING COUNT(*) > 1;


SELECT 
    SalesTerritoryKey, 
    COUNT(*) AS DuplicateCount 
FROM dbo.DimSalesTerritory
GROUP BY SalesTerritoryKey
HAVING COUNT(*) > 1;


SELECT 
    ResellerKey, 
    COUNT(*) AS DuplicateCount 
FROM dbo.DimReseller
GROUP BY ResellerKey
HAVING COUNT(*) > 1;


SELECT 
    ProductSubcategoryKey, 
    COUNT(*) AS DuplicateCount 
FROM dbo.DimProductSubcategory
GROUP BY ProductSubcategoryKey
HAVING COUNT(*) > 1;


SELECT 
    ProductCategoryKey, 
    COUNT(*) AS DuplicateCount 
FROM dbo.DimProductCategory
GROUP BY ProductCategoryKey
HAVING COUNT(*) > 1;


SELECT 
    DateKey, 
    COUNT(*) AS DuplicateCount 
FROM dbo.DimDate
GROUP BY DateKey
HAVING COUNT(*) > 1;


-- 14. Duplicate Internet Sales records

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


-- 15. Duplicate Reseller Sales records

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


-- 16. Outlier/value checks - Sales Amount

SELECT
    'Internet Sales' AS Dataset,
    MIN(SalesAmount) AS MinimumSales,
    MAX(SalesAmount) AS MaximumSales,
    AVG(SalesAmount) AS AverageSales,
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


-- 17. Outlier/value checks - Order Quantity

SELECT
    'Internet Sales' AS Dataset,
    MIN(OrderQuantity) AS MinimumQuantity,
    MAX(OrderQuantity) AS MaximumQuantity,
    AVG(OrderQuantity) AS AverageQuantity,
    STDEV(OrderQuantity) AS StandardDeviation
FROM 
    dbo.FactInternetSales

UNION ALL

SELECT
    'Reseller Sales',
    MIN(OrderQuantity),
    MAX(OrderQuantity),
    AVG(OrderQuantity),
    STDEV(OrderQuantity)
FROM 
    dbo.FactResellerSales;


-- 18. Negative sales

SELECT 
    'Internet Sales' AS Dataset, 
    COUNT(*) AS NegativeSales 
FROM dbo.FactInternetSales 
WHERE SalesAmount < 0

UNION ALL 

SELECT 
    'Reseller Sales', 
    COUNT(*) 
FROM dbo.FactResellerSales 
WHERE SalesAmount < 0;


-- 19. Invalid discount values

SELECT 
    'Internet Sales' AS Dataset, 
    COUNT(*) AS InvalidDiscount 
FROM dbo.FactInternetSales 
WHERE UnitPriceDiscountPct < 0 
   OR UnitPriceDiscountPct > 1

UNION ALL

SELECT 
    'Reseller Sales', 
    COUNT(*) 
FROM dbo.FactResellerSales 
WHERE UnitPriceDiscountPct < 0 
   OR UnitPriceDiscountPct > 1;


-- 20. Invalid quantity values

SELECT 
    'Internet Sales' AS Dataset, 
    COUNT(*) AS InvalidQuantity 
FROM dbo.FactInternetSales 
WHERE OrderQuantity <= 0

UNION ALL

SELECT 
    'Reseller Sales', 
    COUNT(*) 
FROM dbo.FactResellerSales 
WHERE OrderQuantity <= 0;


-- 21. Invalid price values

SELECT 
    'Internet Sales' AS Dataset, 
    COUNT(*) AS InvalidUnitPrice 
FROM dbo.FactInternetSales 
WHERE UnitPrice < 0

UNION ALL

SELECT 
    'Reseller Sales', 
    COUNT(*) 
FROM dbo.FactResellerSales 
WHERE UnitPrice < 0;


-- 22. Referential gaps - Internet Sales

SELECT 
    'InternetSales -> Customer' AS CheckName, 
    COUNT(*) AS MissingRows
FROM dbo.FactInternetSales f
LEFT JOIN dbo.DimCustomer c 
    ON f.CustomerKey = c.CustomerKey
WHERE c.CustomerKey IS NULL;


SELECT 
    'InternetSales -> Product' AS CheckName, 
    COUNT(*) AS MissingRows
FROM dbo.FactInternetSales f
LEFT JOIN dbo.DimProduct p 
    ON f.ProductKey = p.ProductKey
WHERE p.ProductKey IS NULL;


SELECT 
    'InternetSales -> Date' AS CheckName, 
    COUNT(*) AS MissingRows
FROM dbo.FactInternetSales f
LEFT JOIN dbo.DimDate d 
    ON f.OrderDateKey = d.DateKey
WHERE d.DateKey IS NULL;


SELECT 
    'InternetSales -> Territory' AS CheckName, 
    COUNT(*) AS MissingRows
FROM dbo.FactInternetSales f
LEFT JOIN dbo.DimSalesTerritory t 
    ON f.SalesTerritoryKey = t.SalesTerritoryKey
WHERE t.SalesTerritoryKey IS NULL;


-- 23. Referential gaps - Reseller Sales

SELECT 
    'ResellerSales -> Reseller' AS CheckName, 
    COUNT(*) AS MissingRows
FROM dbo.FactResellerSales f
LEFT JOIN dbo.DimReseller r 
    ON f.ResellerKey = r.ResellerKey
WHERE r.ResellerKey IS NULL;


SELECT 
    'ResellerSales -> Product' AS CheckName, 
    COUNT(*) AS MissingRows
FROM dbo.FactResellerSales f
LEFT JOIN dbo.DimProduct p 
    ON f.ProductKey = p.ProductKey
WHERE p.ProductKey IS NULL;


SELECT 
    'ResellerSales -> Date' AS CheckName, 
    COUNT(*) AS MissingRows
FROM dbo.FactResellerSales f
LEFT JOIN dbo.DimDate d 
    ON f.OrderDateKey = d.DateKey
WHERE d.DateKey IS NULL;


SELECT 
    'ResellerSales -> Territory' AS CheckName, 
    COUNT(*) AS MissingRows
FROM dbo.FactResellerSales f
LEFT JOIN dbo.DimSalesTerritory t 
    ON f.SalesTerritoryKey = t.SalesTerritoryKey
WHERE t.SalesTerritoryKey IS NULL;


-- 24. Additional referential checks

SELECT 
    'Customer -> Geography' AS CheckName, 
    COUNT(*) AS MissingRows
FROM dbo.DimCustomer c
LEFT JOIN dbo.DimGeography g
    ON c.GeographyKey = g.GeographyKey
WHERE c.GeographyKey IS NOT NULL
  AND g.GeographyKey IS NULL;


SELECT 
    'Reseller -> Geography' AS CheckName, 
    COUNT(*) AS MissingRows
FROM dbo.DimReseller r
LEFT JOIN dbo.DimGeography g
    ON r.GeographyKey = g.GeographyKey
WHERE r.GeographyKey IS NOT NULL
  AND g.GeographyKey IS NULL;


SELECT 
    'Geography -> Territory' AS CheckName, 
    COUNT(*) AS MissingRows
FROM dbo.DimGeography g
LEFT JOIN dbo.DimSalesTerritory t
    ON g.SalesTerritoryKey = t.SalesTerritoryKey
WHERE g.SalesTerritoryKey IS NOT NULL
  AND t.SalesTerritoryKey IS NULL;


SELECT 
    'Product -> Subcategory' AS CheckName, 
    COUNT(*) AS MissingRows
FROM dbo.DimProduct p
LEFT JOIN dbo.DimProductSubcategory ps
    ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
WHERE p.ProductSubcategoryKey IS NOT NULL
  AND ps.ProductSubcategoryKey IS NULL;


SELECT 
    'Subcategory -> Category' AS CheckName, 
    COUNT(*) AS MissingRows
FROM dbo.DimProductSubcategory ps
LEFT JOIN dbo.DimProductCategory pc
    ON ps.ProductCategoryKey = pc.ProductCategoryKey
WHERE ps.ProductCategoryKey IS NOT NULL
  AND pc.ProductCategoryKey IS NULL;


-- 25. Date coverage

SELECT 
    MIN(OrderDate) AS EarliestDate, 
    MAX(OrderDate) AS LatestDate 
FROM dbo.FactInternetSales;


SELECT 
    MIN(OrderDate) AS EarliestDate, 
    MAX(OrderDate) AS LatestDate 
FROM dbo.FactResellerSales;


-- 26. Date dimension coverage

SELECT
    MIN(FullDateAlternateKey) AS EarliestDate,
    MAX(FullDateAlternateKey) AS LatestDate,
    MIN(CalendarYear) AS EarliestCalendarYear,
    MAX(CalendarYear) AS LatestCalendarYear
FROM dbo.DimDate;


-- 27. Invalid calendar values

SELECT 
    COUNT(*) AS InvalidMonthNumber
FROM dbo.DimDate
WHERE MonthNumberOfYear < 1
   OR MonthNumberOfYear > 12;


SELECT 
    COUNT(*) AS InvalidCalendarQuarter
FROM dbo.DimDate
WHERE CalendarQuarter < 1
   OR CalendarQuarter > 4;


SELECT 
    COUNT(*) AS InvalidCalendarSemester
FROM dbo.DimDate
WHERE CalendarSemester < 1
   OR CalendarSemester > 2;


-- 28. NA territory

SELECT
    SalesTerritoryKey,
    SalesTerritoryRegion,
    SalesTerritoryCountry,
    SalesTerritoryGroup
FROM 
    dbo.DimSalesTerritory
WHERE 
    SalesTerritoryKey = 11;
