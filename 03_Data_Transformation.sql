/* ADVENTUREWORKS DW2025
   FILE 3: DATA TRANSFORMATION
*/

USE AdventureWorksDW2025;
GO


-- 1. Clean Internet Sales

IF OBJECT_ID('dbo.CleanedInternetSales', 'U') IS NOT NULL
    DROP TABLE dbo.CleanedInternetSales;

SELECT DISTINCT

    f.SalesOrderNumber,
    f.SalesOrderLineNumber,
    f.ProductKey,
    f.CustomerKey,
    f.SalesTerritoryKey,

    CAST(f.OrderDate AS DATE) AS OrderDate,
    YEAR(f.OrderDate) AS SalesYear,
    MONTH(f.OrderDate) AS SalesMonth,

    ISNULL(f.OrderQuantity, 0) AS OrderQuantity,
    ISNULL(f.UnitPrice, 0) AS UnitPrice,
    ISNULL(f.SalesAmount, 0) AS SalesAmount,
    ISNULL(f.UnitPriceDiscountPct, 0) AS UnitPriceDiscountPct,

    UPPER(ISNULL(t.SalesTerritoryRegion, 'UNKNOWN')) AS SalesTerritoryRegion,
    UPPER(ISNULL(t.SalesTerritoryCountry, 'UNKNOWN')) AS SalesTerritoryCountry,
    UPPER(ISNULL(t.SalesTerritoryGroup, 'UNKNOWN')) AS SalesTerritoryGroup,

    UPPER(ISNULL(p.EnglishProductName, 'UNKNOWN')) AS ProductName,
    UPPER(ISNULL(pc.EnglishProductCategoryName, 'UNKNOWN')) AS ProductCategory

INTO dbo.CleanedInternetSales

FROM dbo.FactInternetSales f

INNER JOIN dbo.DimSalesTerritory t
    ON f.SalesTerritoryKey = t.SalesTerritoryKey

INNER JOIN dbo.DimProduct p
    ON f.ProductKey = p.ProductKey

LEFT JOIN dbo.DimProductSubcategory ps
    ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey

LEFT JOIN dbo.DimProductCategory pc
    ON ps.ProductCategoryKey = pc.ProductCategoryKey

WHERE f.SalesTerritoryKey <> 11;


-- 2. Clean Reseller Sales

IF OBJECT_ID('dbo.CleanedResellerSales', 'U') IS NOT NULL
    DROP TABLE dbo.CleanedResellerSales;

SELECT DISTINCT

    f.SalesOrderNumber,
    f.SalesOrderLineNumber,
    f.ProductKey,
    f.ResellerKey,
    f.SalesTerritoryKey,

    CAST(f.OrderDate AS DATE) AS OrderDate,
    YEAR(f.OrderDate) AS SalesYear,
    MONTH(f.OrderDate) AS SalesMonth,

    ISNULL(f.OrderQuantity, 0) AS OrderQuantity,
    ISNULL(f.UnitPrice, 0) AS UnitPrice,
    ISNULL(f.SalesAmount, 0) AS SalesAmount,
    ISNULL(f.UnitPriceDiscountPct, 0) AS UnitPriceDiscountPct,

    UPPER(ISNULL(t.SalesTerritoryRegion, 'UNKNOWN')) AS SalesTerritoryRegion,
    UPPER(ISNULL(t.SalesTerritoryCountry, 'UNKNOWN')) AS SalesTerritoryCountry,
    UPPER(ISNULL(t.SalesTerritoryGroup, 'UNKNOWN')) AS SalesTerritoryGroup,

    UPPER(ISNULL(p.EnglishProductName, 'UNKNOWN')) AS ProductName,
    UPPER(ISNULL(pc.EnglishProductCategoryName, 'UNKNOWN')) AS ProductCategory

INTO dbo.CleanedResellerSales

FROM dbo.FactResellerSales f

INNER JOIN dbo.DimSalesTerritory t
    ON f.SalesTerritoryKey = t.SalesTerritoryKey

INNER JOIN dbo.DimProduct p
    ON f.ProductKey = p.ProductKey

LEFT JOIN dbo.DimProductSubcategory ps
    ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey

LEFT JOIN dbo.DimProductCategory pc
    ON ps.ProductCategoryKey = pc.ProductCategoryKey

WHERE f.SalesTerritoryKey <> 11;


-- 3. Clean Customer Data

IF OBJECT_ID('dbo.CleanedCustomer', 'U') IS NOT NULL
    DROP TABLE dbo.CleanedCustomer;

SELECT DISTINCT

    c.CustomerKey,

    UPPER(ISNULL(c.FirstName, 'UNKNOWN')) AS FirstName,
    UPPER(ISNULL(c.LastName, 'UNKNOWN')) AS LastName,
    UPPER(ISNULL(c.Gender, 'UNKNOWN')) AS Gender,

    ISNULL(c.YearlyIncome, 0) AS YearlyIncome,
    ISNULL(c.TotalChildren, 0) AS TotalChildren,
    ISNULL(c.NumberCarsOwned, 0) AS NumberCarsOwned,

    UPPER(ISNULL(c.EnglishEducation, 'UNKNOWN')) AS Education,
    UPPER(ISNULL(c.EnglishOccupation, 'UNKNOWN')) AS Occupation,

    ISNULL(c.HouseOwnerFlag, 0) AS HouseOwnerFlag,

    CAST(c.DateFirstPurchase AS DATE) AS DateFirstPurchase,

    UPPER(ISNULL(g.City, 'UNKNOWN')) AS City,
    UPPER(ISNULL(g.StateProvinceName, 'UNKNOWN')) AS StateProvinceName,
    UPPER(ISNULL(g.EnglishCountryRegionName, 'UNKNOWN')) AS Country

INTO dbo.CleanedCustomer

FROM dbo.DimCustomer c

LEFT JOIN dbo.DimGeography g
    ON c.GeographyKey = g.GeographyKey;


-- 4. Clean Product Data

IF OBJECT_ID('dbo.CleanedProduct', 'U') IS NOT NULL
    DROP TABLE dbo.CleanedProduct;

SELECT DISTINCT

    p.ProductKey,

    UPPER(ISNULL(p.EnglishProductName, 'UNKNOWN')) AS ProductName,

    p.ProductSubcategoryKey,

    UPPER(ISNULL(ps.EnglishProductSubcategoryName, 'UNKNOWN')) 
        AS ProductSubcategory,

    UPPER(ISNULL(pc.EnglishProductCategoryName, 'UNKNOWN')) 
        AS ProductCategory,

    ISNULL(p.StandardCost, 0) AS StandardCost,
    ISNULL(p.ListPrice, 0) AS ListPrice,

    UPPER(ISNULL(p.Color, 'UNKNOWN')) AS Color,

    ISNULL(p.Size, 'UNKNOWN') AS Size,

    ISNULL(p.Weight, 0) AS Weight,

    ISNULL(p.DaysToManufacture, 0) AS DaysToManufacture

INTO dbo.CleanedProduct

FROM dbo.DimProduct p

LEFT JOIN dbo.DimProductSubcategory ps
    ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey

LEFT JOIN dbo.DimProductCategory pc
    ON ps.ProductCategoryKey = pc.ProductCategoryKey;


-- 5. Check Cleaned Tables

SELECT * FROM dbo.CleanedInternetSales;

SELECT * FROM dbo.CleanedResellerSales;

SELECT * FROM dbo.CleanedCustomer;

SELECT * FROM dbo.CleanedProduct;
