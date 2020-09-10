-- Subquery, Subselect, Unterabfrage

-- Unterabfrage wie eine Spalte verwenden
-- wenn man eine Unterabfrage wie eine Spalte verwendet, darf nur 1 Wert drinstehen

SELECT	 'Text'
		, Freight
		, (SELECT TOP 1 Freight FROM Orders ORDER BY Freight) -- Sinn?? von Fall zu Fall entscheiden
FROM Orders



-- Unterabfragen wie Tabellen verwenden
-- als Datenquelle

SELECT *
FROM -- Tabelle?
		(SELECT OrderID, Freight FROM Orders WHERE EmployeeID = 3) t1 -- mit oder ohne AS + Tabellenname


-- Unterabfrage im WHERE
-- alle Kunden, die in einem Land wohnen, in das auch Bestellungen verschifft werden

SELECT *
FROM Customers
WHERE Country IN (SELECT DISTINCT ShipCountry FROM Orders)


