# SQL Vežbe: 50 Zadataka za SQL Server
## Baza: AdventureWorksDW

---

## **SET 1: DQL Osnove, Filtriranje i Agregacija (Zadaci 1-10)**

### **Zadatak 1: Osnovno Filtriranje i Sortiranje**
**Zadatak:** Pronađi prvih 15 zaposlenih (`DimEmployee`) koji su zaposleni na poziciji "Sales Representative". Prikaži njihovo puno ime, email i datum zaposlenja. Sortiraj ih po datumu zaposlenja, od najnovijih ka najstarijim.

**Logika / Pseudo Kod:**
1. **SELEKTUJ** kolone `FirstName`, `LastName`, `EmailAddress`, `HireDate`.
2. **IZ TABELE** `DimEmployee`.
3. **GDE JE** kolona `Title` jednaka 'Sales Representative'.
4. **SORTIRAJ PO** koloni `HireDate` opadajuće (`DESC`).
5. **OGRANIČI NA** prvih 15 rezultata.

**Hintovi / Funkcije:** `SELECT TOP (15)`, `FROM`, `WHERE`, `ORDER BY ... DESC`.

---

### **Zadatak 2: Logički Operatori i Zagrade**
**Zadatak:** Izlistaj sve proizvode (`DimProduct`) koji su ili crni (`Black`) ili srebrni (`Silver`), a čija je standardna cena (`StandardCost`) veća od 500. Prikaži ime proizvoda, boju i cenu.

**Logika / Pseudo Kod:**
1. **SELEKTUJ** kolone `EnglishProductName`, `Color`, `StandardCost`.
2. **IZ TABELE** `DimProduct`.
3. **GDE JE** ( `Color` jednak 'Black' **ILI** `Color` jednak 'Silver' ) **I ZAJEDNO** `StandardCost` je veći od 500.

**Hintovi / Funkcije:** `SELECT`, `FROM`, `WHERE`, `OR`, `AND`, `()`. Pazi na zagrade oko `OR` uslova!

---

### **Zadatak 3: `DISTINCT` i Rad sa Tekstom**
**Zadatak:** Napravi jedinstvenu listu svih gradova (`City`) iz kojih dolaze naši kupci (`DimCustomer`). Prikaži gradove velikim slovima (`UPPER`) i sortiraj ih abecedno.

**Logika / Pseudo Kod:**
1. **SELEKTUJ JEDINSTVENE** vrednosti iz kolone `City`.
2. Primeni funkciju za velika slova na `City`.
3. **IZ TABELE** `DimCustomer`.
4. **SORTIRAJ PO** koloni `City`.

**Hintovi / Funkcije:** `SELECT DISTINCT`, `UPPER()`, `FROM`, `ORDER BY`.

---

### **Zadatak 4: Aritmetika, Aliases i `ROUND`**
**Zadatak:** Za prvih 10 prodajnih linija iz `FactInternetSales`, prikaži `SalesOrderNumber`, `SalesAmount` i novu, izračunatu kolonu `ProfitMargin` (profitna marža). Profitna marža se računa kao `(SalesAmount - TotalProductCost) / SalesAmount`. Zaokruži maržu na 4 decimale.

**Logika / Pseudo Kod:**
1. **SELEKTUJ TOP 10** `SalesOrderNumber`, `SalesAmount`.
2. Izračunaj `(SalesAmount - TotalProductCost) / SalesAmount` i daj joj **ALIAS** `ProfitMargin`.
3. Primeni funkciju za zaokruživanje na tu kalkulaciju.
4. **IZ TABELE** `FactInternetSales`.

**Hintovi / Funkcije:** `SELECT TOP (10)`, `AS`, `ROUND(..., 4)`, aritmetički operatori `( )`, `-`, `/`.

---

### **Zadatak 5: Agregacija (`COUNT`, `AVG`)**
**Zadatak:** Izračunaj ukupan broj kupaca (`DimCustomer`) i njihova prosečna godišnja primanja (`YearlyIncome`).

**Logika / Pseudo Kod:**
1. **SELEKTUJ** **BROJ SVIH REDOVA** i daj alias `TotalCustomers`.
2. **SELEKTUJ** **PROSEK** od kolone `YearlyIncome` i daj alias `AverageIncome`.
3. **IZ TABELE** `DimCustomer`.

