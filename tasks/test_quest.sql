-- Question 11
-- What is the first and last name of the Adventure Works customer that spent the most on the website?
--
-- Only include transactions paid in currency ‘US Dollar’.
--
-- You will need to use the FactInternetSales, dimCustomer and dimCurrency tables.

SELECT TOP 1
    dim.FirstName,
    dim.LastName,
    SUM(FIS.SalesAmount) AS TotalSpent
FROM
    FactInternetSales AS FIS
        INNER JOIN
    DimCustomer AS dim ON FIS.CustomerKey = dim.CustomerKey
        INNER JOIN
    DimCurrency AS dimc ON FIS.CurrencyKey = dimc.CurrencyKey
WHERE
    dimc.CurrencyName = 'US Dollar'
GROUP BY
    dim.FirstName, dim.LastName
ORDER BY
    TotalSpent DESC;

--2 What was the English name of the promotion that generated the most sales with the network of resellers?
-- Only include transactions paid in ‘EURO’
-- Exclude the English promotion name ‘No Discount’.
-- Do not include promotions where the left of the name is ‘Volume’
--  You will need to use the FactResellerSales, dimPromotion and dimCurrency tables.

SELECT TOP 1
             dp.EnglishPromotionName AS [Promotion Name],
             SUM(FRS.SalesAmount) AS [Total Spent]
FROM
    FactResellerSales AS FRS
        INNER JOIN
    DimPromotion AS dp ON FRS.PromotionKey = dp.PromotionKey
        INNER JOIN
    DimCurrency AS dc ON FRS.CurrencyKey = dc.CurrencyKey
WHERE
    dp.EnglishPromotionName != 'No Discount'
  AND dp.EnglishPromotionName NOT LIKE 'Volume%'
  AND dc.CurrencyName = 'EURO'
GROUP BY
    dp.EnglishPromotionName
ORDER BY
    [Total Spent] DESC;

-- 3 How many resellers are there in the United States? You will need to use the dimReseller and dimGeography tables.
SELECT
    COUNT(*) AS US_Reseller_Count
FROM
    DimReseller AS r
        INNER JOIN
    DimGeography AS g ON r.GeographyKey = g.GeographyKey
WHERE
    g.EnglishCountryRegionName = 'United States';

--4 What is the best-selling online product in the ‘North America’ sales territory group?
-- You will need to use the FactInternetSales , dimProduct and dimSalesTerritory tables.

SELECT TOP 1
    p.EnglishProductName,
    SUM(fs.SalesAmount) AS TotalRevenue
FROM
    FactInternetSales AS fs
        INNER JOIN
    DimProduct AS p ON fs.ProductKey = p.ProductKey
        INNER JOIN
    DimSalesTerritory AS st ON fs.SalesTerritoryKey = st.SalesTerritoryKey
WHERE
    st.SalesTerritoryGroup = 'North America'
GROUP BY
    p.EnglishProductName
ORDER BY
    TotalRevenue DESC;

SELECT
    MaritalStatus,
    COUNT(*) AS Number,
    CAST(COUNT(*) AS FLOAT) / (SELECT COUNT(*) FROM DimEmployee WHERE CurrentFlag = 1) * 100 AS Pct_of_Total
FROM
    DimEmployee
WHERE
    CurrentFlag = 1
GROUP BY
    MaritalStatus;