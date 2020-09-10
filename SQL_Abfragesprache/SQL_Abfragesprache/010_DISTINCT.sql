-- DISTINCT

USE Northwind

-- Liste von allen L�ndern, in die wir liefern?
SELECT Country
FROM Customers
-- so viele, wie L�nder

SELECT ShipCountry
FROM Orders
-- so viele, wie Bestellungen


-- L�sung: DISTINCT
SELECT DISTINCT Country
FROM Customers
-- ORDER BY Country


-- bringt nix, weil CustomerID ist eindeutig!!
SELECT DISTINCT Country, CustomerID
FROM Customers

-- so viele Eintr�ge, wie es St�dte gibt:
SELECT DISTINCT Country, City
FROM Customers

-- Liste von allen L�ndern, in denen Angestellte wohnen?
SELECT DISTINCT Country
FROM Employees
-- USA, UK

-- zum �berpr�fen:
SELECT *
FROM Employees