**Hintovi / Funkcije:** `SELECT`, `COUNT(*)`, `AVG()`, `AS`, `FROM`.

---

### **Zadatak 6: `GROUP BY`**
**Zadatak:** Prebroj koliko kupaca (`DimCustomer`) ima svako zanimanje (`EnglishOccupation`). Prikaži zanimanje i broj kupaca. Sortiraj rezultat tako da najčešća zanimanja budu na vrhu.

**Logika / Pseudo Kod:**
1. **SELEKTUJ** `EnglishOccupation`.
2. **SELEKTUJ** **BROJ** redova i daj alias `NumberOfCustomers`.
3. **IZ TABELE** `DimCustomer`.
4. **GRUPIŠI PO** `EnglishOccupation`.
5. **SORTIRAJ PO** `NumberOfCustomers` opadajuće.

**Hintovi / Funkcije:** `SELECT`, `COUNT(*)`, `AS`, `FROM`, `GROUP BY`, `ORDER BY ... DESC`.

---

### **Zadatak 7: `GROUP BY` i `HAVING`**
**Zadatak:** Pronađi sve proizvode (`DimProduct`) po boji (`Color`), ali prikaži samo one boje kojih ima **više od 20 različitih proizvoda**. Prikaži boju i broj proizvoda.

**Logika / Pseudo Kod:**
1. **SELEKTUJ** `Color`.
2. **SELEKTUJ** **BROJ** proizvoda i daj alias `ProductCount`.
3. **IZ TABELE** `DimProduct`.
4. **GRUPIŠI PO** `Color`.
5. **FILTRIRAJ GRUPE GDE JE** `ProductCount` veći od 20.

**Hintovi / Funkcije:** `SELECT`, `COUNT(*)`, `AS`, `FROM`, `GROUP BY`, `HAVING COUNT(*) > 20`.

---

### **Zadatak 8: Rad sa Datumima (`YEAR`, `MONTH`)**
**Zadatak:** Prebroj koliko je ukupno internet prodaja (`FactInternetSales`) bilo u **svakom mesecu 2013. godine**. Prikaži broj meseca i ukupan broj prodaja za taj mesec. Sortiraj po mesecu.

**Logika / Pseudo Kod:**
1. **SELEKTUJ** **MESEC** iz `OrderDate` i daj mu alias `OrderMonth`.
2. **SELEKTUJ** **BROJ** prodaja i daj mu alias `TotalSales`.
3. **IZ TABELE** `FactInternetSales`.
4. **GDE JE** **GODINA** iz `OrderDate` jednaka 2013.
5. **GRUPIŠI PO** mesecu.
6. **SORTIRAJ PO** mesecu.

**Hintovi / Funkcije:** `SELECT`, `MONTH()`, `YEAR()`, `COUNT(*)`, `AS`, `FROM`, `WHERE`, `GROUP BY`, `ORDER BY`.

---

### **Zadatak 9: `CASE` Izraz**
**Zadatak:** Izlistaj prvih 20 proizvoda (`DimProduct`) i dodaj novu kolonu `PriceCategory`. Ako je `ListPrice` 0, kategorija je 'Free'. Ako je manja od 100, kategorija je 'Cheap'. Ako je manja od 1000, kategorija je 'Mid-range'. Inače, kategorija je 'Expensive'.

**Logika / Pseudo Kod:**
1. **SELEKTUJ TOP 20** `EnglishProductName`, `ListPrice`.
2. Dodaj **`CASE`** izraz:
   - **KADA JE** `ListPrice` = 0 **TADA** 'Free'
   - **KADA JE** `ListPrice` < 100 **TADA** 'Cheap'
   - **KADA JE** `ListPrice` < 1000 **TADA** 'Mid-range'
   - **INAČE** 'Expensive'
3. Završi `CASE` sa **`END`** i daj mu **ALIAS** `PriceCategory`.
4. **IZ TABELE** `DimProduct`.

**Hintovi / Funkcije:** `SELECT TOP (20)`, `CASE WHEN ... THEN ... ELSE ... END AS`, `FROM`.

---

