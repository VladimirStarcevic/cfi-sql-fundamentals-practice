-- Zadatak 11: BETWEEN Operator
-- Zadatak: Pronađi sve proizvode (DimProduct) čija je lista cena (ListPrice) između 200 i 500 (uključujući obe granice).
-- Prikaži ime proizvoda i cenu, sortirano po ceni uzlazno.

SELECT
    EnglishProductName AS [Product name],
    ListPrice AS [Product price]
FROM DimProduct
WHERE ListPrice BETWEEN 200 AND 500
ORDER BY ListPrice;


-- Zadatak 12: IN Operator
-- Zadatak: Prikaži sve kupce (DimCustomer) koji žive u gradovima: 'London', 'Paris', 'Berlin'. Prikaži ime, prezime i grad.

SELECT
    CONCAT(dc.FirstName, ' ', dc.LastName) AS [Customer Name],
    dg.City AS [City Name]
FROM DimCustomer AS dc
INNER JOIN
    DimGeography AS dg
ON dc.GeographyKey = dg.GeographyKey
WHERE dg.City IN('London', 'Paris', 'Berlin')
GROUP BY dc.FirstName, dc.LastName, dg.City


