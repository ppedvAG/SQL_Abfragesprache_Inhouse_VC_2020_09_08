-- SET Operatoren
-- UNION, UNION ALL, INTERSECT, EXCEPT

-- Liste von allen Kontaktpersonen?
-- Customers, Suppliers


-- mit JOIN bekommen wir keine Liste, sonder 4 Spalten (Name, Phone, Name Phone)
-- mit INNER JOIN bekommen wir nur die Customers, die schon etwas bestellt haben und nur die Suppliers, die schon etwas geliefert haben


-- UNION

SELECT 'Testtext1'
UNION
SELECT 'Testtext2'


-- UNION macht auch ein DISTINCT!
SELECT 'Testtext'
UNION
SELECT 'Testtext'


-- wenn man kein DISTINCT möchte: UNION ALL
SELECT 'Testtext'
UNION ALL
SELECT 'Testtext'


-- Vorsicht:
-- geht nicht:
SELECT 123
UNION
SELECT 'Testtext'
-- Conversion failed when converting the varchar value 'Testtext' to data type int.


-- man KÖNNTE explizit konvertieren... SINN? (Fall zu Fall abwägen)
SELECT CAST(123 AS varchar)
UNION
SELECT 'Testtext'
-- (dann können wir damit aber nicht mehr weiterrechnen)

-- muss gleiche Datentypen haben!


-- geht nicht:
SELECT 123, 'Testtext'
UNION
SELECT 345
-- All queries combined using a UNION, INTERSECT or EXCEPT operator must have an equal number of expressions in their target lists.


-- geht:
SELECT 123, 'Testtext'
UNION
SELECT 345, 'Testtext2'

-- wir müssen die gleiche Anzahl an Spalten verwenden!

-- geht:
SELECT 123, 'Testtext'
UNION
SELECT 345, NULL  -- funktioniert, SINN? Von Fall zu Fall entscheiden!


-- Liste von Kontaktdaten?
-- CompanyName, ContactName, Phone
-- von Customers und Suppliers

SELECT	  CompanyName
		, ContactName
		, Phone
--		, CustomerID
FROM Customers
UNION ALL -- wenn es sicher keine Doppelten gibt, schneller
SELECT	  CompanyName
		, ContactName
		, Phone
--		, CAST(SupplierID AS varchar)
FROM Suppliers


-- ORDER BY:

SELECT	  CompanyName
		, ContactName
		, Phone
FROM Customers
UNION ALL
SELECT	  CompanyName
		, ContactName
		, Phone
FROM Suppliers
ORDER BY CompanyName

-- ORDER BY funktioniert, gilt aber für BEIDE!


-- "ABC"-Analyse: eine weitere Spalte mit einer Kategorie hinzufügen
SELECT	  CompanyName
		, ContactName
		, Phone
		, 'C' AS Category
FROM Customers
UNION ALL
SELECT	  CompanyName
		, ContactName
		, Phone
		, 'S'  -- AS Category -- optional; Überschrift gibt es ja schon oben
FROM Suppliers
ORDER BY CompanyName


-- Spaltenüberschriften müssen nicht gleich sein, aber verwendete Datentypen müssen gleich (bzw. kompatibel/implizit konvertierbar sein)
SELECT Phone, ContactName
FROM Customers
UNION
SELECT HomePhone, LastName
FROM Employees



-- macht es Sinn, eine Spalte mit eigenem Text aufzufüllen? Von Fall zu Fall entscheiden
SELECT Phone, ContactName
FROM Customers
UNION
SELECT HomePhone, 'blabla' -- wir dürfen hier reinschreiben, was wir wollen -> SINN??
FROM Employees




--Geben Sie alle Regionen der Kunden und der Angestellten aus.
--Füge eine Kategorie „C“ für Customer und „E“ für Employee hinzu.
SELECT	  Region
		, 'C' AS Category
FROM Customers
UNION
SELECT	  Region
		, 'E' AS Category