### **Zadatak 10: Rad sa `NULL` Vrednostima (`IS NULL`, `ISNULL`/`COALESCE`)**
**Zadatak:** Pronađi sve kupce (`DimCustomer`) koji **nemaju** srednje ime (`MiddleName`). Prikaži `FirstName`, `LastName`, i umesto `NULL` za `MiddleName`, prikaži tekst 'N/A'.

**Logika / Pseudo Kod:**
1. **SELEKTUJ** `FirstName`, `LastName`.
2. Koristi funkciju za zamenu `NULL` vrednosti na koloni `MiddleName` sa tekstom 'N/A'. Daj joj alias `MiddleName`.
3. **IZ TABELE** `DimCustomer`.
4. **GDE JE** `MiddleName` **JESTE NULL**.

**Hintovi / Funkcije:** `SELECT`, `ISNULL(MiddleName, 'N/A')` ili `COALESCE(MiddleName, 'N/A')`, `AS`, `FROM`, `WHERE ... IS NULL`.

---

## **SET 2: Naprednije Filtriranje i Agregacije (Zadaci 11-20)**

### **Zadatak 11: `BETWEEN` Operator**
**Zadatak:** Pronađi sve proizvode (`DimProduct`) čija je lista cena (`ListPrice`) između 200 i 500 (uključujući obe granice). Prikaži ime proizvoda i cenu, sortirano po ceni uzlazno.

**Logika / Pseudo Kod:**
1. **SELEKTUJ** `EnglishProductName`, `ListPrice`.
2. **IZ TABELE** `DimProduct`.
3. **GDE JE** `ListPrice` **IZMEĐU** 200 **I** 500.
4. **SORTIRAJ PO** `ListPrice` uzlazno.

**Hintovi / Funkcije:** `SELECT`, `FROM`, `WHERE ... BETWEEN ... AND ...`, `ORDER BY`.

---

### **Zadatak 12: `IN` Operator**
**Zadatak:** Prikaži sve kupce (`DimCustomer`) koji žive u gradovima: 'London', 'Paris', 'Berlin'. Prikaži ime, prezime i grad.

**Logika / Pseudo Kod:**
1. **SELEKTUJ** `FirstName`, `LastName`, `City`.
2. **IZ TABELE** `DimCustomer`.
3. **GDE JE** `City` **U LISTI** ('London', 'Paris', 'Berlin').

**Hintovi / Funkcije:** `SELECT`, `FROM`, `WHERE ... IN (...)`.

---

### **Zadatak 13: `LIKE` i Wildcards (`%`, `_`)**
**Zadatak:** Pronađi sve proizvode (`DimProduct`) čije ime (`EnglishProductName`) **počinje** sa 'Mountain'. Prikaži prvih 15 rezultata.

**Logika / Pseudo Kod:**
1. **SELEKTUJ TOP 15** `EnglishProductName`.
2. **IZ TABELE** `DimProduct`.
3. **GDE** `EnglishProductName` **ODGOVARA ŠABLONU** 'Mountain%'.

**Hintovi / Funkcije:** `SELECT TOP (15)`, `FROM`, `WHERE ... LIKE 'Mountain%'`. (`%` znači bilo koji broj karaktera).

---

### **Zadatak 14: `NOT LIKE` i Kombinacija Uslova**
**Zadatak:** Prikaži sve proizvode (`DimProduct`) koji **ne sadrže** reč 'Bike' u svom imenu, a njihova boja je 'Red' ili 'Blue'. Prikaži ime i boju.

**Logika / Pseudo Kod:**
1. **SELEKTUJ** `EnglishProductName`, `Color`.
2. **IZ TABELE** `DimProduct`.
3. **GDE** `EnglishProductName` **NE ODGOVARA ŠABLONU** '%Bike%' **I** `Color` **JE U** ('Red', 'Blue').

**Hintovi / Funkcije:** `SELECT`, `FROM`, `WHERE ... NOT LIKE '%Bike%'`, `AND`, `IN`.

---

### **Zadatak 15: `SUM` Agregacija**
**Zadatak:** Izračunaj ukupan iznos svih internet prodaja (`FactInternetSales`) po svakom prodavcu (`EmployeeKey`). Prikaži `EmployeeKey` i ukupan iznos prodaje (`TotalSales`). Sortiraj po ukupnom iznosu opadajuće.

