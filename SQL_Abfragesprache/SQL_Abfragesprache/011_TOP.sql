-- TOP
-- ORDER BY zwingend notwendig

USE Northwind


-- nur die erste Zeile ausgeben
SELECT TOP 1 *  -- erste Zeile, alle Spalten
FROM Customers


-- bestimmte Spalten der ersten Zeile
SELECT TOP 1 CustomerID, CompanyName
FROM Customers

-- aber WAS ist die erste Zeile??
--> ORDER BY
SELECT TOP 1 CustomerID, CompanyName
FROM Customers
ORDER BY CustomerID


-- man kann auch TOP % abfragen (wird gerundet!!)
SELECT TOP 10 PERCENT *
FROM Customers
ORDER BY CustomerID


SELECT TOP 10 PERCENT 
					  CustomerID
					, CompanyName
FROM Customers
ORDER BY CustomerID


-- die letzten 3:
SELECT TOP 3 CustomerID, CompanyName
FROM Customers
ORDER BY CustomerID DESC



SELECT TOP 1 PERCENT WITH TIES *
FROM [Order Details]
ORDER BY UnitPrice DESC


-- Geben Sie das teuerste Produkt aus.
SELECT  TOP 1  ProductID
		, UnitPrice
FROM Products
ORDER BY UnitPrice DESC



-- Suchen Sie die Top 10% der Produkte mit den größten Einkaufsmengen (ProductName, Quantity).
--Einschließlich Produkte mit der gleichen Einkaufsmenge wie das letzte in der ursprünglichen Ausgabe.

SELECT TOP 10 PERCENT WITH TIES ProductName, Quantity
FROM Products INNER JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
ORDER BY Quantity DESC



-- Geben Sie die drei Mitarbeiter, die als erste eingestellt wurden, aus (die schon am längsten beim Unternehmen sind).

--Wählen Sie nicht alle, sondern nur einige in diesem Zusammenhang sinnvolle Spalten aus.

SELECT TOP 3 FirstName, LastName, HireDate
FROM Employees
ORDER BY HireDate

