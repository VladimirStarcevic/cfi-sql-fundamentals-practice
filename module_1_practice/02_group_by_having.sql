SELECT
    CustomerKey AS CustomerID,
    SUM(SalesAmount) AS 'Total Spent'
FROM
    FactInternetSales
GROUP BY
    CustomerKey
HAVING
    SUM(SalesAmount) > 5000
ORDER BY 'Total Spent' DESC;

SELECT SalesOrderNumber,
       SalesOrderLineNumber,
       SalesAmount,
       DiscountAmount
FROM FactInternetSales
WHERE DiscountAmount > 0 AND OrderQuantity = 1;

SELECT DISTINCT CurrencyKey
FROM FactInternetSales
ORDER BY CurrencyKey;