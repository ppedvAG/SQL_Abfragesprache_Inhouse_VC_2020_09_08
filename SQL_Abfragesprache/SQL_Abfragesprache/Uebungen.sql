-- Übungen

USE Northwind

-- Geben Sie die ProduktID, den Produktnamen und den Stückpreis aus.
SELECT	  ProductID
		, ProductName
		, UnitPrice
FROM Products


-- Geben Sie die Nettofrachtkosten, Bruttofrachtkosten und die Mehrwertsteuer aus (Berechnung).
SELECT	  Freight AS Nettofrachtkosten
		, Freight*1.19 AS Bruttofrachtkosten
		, Freight*0.19 AS MwSt
FROM Orders


-- Geben Sie die Datumsdifferenz zwischen Lieferdatum und Wunschtermin der Bestellungen aus.
SELECT DATEDIFF(dd, RequiredDate, ShippedDate)
	--	, RequiredDate
	--	, ShippedDate
FROM Orders


-- Geben Sie die Mitarbeiternummer, den vollständigen Namen (in einer Spalte), die Anrede, das Geburtsdatum (ohne Zeitangabe) und die Telefonnummer aller Angestellten aus.

-- vollständiger Name
SELECT CONCAT(FirstName, ' ', LastName)
FROM Employees

-- Gebdat ohne Zeitangabe
SELECT CONVERT(varchar, BirthDate, 104)
FROM Employees
-- oder:
SELECT FORMAT(BirthDate, 'd', 'de-de')
FROM Employees
-- oder (nicht empfohlen):
SELECT FORMAT(BirthDate, 'dd.MM.yyyy') -- Vorsicht! MM groß, sonst Minute!
FROM Employees



SELECT	  EmployeeID
		, CONCAT(FirstName, ' ', LastName) AS [full Name]
		, TitleOfCourtesy
		, CONVERT(varchar, BirthDate, 104) AS BirthDate
		, HomePhone
FROM Employees


-- oder Titel noch in eine Spalte dazunehmen
SELECT	  EmployeeID
		, CONCAT(FirstName, ' ', LastName, ', ', TitleOfCourtesy)
		, CONVERT(varchar, BirthDate, 104)
		, HomePhone
FROM Employees


SELECT *
FROM [Order Details]


-- Pause:
SELECT DATEADD(mi, 15, Sysdatetime())



--Geben Sie die Bestellnummer,
--     den Wunschtermin,
--      das Lieferdatum und
--     die Lieferverzögerung aus.
--Ergebnisse von Bestellungen, die noch nicht geliefert wurden, sollen nicht ausgegeben werden.
--Ordnen Sie das Ergebnis absteigend von der größten zur kleinsten Lieferverzögerung.
SELECT	  OrderID
		, RequiredDate
		, ShippedDate
		, DATEDIFF(dd, RequiredDate, ShippedDate) AS Lieferverzögerung
FROM Orders
WHERE ShippedDate IS NOT NULL
ORDER BY Lieferverzögerung DESC




--Geben Sie alle Produkte aus, die vom Anbieter (SupplierID) 5, 10 oder 15 stammen, von denen mehr als 10 Stück vorrätig sind und deren Stückpreis unter 100 liegt.
--Ordnen Sie das Ergebnis absteigend vom höchsten zum niedrigsten Stückpreis.

SELECT *
FROM Products
WHERE SupplierID IN(5, 10, 15) AND UnitPrice < 100 AND UnitsInStock > 10
ORDER BY UnitPrice DESC



-- Welche Angestellten haben Chai Tee verkauft und an wen?
-- Angestellter Name (Vor- und Nachname in einer Spalte)
-- Firmenname

SELECT	  c.CompanyName
		, o.OrderID
		, e.EmployeeID
		, CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName
		, p.ProductName
FROM	Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
					INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
					INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
					INNER JOIN Products p ON od.ProductID = p.ProductID
WHERE ProductName LIKE '%chai%'



