-- Zadatak 1: Osnovno Filtriranje i Sortiranje
-- Zadatak: Pronađi prvih 15 zaposlenih (DimEmployee) koji su zaposleni na poziciji "Sales Representative". Prikaži njihovo puno ime, email i datum zaposlenja. Sortiraj ih po datumu zaposlenja, od najnovijih ka najstarijim.
SELECT TOP(15)
    FirstName,
    LastName,
    EmailAddress,
    HireDate
FROM DimEmployee
WHERE Title = 'Sales Representative'
ORDER BY HireDate DESC;

-- Zadatak 2: Logički Operatori i Zagrade
-- Zadatak: Izlistaj sve proizvode (DimProduct) koji su ili crni (Black) ili srebrni (Silver),
-- a čija je standardna cena (StandardCost) veća od 500. Prikaži ime proizvoda, boju i cenu.
SELECT EnglishProductName, Color, StandardCost
FROM   DimProduct
WHERE  Color IN ('Black', 'Silver') AND StandardCost > 500;

-- Zadatak 3: DISTINCT i Rad sa Tekstom
-- Zadatak: Napravi jedinstvenu listu svih gradova (City) iz kojih dolaze naši kupci (DimCustomer).
-- Prikaži gradove velikim slovima (UPPER) i sortiraj ih abecedno.
SELECT DISTINCT UPPER(City) AS City
FROM DimGeography
ORDER BY UPPER(City);

-- Zadatak 4: Aritmetika, Aliases i ROUND
-- Zadatak: Za prvih 10 prodajnih linija iz FactInternetSales, prikaži SalesOrderNumber, SalesAmount i novu, izračunatu kolonu ProfitMargin (profitna marža). Profitna marža se računa kao (SalesAmount - TotalProductCost) / SalesAmount. Zaokruži maržu na 4 decimale.
SELECT TOP(10)
    SalesOrderNumber,
    SalesAmount,
    ROUND((SalesAmount - TotalProductCost) / SalesAmount, 4) AS ProfitMargin
FROM FactInternetSales;

-- Zadatak 5: Agregacija (COUNT, AVG)
-- Zadatak: Izračunaj ukupan broj kupaca (DimCustomer) i njihova prosečna godišnja primanja (YearlyIncome).
SELECT
    COUNT(*) AS [Total Customers],
    AVG(YearlyIncome) AS [Average Yearly Income]
FROM DimCustomer;

-- Zadatak 6: GROUP BY
-- Zadatak: Prebroj koliko kupaca (DimCustomer) ima svako zanimanje (EnglishOccupation).
-- Prikaži zanimanje i broj kupaca. Sortiraj rezultat tako da najčešća zanimanja budu na vrhu.
SELECT
    EnglishOccupation,
    COUNT(*) AS [Number of Customers]
FROM DimCustomer
GROUP BY EnglishOccupation
ORDER BY COUNT(*) DESC;


-- Zadatak 7: GROUP BY i HAVING
-- Zadatak: Pronađi sve proizvode (DimProduct) po boji (Color), ali prikaži samo one boje kojih ima više od 20 različitih proizvoda.
-- Prikaži boju i broj proizvoda.
SELECT
    Color,
    COUNT(*) AS [Product Count]
FROM DimProduct
GROUP BY Color
HAVING COUNT(*) > 20
ORDER BY COUNT(*) DESC;

-- Zadatak 8: Rad sa Datumima (YEAR, MONTH)
-- Zadatak: Prebroj koliko je ukupno internet prodaja (FactInternetSales) bilo u svakom mesecu 2013. godine.
-- Prikaži broj meseca i ukupan broj prodaja za taj mesec. Sortiraj po mesecu.
SELECT
    DATENAME(MONTH, OrderDate) AS [Order Month Name],
    MONTH(OrderDate) AS [Order Month],
    COUNT(*) AS [Total Sales]
FROM FactInternetSales
WHERE  YEAR(OrderDate) = 2013
GROUP BY MONTH(OrderDate), DATENAME(MONTH, OrderDate)
ORDER BY MONTH(OrderDate);

-- Zadatak 9: CASE Izraz
-- Zadatak: Izlistaj prvih 20 proizvoda (DimProduct) i dodaj novu kolonu PriceCategory. Ako je ListPrice 0, kategorija je 'Free'.
-- Ako je manja od 100, kategorija je 'Cheap'.
-- Ako je manja od 1000, kategorija je 'Mid-range'. Inače, kategorija je 'Expensive'.
SELECT TOP 20
    EnglishProductName,
    ListPrice,
    CASE
        WHEN ListPrice = 0 THEN 'Free'
        WHEN ListPrice < 100 THEN 'Cheap'
        WHEN ListPrice < 1000 THEN  'Mid-range'
        ELSE 'Expensive'
    END AS [Price Category]
FROM DimProduct;

-- Zadatak 10: Rad sa NULL Vrednostima (IS NULL, ISNULL/COALESCE)
-- Zadatak: Pronađi sve kupce (DimCustomer) koji nemaju srednje ime (MiddleName). Prikaži FirstName, LastName, i umesto NULL za MiddleName, prikaži tekst 'N/A'.
SELECT
    FirstName,
    LastName,
    COALESCE(MiddleName, 'N/A') AS [Middle Name]
FROM DimCustomer
WHERE MiddleName IS NULL;













