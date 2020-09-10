-- Aggregatfunktionen

-- COUNT, AVG, SUM, MIN, MAX


SELECT Country
FROM Customers
-- 91 - so viele, wie Kunden


SELECT DISTINCT Country
FROM Customers
-- 21 - so viele, wie Länder

-- COUNT
SELECT COUNT(ProductID) AS AnzahlProdukte
FROM Products

-- oder:
SELECT COUNT(*) AS AnzahlProdukte
FROM Products



SELECT COUNT(DISTINCT Country) AS AnzahlLänder
FROM Customers


-- Durchschnittswerte berechnen mit AVG
SELECT AVG(Freight) AS [durchschnittliche Frachtkosten]
FROM Orders


-- Min-/Maxwert

SELECT MIN(Freight)
FROM Orders
UNION
SELECT MAX(Freight)
FROM Orders




SELECT MIN(Freight), 'niedrigster Wert'
FROM Orders
UNION
SELECT MAX(Freight), 'höchster Wert'
FROM Orders


-- geht nicht:
SELECT OrderID, MIN(Freight), 'niedrigster Wert'
FROM Orders
UNION
SELECT OrderID, MAX(Freight), 'höchster Wert'
FROM Orders
-- Column 'Orders.OrderID' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause.



SELECT OrderID, AVG(Freight)
FROM Orders
GROUP BY OrderID


SELECT ShipCountry, AVG(Freight)
FROM Orders
GROUP BY ShipCountry



SELECT ShipCountry, AVG(Freight) AS Freight
FROM Orders
GROUP BY ShipCountry
ORDER BY Freight


-- Summe
SELECT SUM(Freight)
FROM Orders
-- 64942,69 Summe ALLER Frachtkosten


-- Summe der Frachtkosten pro Kunde
SELECT CustomerID, SUM(Freight)
FROM Orders
GROUP BY CustomerID




-- wieviele Kunden gibts pro Land?
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country



-- wieviele Kunden gibts pro Stadt im jeweiligen Land?
SELECT COUNT(CustomerID), Country, City
FROM Customers
GROUP BY Country, City
ORDER BY Country, City


-- bringt nix:
SELECT COUNT(CustomerID), Country, City, CustomerID
FROM Customers
GROUP BY Country, City, CustomerID



-- wie bekomme ich eine Rechnungssumme?
SELECT OrderID, SUM(Quantity*UnitPrice-Discount) AS Rechnungssumme
FROM [Order Details]
GROUP BY OrderID
ORDER BY OrderID



SELECT OrderID, CAST(SUM(Quantity*UnitPrice-Discount)AS money) AS Rechnungssumme
FROM [Order Details]
GROUP BY OrderID
ORDER BY OrderID




-- ******************************** HAVING ******************************************

-- Anzahl der Kunden, aber nur dort, wo wir mehr als 3 Kunden pro Land haben
-- Anzahl, Land

-- Anzahl Kunden?
SELECT COUNT(CustomerID)
FROM Customers

-- Anzahl Kunden pro Land?
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country


SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 3


-- wo sind die meisten?
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 3
ORDER BY COUNT(CustomerID) DESC



-- schöner schreiben?
SELECT COUNT(CustomerID) AS Kundenanzahl, Country
FROM Customers
GROUP BY Country
HAVING Kundenanzahl > 3 -- funktioniert nicht! HAVING passiert VOR SELECT
ORDER BY Kundenanzahl DESC
-- Invalid column name 'Kundenanzahl'.



-- alle Employees, die mehr als 20 Bestellungen bearbeitet haben?
-- LastName, Anzahl Bestellungen
SELECT	  e.LastName, COUNT(o.OrderID) AS Bestellungen
FROM Orders o INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
GROUP BY e.LastName
HAVING COUNT(o.OrderID) > 20

-- mit EmployeeID?
SELECT	  o.EmployeeID, e.LastName, COUNT(o.OrderID) AS Bestellungen
FROM Orders o INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
GROUP BY o.EmployeeID, e.LastName
HAVING COUNT(o.OrderID) > 20


-- vollständiger Name?
SELECT	  o.EmployeeID, CONCAT(e.FirstName, ' ', e.LastName), COUNT(o.OrderID) AS Bestellungen
FROM Orders o INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
GROUP BY o.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(o.OrderID) > 20



