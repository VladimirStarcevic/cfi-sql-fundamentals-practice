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

-- Zadatak 13: LIKE i Wildcards (%, _)
-- Zadatak: Pronađi sve proizvode (DimProduct) čije ime (EnglishProductName) počinje sa 'Mountain'. Prikaži prvih 15 rezultata.

SELECT TOP 15
    EnglishProductName AS [Product Name]
FROM
    DimProduct
WHERE EnglishProductName LIKE 'Mountain%';

-- Zadatak 14: NOT LIKE i Kombinacija Uslova
-- Zadatak: Prikaži sve proizvode (DimProduct) koji ne sadrže reč 'Bike' u svom imenu, a njihova boja je 'Red' ili 'Blue'. Prikaži ime i boju.

SELECT
    EnglishProductName AS [Product Name],
    Color
FROM
    DimProduct
WHERE EnglishProductName NOT LIKE '%Bike%' AND Color IN('Red', 'Blue');

-- Zadatak 15: SUM Agregacija
-- Izračunaj ukupan iznos svih internet prodaja (FactInternetSales) po prodajnoj teritoriji.
-- Prikaži ime teritorije (SalesTerritoryRegion) i ukupan iznos prodaje. Sortiraj po iznosu opadajuće

SELECT
    dst.SalesTerritoryRegion AS 'Territory Name',
    SUM(SalesAmount) AS 'Total Sale'
FROM
    FactInternetSales AS FIS
INNER JOIN
    DimSalesTerritory AS dst
ON FIS.SalesTerritoryKey = dst.SalesTerritoryKey
GROUP BY dst.SalesTerritoryRegion
ORDER BY SUM(SalesAmount) DESC;

-- Zadatak 16: MIN i MAX Agregacija
-- Zadatak: Pronađi najnižu i najvišu list cenu (ListPrice) za sve proizvode (DimProduct).
-- Prikaži oba rezultata u jednom upitu sa aliasima MinPrice i MaxPrice.

SELECT
       ROUND(MIN(ListPrice), 2) AS 'Min Price',
       ROUND(MAX(ListPrice), 2) AS 'Max Price'
FROM DimProduct;

-- Zadatak 17: Kombinacija Agregacija i HAVING
-- Zadatak: Za svaki grad (City) u tabeli DimCustomer, izračunaj prosečan godišnji prihod (YearlyIncome) kupaca.
-- Prikaži samo gradove gde je prosečan prihod veći od 60000. Sortiraj po prosečnom prihodu opadajuće.

SELECT
    dg.City,
    AVG(YearlyIncome) AS 'Average Income'
FROM DimCustomer AS dc
LEFT JOIN
    DimGeography AS dg
    ON dc.GeographyKey = dg.GeographyKey
GROUP BY dg.City
HAVING AVG(YearlyIncome) > 60000
ORDER BY  AVG(YearlyIncome) DESC;

-- Zadatak 18: LEN Funkcija
-- Zadatak: Pronađi sve kupce (DimCustomer) čije ime (FirstName) ima tačno 4 slova. Prikaži ime i prezime.

SELECT
    CONCAT(FirstName, ' ', LastName) AS [Customer Name]
FROM DimCustomer
WHERE LEN(FirstName) = 4;

-- Zadatak 19: SUBSTRING Funkcija
-- Zadatak: Iz tabele DimProduct,
-- prikaži prvih 10 proizvoda sa kolonama: puno ime proizvoda i nova kolona ShortName koja sadrži prva 3 slova imena proizvoda.

SELECT TOP(10)
    EnglishProductName AS [Full Product Name],
    SUBSTRING(EnglishProductName,1,3) AS [Short Name]
FROM DimProduct;

-- Zadatak 20: CONCAT ili + Operator
-- Zadatak: Kreiraj listu prvih 20 zaposlenih (DimEmployee) sa kolonom FullName koja kombinuje FirstName i LastName sa razmakom između.
SELECT TOP (20)
    CONCAT(FirstName, ' ', LastName) AS [Full Name]
FROM
    DimEmployee;