FROM Employees




SELECT Region
    , ContactName
    , 'C' AS Category
FROM Customers
UNION ALL
SELECT Region
     , CONCAT(FirstName, ' ', LastName) 
     , 'E'
FROM Employees
ORDER BY ContactName


-- Vorsicht:
SELECT    CustomerID
		, CompanyName
FROM Customers
UNION
SELECT    SupplierID
		, CompanyName
		, Phone
FROM Suppliers
-- zwei Probleme: unterschiedliche Datentypen bei ID und unterschiedliche Spaltenanzahl



-- Liste mit niedrigsten und höchsten Frachtkostenwerten (untereinander)
-- OrderID, Freight, 'niedrigste Frachtkosten'
-- OrderID, Freight, 'höchste Frachtkosten'

SELECT TOP 1 OrderID, Freight, 'niedrigste Frachtkosten' AS Frachtkosten
FROM Orders
ORDER BY Freight
UNION -- funktioniert nicht! Das untere ORDER BY gilt für beide!!
SELECT TOP 1 OrderID, Freight, 'höchste Frachtkosten' AS Frachtkosten
FROM Orders
ORDER BY Freight DESC


-- mit temporärer Tabelle:
SELECT TOP 1 OrderID, Freight, 'niedrigste Frachtkosten' AS Frachtkosten
INTO #niedrigsterWert
FROM Orders
ORDER BY Freight


SELECT TOP 1 OrderID, Freight, 'höchste Frachtkosten' AS Frachtkosten
INTO #hoechsterWert
FROM Orders
ORDER BY Freight DESC


SELECT OrderID, Freight, Frachtkosten
FROM #niedrigsterWert
UNION
SELECT OrderID, Freight, Frachtkosten
FROM #hoechsterWert

-- oder mit Subquery funktioniert es auch:
SELECT *
FROM (SELECT TOP 1 OrderID, Freight, 'höchste Frachtkosten' AS Frachtkosten
FROM Orders
ORDER BY Freight DESC) AS h
UNION
SELECT *
FROM (SELECT TOP 1 OrderID, Freight, 'niedrigste Frachtkosten' AS Frachtkosten
FROM Orders
ORDER BY Freight) AS n


SELECT OrderID, Freight, 'niedrigste Frachtkosten'
FROM Orders
WHERE Freight = (SELECT MIN(Freight) FROM Orders)
UNION
SELECT OrderID, Freight, 'höchste Frachtkosten'
FROM Orders
WHERE Freight = (SELECT MAX(Freight) FROM Orders)



-- INTERSECT

CREATE TABLE #a (id INT)

CREATE TABLE #b (id INT)

INSERT INTO #a(id) VALUES (1), (NULL), (2), (1)

INSERT INTO #b(id) VALUES (1), (NULL), (3), (1)


SELECT *
FROM #a

SELECT *
FROM #b


-- UNION
SELECT id
FROM #a
UNION
SELECT id
FROM #b
-- NULL, 1, 2, 3


-- UNION ALL
SELECT id
FROM #a
UNION ALL
SELECT id
FROM #b
-- 1, NULL, 2, 1, 1, NULL, 3, 1


-- INTERSECT - was ist gleich?
SELECT id
FROM #a
INTERSECT
SELECT id
FROM #b
-- NULL, 1



-- EXCEPT - was ist NICHT gleich?
SELECT id
FROM #a
EXCEPT
SELECT id
FROM #b
-- 2
-- das, was in Tabelle #a vorkommt, aber nicht in Tabelle #b

-- umgekehrte Reihenfolge:
SELECT id
FROM #b
EXCEPT
SELECT id
FROM #a
-- 3
-- das, was in Tabelle #b vorkommt, aber nicht in Tabelle #a



-- INNER JOIN
SELECT a.id
FROM #a a INNER JOIN #b b ON a.id = b.id
-- 1, 1, 1, 1
