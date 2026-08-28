/* ADVENTUREWORKS DW2025
   FILE 3: DATA TRANSFORMATION
*/

-- 1. Clean Internet Sales

IF OBJECT_ID('dbo.CleanedInternetSales', 'U') IS NOT NULL
    DROP TABLE dbo.CleanedInternetSales;

SELECT DISTINCT
    f.SalesOrderNumber,
    f.SalesOrderLineNumber,
    f.ProductKey,
    f.CustomerKey,
    f.SalesTerritoryKey,
    CAST(f.OrderDate AS DATE)                               AS OrderDate,
    YEAR(f.OrderDate)                                       AS SalesYear,
    MONTH(f.OrderDate)                                      AS SalesMonth,
    f.OrderQuantity,
    f.UnitPrice,
    f.SalesAmount,
    f.UnitPriceDiscountPct,
    UPPER(ISNULL(t.SalesTerritoryRegion, 'UNKNOWN'))        AS SalesTerritoryRegion,
    UPPER(ISNULL(t.SalesTerritoryCountry, 'UNKNOWN'))       AS SalesTerritoryCountry,
    UPPER(ISNULL(t.SalesTerritoryGroup, 'UNKNOWN'))         AS SalesTerritoryGroup,
    UPPER(ISNULL(p.EnglishProductName, 'UNKNOWN'))          AS ProductName,
    UPPER(ISNULL(pc.EnglishProductCategoryName, 'UNKNOWN')) AS ProductCategory
INTO 
    dbo.CleanedInternetSales
FROM 
    dbo.FactInternetSales f
    INNER JOIN dbo.DimSalesTerritory t
        ON f.SalesTerritoryKey = t.SalesTerritoryKey
    INNER JOIN dbo.DimProduct p
        ON f.ProductKey = p.ProductKey
    LEFT JOIN dbo.DimProductSubcategory ps
        ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
    LEFT JOIN dbo.DimProductCategory pc
        ON ps.ProductCategoryKey = pc.ProductCategoryKey
WHERE 
    f.SalesTerritoryKey <> 11;


-- 2. Clean Reseller Sales

IF OBJECT_ID('dbo.CleanedResellerSales', 'U') IS NOT NULL
    DROP TABLE dbo.CleanedResellerSales;

SELECT DISTINCT
    f.SalesOrderNumber,
    f.SalesOrderLineNumber,
    f.ProductKey,
    f.ResellerKey,
    f.SalesTerritoryKey,
    CAST(f.OrderDate AS DATE)                               AS OrderDate,
    YEAR(f.OrderDate)                                       AS SalesYear,
    MONTH(f.OrderDate)                                      AS SalesMonth,
    f.OrderQuantity,
    f.UnitPrice,
    f.SalesAmount,
    f.UnitPriceDiscountPct,
    UPPER(ISNULL(t.SalesTerritoryRegion, 'UNKNOWN'))        AS SalesTerritoryRegion,
    UPPER(ISNULL(t.SalesTerritoryCountry, 'UNKNOWN'))       AS SalesTerritoryCountry,
    UPPER(ISNULL(t.SalesTerritoryGroup, 'UNKNOWN'))         AS SalesTerritoryGroup,
    UPPER(ISNULL(p.EnglishProductName, 'UNKNOWN'))          AS ProductName,
    UPPER(ISNULL(pc.EnglishProductCategoryName, 'UNKNOWN')) AS ProductCategory
INTO 
    dbo.CleanedResellerSales
FROM 
    dbo.FactResellerSales f
    INNER JOIN dbo.DimSalesTerritory t
        ON f.SalesTerritoryKey = t.SalesTerritoryKey
    INNER JOIN dbo.DimProduct p
        ON f.ProductKey = p.ProductKey
    LEFT JOIN dbo.DimProductSubcategory ps
        ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
    LEFT JOIN dbo.DimProductCategory pc
        ON ps.ProductCategoryKey = pc.ProductCategoryKey
WHERE 
    f.SalesTerritoryKey <> 11;


-- 3. Clean Customer data

IF OBJECT_ID('dbo.CleanedCustomer', 'U') IS NOT NULL
    DROP TABLE dbo.CleanedCustomer;

SELECT DISTINCT
    c.CustomerKey,
    UPPER(ISNULL(c.FirstName, 'UNKNOWN'))                AS FirstName,
    UPPER(ISNULL(c.LastName, 'UNKNOWN'))                 AS LastName,
    UPPER(ISNULL(c.Gender, 'UNKNOWN'))                   AS Gender,
    c.YearlyIncome,
    c.TotalChildren,
    c.NumberCarsOwned,
    UPPER(ISNULL(c.EnglishEducation, 'UNKNOWN'))         AS Education,
    UPPER(ISNULL(c.EnglishOccupation, 'UNKNOWN'))        AS Occupation,
    c.HouseOwnerFlag,
    CAST(c.DateFirstPurchase AS DATE)                    AS DateFirstPurchase,
    UPPER(ISNULL(g.City, 'UNKNOWN'))                     AS City,
    UPPER(ISNULL(g.StateProvinceName, 'UNKNOWN'))        AS StateProvinceName,
    UPPER(ISNULL(g.EnglishCountryRegionName, 'UNKNOWN')) AS Country
INTO 
    dbo.CleanedCustomer
FROM 
    dbo.DimCustomer c
    LEFT JOIN dbo.DimGeography g
        ON c.GeographyKey = g.GeographyKey;


-- 4. Clean Product data

IF OBJECT_ID('dbo.CleanedProduct', 'U') IS NOT NULL
    DROP TABLE dbo.CleanedProduct;

SELECT DISTINCT
    p.ProductKey,
    UPPER(ISNULL(p.EnglishProductName, 'UNKNOWN'))             AS ProductName,
    p.ProductSubcategoryKey,
    UPPER(ISNULL(ps.EnglishProductSubcategoryName, 'UNKNOWN')) AS ProductSubcategory,
    UPPER(ISNULL(pc.EnglishProductCategoryName, 'UNKNOWN'))    AS ProductCategory,
    p.StandardCost,
    p.ListPrice,
    UPPER(ISNULL(p.Color, 'UNKNOWN'))                          AS Color,
    UPPER(ISNULL(p.Size, 'UNKNOWN'))                           AS Size,
    p.Weight,
    p.DaysToManufacture
INTO 
    dbo.CleanedProduct
FROM 
    dbo.DimProduct p
    LEFT JOIN dbo.DimProductSubcategory ps
        ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
    LEFT JOIN dbo.DimProductCategory pc
        ON ps.ProductCategoryKey = pc.ProductCategoryKey;


-- 5. Check cleaned tables

SELECT * FROM dbo.CleanedInternetSales;
SELECT * FROM dbo.CleanedResellerSales;
SELECT * FROM dbo.CleanedCustomer;
SELECT * FROM dbo.CleanedProduct;