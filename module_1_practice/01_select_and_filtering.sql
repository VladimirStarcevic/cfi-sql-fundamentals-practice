SELECT TOP 20
    FirstName,
    LastName,
    EmailAddress,
    YearlyIncome
FROM DimCustomer
WHERE EnglishOccupation = 'Professional'
ORDER BY YearlyIncome DESC;

SELECT
    EnglishProductName,
    Color
FROM DimProduct
WHERE (Color = 'Red' OR Color = 'Black') AND ListPrice > 1000;



SELECT TOP 5
    ProductKey,
    CustomerKey,
    OrderDate,
    OrderQuantity,
    TotalProductCost
FROM FactInternetSales
WHERE (OrderQuantity BETWEEN 1 AND 2) AND TotalProductCost > 1000;