**Logika / Pseudo Kod:**
1. **SELEKTUJ** `EmployeeKey`.
2. **SELEKTUJ** **ZBIR** od `SalesAmount` i daj alias `TotalSales`.
3. **IZ TABELE** `FactInternetSales`.
4. **GRUPIŠI PO** `EmployeeKey`.
5. **SORTIRAJ PO** `TotalSales` opadajuće.

**Hintovi / Funkcije:** `SELECT`, `SUM()`, `AS`, `FROM`, `GROUP BY`, `ORDER BY ... DESC`.

---

### **Zadatak 16: `MIN` i `MAX` Agregacija**
**Zadatak:** Pronađi najnižu i najvišu list cenu (`ListPrice`) za sve proizvode (`DimProduct`). Prikaži oba rezultata u jednom upitu sa aliasima `MinPrice` i `MaxPrice`.

**Logika / Pseudo Kod:**
1. **SELEKTUJ** **MINIMUM** od `ListPrice` kao `MinPrice`.
2. **SELEKTUJ** **MAKSIMUM** od `ListPrice` kao `MaxPrice`.
3. **IZ TABELE** `DimProduct`.

**Hintovi / Funkcije:** `SELECT`, `MIN()`, `MAX()`, `AS`, `FROM`.

---

### **Zadatak 17: Kombinacija Agregacija i `HAVING`**
**Zadatak:** Za svaki grad (`City`) u tabeli `DimCustomer`, izračunaj prosečan godišnji prihod (`YearlyIncome`) kupaca. Prikaži samo gradove gde je prosečan prihod veći od 60000. Sortiraj po prosečnom prihodu opadajuće.

**Logika / Pseudo Kod:**
1. **SELEKTUJ** `City`.
2. **SELEKTUJ** **PROSEK** od `YearlyIncome` kao `AvgIncome`.
3. **IZ TABELE** `DimCustomer`.
4. **GRUPIŠI PO** `City`.
5. **FILTRIRAJ GRUPE** gde je prosek veći od 60000.
6. **SORTIRAJ PO** `AvgIncome` opadajuće.

**Hintovi / Funkcije:** `SELECT`, `AVG()`, `AS`, `FROM`, `GROUP BY`, `HAVING AVG(...) > 60000`, `ORDER BY ... DESC`.

---

### **Zadatak 18: `LEN` Funkcija**
**Zadatak:** Pronađi sve kupce (`DimCustomer`) čije ime (`FirstName`) ima tačno 4 slova. Prikaži ime i prezime.

**Logika / Pseudo Kod:**
1. **SELEKTUJ** `FirstName`, `LastName`.
2. **IZ TABELE** `DimCustomer`.
3. **GDE JE** **DUŽINA** od `FirstName` jednaka 4.

**Hintovi / Funkcije:** `SELECT`, `FROM`, `WHERE LEN(FirstName) = 4`.

---

### **Zadatak 19: `SUBSTRING` Funkcija**
**Zadatak:** Iz tabele `DimProduct`, prikaži prvih 10 proizvoda sa kolonama: puno ime proizvoda i nova kolona `ShortName` koja sadrži **prva 3 slova** imena proizvoda.

**Logika / Pseudo Kod:**
1. **SELEKTUJ TOP 10** `EnglishProductName`.
2. **SELEKTUJ** **PODNIZ** od `EnglishProductName` (od pozicije 1, dužine 3) kao `ShortName`.
3. **IZ TABELE** `DimProduct`.

**Hintovi / Funkcije:** `SELECT TOP (10)`, `SUBSTRING(EnglishProductName, 1, 3) AS ShortName`, `FROM`.

---

### **Zadatak 20: `CONCAT` ili `+` Operator**
**Zadatak:** Kreiraj listu prvih 20 zaposlenih (`DimEmployee`) sa kolonom `FullName` koja kombinuje `FirstName` i `LastName` sa razmakom između.

**Logika / Pseudo Kod:**
1. **SELEKTUJ TOP 20** `FirstName`, `LastName`.
2. **SELEKTUJ** **SPAJANJE** `FirstName`, razmaka ' ', i `LastName` kao `FullName`.
3. **IZ TABELE** `DimEmployee`.

