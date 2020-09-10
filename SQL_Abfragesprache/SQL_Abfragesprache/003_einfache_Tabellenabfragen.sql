-- einfache Tabellenabfragen
-- SELECT auf Tabellen

USE Northwind


-- Syntax:
-- SELECT Spalte1, Spalte2, Spalte3,...
-- FROM Tabellenname


-- * Wildcard
-- alle Spalten einer bestimmten Tabelle werden ausgewählt
-- NICHT verwenden! Alle Spalten hinschreiben! Spalten in einer Tabelle können sich ändern


SELECT *
FROM Customers


SELECT	  CustomerID, CompanyName, Phone
FROM Customers


SELECT	  CustomerID
		, CompanyName
		, Phone
FROM Customers



SELECT	  CustomerID AS Kundennummer
		, CompanyName
		, Phone
FROM Customers


SELECT	  CustomerID
		, CompanyName
		, ContactName
		, Phone
FROM Customers