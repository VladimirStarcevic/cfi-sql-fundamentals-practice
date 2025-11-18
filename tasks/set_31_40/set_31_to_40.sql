-- Zadatak 31: Jednostavan INNER JOIN
-- Zadatak: Spoji tabele FactInternetSales i DimCustomer da prikažeš prvih 20 prodaja sa imenom i prezimenom kupca.
-- Prikaži SalesOrderNumber, FirstName, LastName, SalesAmount.

SELECT TOP 20
    FIS.SalesOrderNumber AS [Sales Order Number],
    CONCAT(FirstName, ' ', LastName) AS [Customer Name],
    FIS.SalesAmount AS [Sales Amount]
FROM
    FactInternetSales AS FIS
INNER JOIN
    DimCustomer AS dc
ON FIS.CustomerKey = dc.CustomerKey
ORDER BY FIS.SalesAmount DESC;

-- Zadatak 32: INNER JOIN sa Agregacijom
-- Zadatak: Spoji FactInternetSales sa DimProduct i izračunaj ukupan iznos prodaje (SUM(SalesAmount)) za svaki proizvod.
-- Prikaži ime proizvoda i ukupan iznos. Sortiraj po iznosu opadajuće, prikaži top 15.

SELECT TOP 15
    EnglishProductName AS [Product Name],
    SUM(SalesAmount) AS [Total Sale]
FROM
    FactInternetSales AS FIS
INNER JOIN
    DimProduct AS dimp
ON FIS.ProductKey = dimp.ProductKey
GROUP BY EnglishProductName
ORDER BY [Total Sale] DESC;

-- Zadatak 33: INNER JOIN Tri Tabele
-- Zadatak: Spoji FactInternetSales,
-- DimProduct i DimProductSubcategory da prikažeš prvih 20 prodaja sa imenom proizvoda i nazivom potkategorije.
-- Prikaži SalesOrderNumber, EnglishProductName, ime potkategorije (EnglishProductSubcategoryName).

SELECT TOP 20
    SalesOrderNumber AS [Sales Order Number],
    EnglishProductName AS [Product Name],
    EnglishProductSubcategoryName AS [Type Of Product]
FROM
    FactInternetSales AS FIS
INNER JOIN
    DimProduct AS dimp
ON FIS.ProductKey = dimp.ProductKey
INNER JOIN
    DimProductSubcategory AS dimps
ON dimp.ProductSubcategoryKey = dimps.ProductSubcategoryKey
ORDER BY SalesOrderNumber;

-- Zadatak 34: LEFT JOIN Osnove
-- Zadatak: Prikaži sve kupce iz DimCustomer (prvih 30) i, ako postoje, njihov ukupan broj internet kupovina iz FactInternetSales.
-- Prikaži CustomerKey, FirstName, LastName, i broj kupovina (0 ako nema kupovina).

SELECT TOP 30
    dimc.CustomerKey AS [Customer ID],
    CONCAT(dimc.FirstName, ' ', dimc.LastName) AS [Customer Name],
    COUNT(FIS.SalesAmount) AS [Number Of Sales]
FROM
    DimCustomer AS dimc
LEFT JOIN
    FactInternetSales AS FIS
ON dimc.CustomerKey = FIS.CustomerKey
GROUP BY dimc.CustomerKey, dimc.FirstName, dimc.LastName
ORDER BY [Number Of Sales];