**Hintovi / Funkcije:** `SELECT TOP (20)`, `CONCAT(FirstName, ' ', LastName) AS FullName` ili `FirstName + ' ' + LastName AS FullName`, `FROM`.

---

## **SET 3: Napredni Koncepti (Zadaci 21-30)**

### **Zadatak 21: Subquery u `WHERE` Klauzuli**
**Zadatak:** Pronađi sve proizvode (`DimProduct`) čija je list cena (`ListPrice`) **veća od prosečne** list cene svih proizvoda. Prikaži ime proizvoda i cenu.

**Logika / Pseudo Kod:**
1. **SELEKTUJ** `EnglishProductName`, `ListPrice`.
2. **IZ TABELE** `DimProduct`.
3. **GDE JE** `ListPrice` veći od (**PODQUERY** koji vraća prosečnu cenu).

**Hintovi / Funkcije:** `SELECT`, `FROM`, `WHERE ListPrice > (SELECT AVG(ListPrice) FROM DimProduct)`.

---

### **Zadatak 22: Subquery sa `IN`**
**Zadatak:** Prikaži sve kupce (`DimCustomer`) koji su **napravili internet kupovinu** (tj. njihov `CustomerKey` postoji u `FactInternetSales`). Prikaži `CustomerKey`, `FirstName`, `LastName`. Ograniči na prvih 30 rezultata.

**Logika / Pseudo Kod:**
1. **SELEKTUJ TOP 30** `CustomerKey`, `FirstName`, `LastName`.
2. **IZ TABELE** `DimCustomer`.
3. **GDE JE** `CustomerKey` **U LISTI** rezultata (**PODQUERY** koji vraća sve `CustomerKey` iz `FactInternetSales`).

**Hintovi / Funkcije:** `SELECT TOP (30)`, `FROM`, `WHERE CustomerKey IN (SELECT DISTINCT CustomerKey FROM FactInternetSales)`.

---

### **Zadatak 23: `DATEPART` Funkcija**
**Zadatak:** Prebrojи internet prodaje (`FactInternetSales`) po kvartalima (Quarter) tokom 2012. godine. Prikaži kvartal i broj prodaja.

**Logika / Pseudo Kod:**
1. **SELEKTUJ** **KVARTAL** iz `OrderDate` kao `Quarter`.
2. **SELEKTUJ** **BROJ** prodaja kao `SalesCount`.
3. **IZ TABELE** `FactInternetSales`.
4. **GDE JE** **GODINA** iz `OrderDate` jednaka 2012.
5. **GRUPIŠI PO** kvartalu.
6. **SORTIRAJ PO** kvartalu.

**Hintovi / Funkcije:** `SELECT`, `DATEPART(QUARTER, OrderDate) AS Quarter`, `COUNT(*)`, `FROM`, `WHERE YEAR(OrderDate) = 2012`, `GROUP BY`.

---

### **Zadatak 24: `DATEDIFF` Funkcija**
**Zadatak:** Za prvih 15 zaposlenih (`DimEmployee`), izračunaj koliko **dana** su zaposleni (od `HireDate` do danas). Prikaži ime, prezime, datum zaposlenja i broj dana.

**Logika / Pseudo Kod:**
1. **SELEKTUJ TOP 15** `FirstName`, `LastName`, `HireDate`.
2. **SELEKTUJ** **RAZLIKA U DANIMA** između danas (`GETDATE()`) i `HireDate` kao `DaysEmployed`.
3. **IZ TABELE** `DimEmployee`.

**Hintovi / Funkcije:** `SELECT TOP (15)`, `DATEDIFF(DAY, HireDate, GETDATE()) AS DaysEmployed`, `FROM`.

---

### **Zadatak 25: `LEFT` i `RIGHT` String Funkcije**
**Zadatak:** Iz tabele `DimProduct`, prikaži prvih 10 proizvoda sa kolonama: puno ime i nova kolona `Prefix` koja sadrži **prvih 5 karaktera** imena, i kolona `Suffix` koja sadrži **poslednjih 5 karaktera** imena.

**Logika / Pseudo Kod:**
1. **SELEKTUJ TOP 10** `EnglishProductName`.
2. **SELEKTUJ** **LEVIH 5** karaktera od imena kao `Prefix`.
3. **SELEKTUJ** **DESNIH 5** karaktera od imena kao `Suffix`.
4. **IZ TABELE** `DimProduct`.

