SELECT TOP (100)
    CONCAT(dc.FirstName, ' ', dc.LastName) AS [Customer Name],
    dc.EmailAddress,
    SUM(SalesAmount) AS [Total Spent]
FROM FactInternetSales  AS FIS
INNER JOIN DimCustomer AS dc
ON FIS.CustomerKey = dc.CustomerKey
GROUP BY dc.FirstName, dc.LastName, dc.EmailAddress
ORDER BY SUM(SalesAmount) DESC;


SELECT TOP(100)
                CONCAT(dc.FirstName, ' ', dc.LastName) AS [Customer Name],
                dc.EmailAddress,
                SUM(FIS.SalesAmount) AS [Total Spent],
                cu.CurrencyName
FROM
    FactInternetSales AS FIS
        INNER JOIN
    DimCustomer AS dc ON FIS.CustomerKey = dc.CustomerKey
        INNER JOIN
    DimCurrency AS cu ON FIS.CurrencyKey = cu.CurrencyKey
WHERE
    cu.CurrencyName = N'US Dollar'
GROUP BY
    dc.FirstName, dc.LastName, dc.EmailAddress, cu.CurrencyName
ORDER BY
    [Total Spent] DESC;
