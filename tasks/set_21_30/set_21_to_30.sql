-- Zadatak 21: Subquery u WHERE Klauzuli
-- Pronađi sve proizvode (DimProduct) čija je list cena (ListPrice) veća od prosečne list cene svih proizvoda.
-- Prikaži ime proizvoda i cenu.

SELECT
    EnglishProductName AS [Product],
    ListPrice AS [Product Price]
FROM
    DimProduct
WHERE ListPrice > (
         SELECT AVG(ListPrice) FROM DimProduct
    );

-- Zadatak 22: Subquery sa IN
-- Zadatak: Prikaži sve kupce (DimCustomer) koji su napravili internet kupovinu (tj. njihov CustomerKey postoji u FactInternetSales).
-- Prikaži CustomerKey, FirstName, LastName. Ograniči na prvih 30 rezultata.

SELECT TOP 30
    CustomerKey,
    CONCAT(FirstName, ' ', LastName) AS [Full Name]
FROM
    DimCustomer
WHERE CustomerKey IN (
    SELECT DISTINCT CustomerKey FROM FactInternetSales
    );

-- Zadatak 23: DATEPART Funkcija
-- Zadatak: Prebrojи internet prodaje (FactInternetSales) po kvartalima (Quarter) tokom 2012. godine.
-- Prikaži kvartal i broj prodaja.
-- SELECT, DATEPART(QUARTER, OrderDate) AS Quarter, COUNT(*), FROM, WHERE YEAR(OrderDate) = 2012, GROUP BY.
SELECT
    DATEPART(QUARTER, OrderDate) AS [Quarter],
    COUNT(*) AS [Sales Count]
FROM
    FactInternetSales
WHERE
    YEAR(OrderDate) = 2012
GROUP BY
    DATEPART(QUARTER, OrderDate)
ORDER BY
    [Quarter];

-- Zadatak 24: DATEDIFF Funkcija
-- Zadatak: Za prvih 15 zaposlenih (DimEmployee),
-- izračunaj koliko dana su zaposleni (od HireDate do danas).
-- Prikaži ime, prezime, datum zaposlenja i broj dana.

SELECT TOP  15
    CONCAT(FirstName, ' ', LastName) AS 'Full Name',
    HireDate AS 'Hire Date',
    DATEDIFF(DAY, HireDate, GETDATE()) AS 'Days Employed'
FROM
    DimEmployee;

-- Zadatak 25: LEFT i RIGHT String Funkcije
-- Zadatak: Iz tabele DimProduct, prikaži prvih 10 proizvoda sa kolonama:
-- puno ime i nova kolona Prefix koja sadrži prvih 5 karaktera imena, i kolona Suffix koja sadrži poslednjih 5 karaktera imena

SELECT TOP 10
    EnglishProductName AS [Product Name],
    LEFT(EnglishProductName, 5) AS [Prefix],
    RIGHT(EnglishProductName, 5) AS [Sufix]
FROM DimProduct;

-- Zadatak 26: REPLACE Funkcija
-- Zadatak: U tabeli DimProduct, za prvih 20 proizvoda, prikaži ime proizvoda gde je svaki razmak (' ') zamenjen crticom ('-').

SELECT TOP 20
    REPLACE(EnglishProductName, ' ', '-') AS [Prdoduct Name]
FROM
    DimProduct;

-- Zadatak 27: Ugneždene Agregacije
-- Koji je najveći broj kupaca koji žive u istom gradu?
-- Naznaka: Da bi ovo rešio, prvo moraš da saznaš koliko kupaca ima u svakom gradu.
-- Zatim, iz te liste rezultata, treba da pronađeš najveći broj.
-- Razmisli kako možeš rezultat jednog upita (broj kupaca po gradu)
-- iskoristiti kao izvor podataka za drugi upit (pronađi maksimum).

SELECT
    MAX([Number of Customer]) AS [Customer statistics]
FROM
    (
        SELECT
            COUNT(dc.CustomerKey) AS [Number of Customer]
        FROM
            DimCustomer AS dc
                INNER JOIN
            DimGeography AS dg ON dc.GeographyKey = dg.GeographyKey
        GROUP BY
            dg.City
    ) AS CityStats;

-- Zadatak 29: TOP sa PERCENT
-- Zadatak: Prikaži top 5% proizvoda (DimProduct) sa najvećom list cenom (ListPrice). Prikaži ime proizvoda i cenu.
SELECT TOP (5) PERCENT
    EnglishProductName,
    ListPrice
FROM
    DimProduct
ORDER BY
    ListPrice DESC;


-- Zadatak 30: Kombinacija Više Uslova sa Agregacijom
-- Za svaki proizvod boje (Color) u tabeli DimProduct,
-- izračunaj prosečnu, minimalnu i maksimalnu list cenu.
-- Prikaži samo boje gde je prosečna cena između 500 i 1500. Sortiraj po prosečnoj ceni opadajuće.

SELECT
    Color,
    AVG(ListPrice) AS [Average Price],
    MAX(ListPrice) AS [MAX Price],
    MIN(ListPrice) AS [Min Price]
FROM
    DimProduct
WHERE Color IS NOT NULL
GROUP BY Color
HAVING AVG(ListPrice) BETWEEN 500 AND 1500
ORDER BY [Average Price] DESC;