**Hintovi / Funkcije:** `SELECT TOP (10)`, `LEFT(EnglishProductName, 5) AS Prefix`, `RIGHT(EnglishProductName, 5) AS Suffix`, `FROM`.

---

### **Zadatak 26: `REPLACE` Funkcija**
**Zadatak:** U tabeli `DimProduct`, za prvih 20 proizvoda, prikaži ime proizvoda gde je svaki razmak (' ') **zamenjen** crticom ('-').

**Logika / Pseudo Kod:**
1. **SELEKTUJ TOP 20** `EnglishProductName`.
2. **SELEKTUJ** **ZAMENU** svih razmaka sa crticom u `EnglishProductName` kao `ModifiedName`.
3. **IZ TABELE** `DimProduct`.

**Hintovi / Funkcije:** `SELECT TOP (20)`, `REPLACE(EnglishProductName, ' ', '-') AS ModifiedName`, `FROM`.

---

### **Zadatak 27: Ugneždene Agregacije**
**Zadatak:** Pronađi **maksimalan broj kupaca** iz bilo kog pojedinačnog grada. (Hint: prvo grupiši kupce po gradovima, prebroj ih, a onda pronađi maksimum od tih brojeva).

**Logika / Pseudo Kod:**
1. **SELEKTUJ** **MAKSIMUM** iz (**PODQUERY** koji vraća broj kupaca po svakom gradu).
2. Podquery: **SELEKTUJ** **BROJ** kupaca **IZ** `DimCustomer` **GRUPISANO PO** `City`.

**Hintovi / Funkcije:** `SELECT MAX(CityCount) AS MaxCustomersInOneCity FROM (SELECT COUNT(*) AS CityCount FROM DimCustomer GROUP BY City) AS CityStats`.

---

### **Zadatak 28: `CAST` ili `CONVERT` Funkcija**
**Zadatak:** Iz tabele `FactInternetSales`, prikaži prvih 10 prodaja sa `OrderDate` prikazanim **samo kao datum** (bez vremena), koristeći format `DATE`. Takođe prikaži `SalesAmount`.

**Logika / Pseudo Kod:**
1. **SELEKTUJ TOP 10** `OrderDate` **KONVERTOVAN** u `DATE` tip kao `OrderDateOnly`.
2. **SELEKTUJ** `SalesAmount`.
3. **IZ TABELE** `FactInternetSales`.

**Hintovi / Funkcije:** `SELECT TOP (10)`, `CAST(OrderDate AS DATE) AS OrderDateOnly` ili `CONVERT(DATE, OrderDate) AS OrderDateOnly`, `FROM`.

---

### **Zadatak 29: `TOP` sa `PERCENT`**
**Zadatak:** Prikaži **top 5%** proizvoda (`DimProduct`) sa **najvećom** list cenom (`ListPrice`). Prikaži ime proizvoda i cenu.

**Logika / Pseudo Kod:**
1. **SELEKTUJ TOP 5 PROCENATA** `EnglishProductName`, `ListPrice`.
2. **IZ TABELE** `DimProduct`.
3. **SORTIRAJ PO** `ListPrice` opadajuće.

**Hintovi / Funkcije:** `SELECT TOP (5) PERCENT`, `FROM`, `ORDER BY ListPrice DESC`.

---

### **Zadatak 30: Kombinacija Više Uslova sa Agregacijom**
**Zadatak:** Za svaki proizvod boje (`Color`) u tabeli `DimProduct`, izračunaj **prosečnu**, **minimalnu** i **maksimalnu** list cenu. Prikaži samo boje gde je prosečna cena između 500 i 1500. Sortiraj po prosečnoj ceni opadajuće.

**Logika / Pseudo Kod:**
1. **SELEKTUJ** `Color`.
2. **SELEKTUJ** **PROSEK**, **MINIMUM**, **MAKSIMUM** od `ListPrice`.
3. **IZ TABELE** `DimProduct`.
4. **GRUPIŠI PO** `Color`.
5. **FILTRIRAJ GRUPE** gde je prosek između 500 i 1500.
6. **SORTIRAJ PO** proseku opadajuće.

