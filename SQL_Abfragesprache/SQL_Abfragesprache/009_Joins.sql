-- JOINS: Abfragen über mehrere Tabellen

-- INNER JOIN


-- LEFT JOIN
					-- OUTER JOIN
-- RIGHT JOIN

USE Northwind

-- INNER JOIN


SELECT *
FROM Orders INNER JOIN Customers
					ON Orders.CustomerID = Customers.CustomerID



SELECT	  OrderID
		, Orders.CustomerID -- wenn gleicher Spaltenname vorhanden, Tabelle dazuschreiben!
		, CompanyName
		, ShipAddress
	--	, ...
FROM Orders INNER JOIN Customers
					ON Orders.CustomerID = Customers.CustomerID



-- wenn Spaltennamen eindeutig, kann man trotzdem die Tabelle dazuschreiben (empfohlen)
SELECT	  Orders.OrderID
		, Orders.CustomerID
		, Customers.CompanyName
		, Orders.ShipAddress
	--	, ...
FROM Orders INNER JOIN Customers
					ON Orders.CustomerID = Customers.CustomerID


-- kürzere Schreibweise
SELECT	  o.OrderID
		, o.CustomerID
		, c.CompanyName
		, o.ShipAddress
	--	, ...
FROM Orders AS o INNER JOIN Customers AS c
					ON o.CustomerID = c.CustomerID



-- ein bisschen kürzer gehts noch:
SELECT	  o.OrderID
		, o.CustomerID
		, c.CompanyName
		, o.ShipAddress
	--	, ...
FROM Orders o INNER JOIN Customers c
					ON o.CustomerID = c.CustomerID
-- wir dürfen das "AS" weglassen




-- mit WHERE:
SELECT	  o.OrderID
		, o.CustomerID
		, c.CompanyName
		, o.ShipAddress
	--	, ...
FROM Orders o INNER JOIN Customers c
					ON o.CustomerID = c.CustomerID
WHERE Country = 'Germany'


-- Geben Sie die Namen der Anbieter (Supplier), die Sauce verkaufen, aus. (CompanyName, ProductName, Ansprechperson, Telefonnummer). 

-- Achtung: Wie heißt das Produkt/die Produkte? Verschiedene Möglichkeiten?

SELECT	  p.ProductName
		, s.CompanyName
		, s.ContactName
		, s.Phone
FROM Products p INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE p.ProductName LIKE '%sauce%' OR p.ProductName LIKE N'%soße%'


-- Geben Sie alle Kunden (Firmenname) aus Brasilien und deren Frachtkosten aus.
-- Ordnen Sie die Ausgabe aufsteigend nach Frachtkosten.
SELECT	  c.CompanyName
		, o.Freight
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.Country = 'Brazil'
ORDER BY o.Freight


-- mehrere Tabellen miteinander verknüpfen:
SELECT *
FROM Employees e INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID
				 INNER JOIN Shippers s ON o.ShipVia = s.ShipperID
				 

-- Welche Kunden haben Chai Tee gekauft und wieviel?
-- (OrderID, CustomerID, CompanyName, ProductName, Quantity)

SELECT    o.OrderID
		, o.CustomerID
		, c.CompanyName
		, p.ProductName
		, od.Quantity
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
				 INNER JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductName LIKE '%chai%'
ORDER BY CustomerID


---- Suchen Sie alle Bestellungen, bei denen Bier verkauft wurde. Welcher Kunde? Wieviel? Welches Bier?
--Tipp: Der Produktname kann „Bier“ oder „Lager“ enthalten oder mit „Ale“ enden.

--Nach Menge und Kundenname geordnet:
--	Menge absteigend (größte zuerst), 	Kundenname aufsteigend (A-Z)

SELECT	  o.OrderID
		, c.CompanyName
		, p.ProductName
		, od.Quantity
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
				 INNER JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductName LIKE '%bier%'
			OR p.ProductName LIKE '%lager%'
			OR p.ProductName LIKE '%ale'
ORDER BY Quantity DESC, CompanyName -- ASC



-- welche Kunden haben noch nichts bestellt?
SELECT	  c.CustomerID
		, c.CompanyName
		, o.OrderID
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE OrderID IS NULL
-- FAAAAAAALSCH!!!!!
-- mit Inner Join bekommen wir nur die Kunden, die schon etwas bestellt haben


-- INNER JOIN
SELECT	  c.CustomerID
		, c.CompanyName
		, o.OrderID
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
-- nur die Kunden, die schon bestellt haben

-- OUTER JOINS
-- RIGHT JOIN
SELECT	  c.CustomerID
		, c.CompanyName
		, o.OrderID
FROM Customers c RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID 
-- in diesem Fall gleiches Ergebnis wie bei INNER JOIN, weil alle CustomerIDs, die in der Orders Tabelle vorkommen, auch schon etwas bestellt haben


-- LEFT JOIN
SELECT	  c.CustomerID
		, c.CompanyName
		, o.OrderID
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
-- hier bekommen wir auch Customers, die noch nichts bestellt haben


-- die, die noch nichts bestellt haben:
SELECT	  c.CustomerID
		, c.CompanyName
		, o.OrderID
		, c.ContactName
		, c.Phone
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL


-- geht das auch mit RIGHT JOIN?
SELECT	  c.CustomerID
		, c.CompanyName
		, o.OrderID
		, c.ContactName
		, c.Phone
FROM  Orders o RIGHT JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL



-- Wer ist der Chef von wem?
--Ausgabe:
--Name Angestellter, ID Angestellter, Name Chef, ID vom Chef

SELECT	  emp.LastName
		, emp.EmployeeID
		, chef.LastName
		, chef.EmployeeID
FROM Employees emp INNER JOIN Employees chef ON emp.ReportsTo = chef.EmployeeID


-- wenn wir auch die haben wollen, wo kein Vorgesetzter eingetragen ist, dann mit Left Join
SELECT	  emp.LastName
		, emp.EmployeeID
		, chef.LastName
		, chef.EmployeeID
FROM Employees emp LEFT JOIN Employees chef ON emp.ReportsTo = chef.EmployeeID


-- Geben Sie alle Kunden aus, die in der gleichen Stadt wohnen, wie ein anderer Kunde (nicht sie selbst).
--Ausgabe:
--Customer1, City1, Customer2, City2
SELECT	  c1.CompanyName
		, c1.City
		, c2.CompanyName
		, c2.City
FROM Customers c1 INNER JOIN Customers c2 ON c1.City = c2.City
WHERE c1.CustomerID != c2.CustomerID
ORDER BY c1.City
