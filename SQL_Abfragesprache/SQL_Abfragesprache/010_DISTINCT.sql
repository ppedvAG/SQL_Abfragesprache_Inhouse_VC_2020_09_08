-- DISTINCT

USE Northwind

-- Liste von allen Ländern, in die wir liefern?
SELECT Country
FROM Customers
-- so viele, wie Länder

SELECT ShipCountry
FROM Orders
-- so viele, wie Bestellungen


-- Lösung: DISTINCT
SELECT DISTINCT Country
FROM Customers
-- ORDER BY Country


-- bringt nix, weil CustomerID ist eindeutig!!
SELECT DISTINCT Country, CustomerID
FROM Customers

-- so viele Einträge, wie es Städte gibt:
SELECT DISTINCT Country, City
FROM Customers

-- Liste von allen Ländern, in denen Angestellte wohnen?
SELECT DISTINCT Country
FROM Employees
-- USA, UK

-- zum Überprüfen:
SELECT *
FROM Employees




