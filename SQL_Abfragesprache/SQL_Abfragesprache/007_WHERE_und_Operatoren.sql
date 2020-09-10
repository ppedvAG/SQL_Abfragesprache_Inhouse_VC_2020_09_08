-- WHERE clause, WHERE-Klausel, WHERE Bedingung
USE Northwind



/*
	=, <, >, <=, >=
	!=, <>  -- darf NICHT diesem Wert entsprechen
	
	AND, OR

	BETWEEN, IN

	LIKE

	-- Performance nicht so gut:
	NOT IN
	NOT LIKE
	NOT BETWEEN

	IS NULL
	IS NOT NULL

*/


-- alle Kunden, die in Deutschland ansässig sind
SELECT *
FROM Customers
WHERE Country = 'Germany'


-- alle Kunden, die in Deutschland in Berlin ansässig sind
SELECT *
FROM Customers
WHERE Country = 'Germany' 
		AND City = 'Berlin'

-- Frachtkosten
SELECT *
FROM Orders
WHERE Freight < 76


-- ORDER BY
SELECT *
FROM Orders
WHERE Freight < 76
ORDER BY Freight -- ASC -- (Default) -- vom kleinsten zum größten Wert


SELECT *
FROM Orders
WHERE Freight < 76
ORDER BY Freight DESC -- vom größten zum kleinsten Wert geordnet


-- Frachtkosten, die NICHT einem bestimmten Wert entprechen
SELECT *
FROM Orders
WHERE Freight != 148.33


-- Geben Sie alle Kunden aus, die in Buenos Aires in Argentinien ansässig sind.
SELECT *
FROM Customers
WHERE Country = 'Argentina' AND City = 'Buenos Aires'


-- Geben Sie alle portugiesischen und spanischen Kunden aus.
SELECT *
FROM Customers
WHERE Country = 'Portugal' OR Country = 'Spain'

-- oder:
SELECT *
FROM Customers
WHERE Country IN('Portugal', 'Spain')



-- alle Produkte, von denen mehr als 100 vorhanden sind?
SELECT *
FROM Products
WHERE UnitsInStock > 100


-- alle Bestellungen, bei denen die Frachtkosten zwischen 100 und 200 liegen?
SELECT *
FROM Orders
WHERE Freight >= 100 AND Freight <= 200


-- oder:
SELECT *
FROM Orders
WHERE Freight BETWEEN 100 AND 200
--ORDER BY Freight


-- alle Bestellungen, die vom Angestellten mit der ID 3, 4 und 7 bearbeitet worden sind
SELECT *
FROM Orders
WHERE EmployeeID = 3 OR EmployeeID = 4 OR EmployeeID = 7

-- oder:
SELECT *
FROM Orders
WHERE EmployeeID IN(3, 4, 7)