**Hintovi / Funkcije:** `SELECT`, `AVG()`, `MIN()`, `MAX()`, `AS`, `FROM`, `GROUP BY`, `HAVING AVG(ListPrice) BETWEEN 500 AND 1500`, `ORDER BY`.

---

## **SET 4: JOIN Operacije (Zadaci 31-40)**

### **Zadatak 31: Jednostavan `INNER JOIN`**
**Zadatak:** Spoji tabele `FactInternetSales` i `DimCustomer` da prikažeš prvih 20 prodaja sa imenom i prezimenom kupca. Prikaži `SalesOrderNumber`, `FirstName`, `LastName`, `SalesAmount`.

**Logika / Pseudo Kod:**
1. **SELEKTUJ TOP 20** `SalesOrderNumber`, `FirstName`, `LastName`, `SalesAmount`.
2. **IZ TABELE** `FactInternetSales` **SPOJI SA** `DimCustomer`.
3. **NA OSNOVU** `CustomerKey` iz obe tabele.

**Hintovi / Funkcije:** `SELECT TOP (20)`, `FROM FactInternetSales AS f`, `INNER JOIN DimCustomer AS c ON f.CustomerKey = c.CustomerKey`.

---

### **Zadatak 32: `INNER JOIN` sa Agregacijom**
**Zadatak:** Spoji `FactInternetSales` sa `DimProduct` i izračunaj **ukupan iznos prodaje** (`SUM(SalesAmount)`) za svaki proizvod. Prikaži ime proizvoda i ukupan iznos. Sortiraj po iznosu opadajuće, prikaži top 15.

**Logika / Pseudo Kod:**
1. **SELEKTUJ** `EnglishProductName`.
2. **SELEKTUJ** **ZBIR** od `SalesAmount` kao `TotalRevenue`.
3. **IZ TABELE** `FactInternetSales` **SPOJI SA** `DimProduct`.
4. **NA OSNOVU** `ProductKey`.
5. **GRUPIŠI PO** `EnglishProductName`.
6. **SORTIRAJ PO** `TotalRevenue` opadajuće.
7. **SELEKTUJ TOP 15**.

**Hintovi / Funkcije:** `SELECT TOP (15)`, `SUM()`, `FROM ... INNER JOIN ... ON`, `GROUP BY`, `ORDER BY ... DESC`.

---

### **Zadatak 33: `INNER JOIN` Tri Tabele**
**Zadatak:** Spoji `FactInternetSales`, `DimProduct` i `DimProductSubcategory` da prikažeš prvih 20 prodaja sa imenom proizvoda i nazivom potkategorije. Prikaži `SalesOrderNumber`, `EnglishProductName`, ime potkategorije (`EnglishProductSubcategoryName`).

**Logika / Pseudo Kod:**
1. **SELEKTUJ TOP 20** kolone iz sve tri tabele.
2. **IZ** `FactInternetSales` **SPOJI SA** `DimProduct` **NA** `ProductKey`.
3. **SPOJI SA** `DimProductSubcategory` **NA** `ProductSubcategoryKey`.

**Hintovi / Funkcije:** `SELECT TOP (20)`, `FROM FactInternetSales AS f`, `INNER JOIN DimProduct AS p ON f.ProductKey = p.ProductKey`, `INNER JOIN DimProductSubcategory AS s ON p.ProductSubcategoryKey = s.ProductSubcategoryKey`.

---

### **Zadatak 34: `LEFT JOIN` Osnove**
**Zadatak:** Prikaži **sve kupce** iz `DimCustomer` (prvih 30) i, ako postoje, njihov ukupan broj internet kupovina iz `FactInternetSales`. Prikaži `CustomerKey`, `FirstName`, `LastName`, i broj kupovina (0 ako nema kupovina).

**Logika / Pseudo Kod:**
1. **SELEKTUJ TOP 30** `CustomerKey`, `FirstName`, `LastName` iz `DimCustomer`.
2. **SELEKTUJ** **BROJ** redova iz `FactInternetSales` ili 0 ako nema.
3. **IZ** `DimCustomer` **LEVO SPOJI SA** `FactInternetSales`.
4. **GRUPIŠI PO** kolonama kupca.