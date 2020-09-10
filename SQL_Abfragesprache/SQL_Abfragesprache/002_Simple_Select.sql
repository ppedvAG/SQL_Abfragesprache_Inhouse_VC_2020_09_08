-- Simple Select/Einfache Abfragen

/*
	
	Text, Zahlen, Berechnungen möglich

*/

USE Northwind

-- Zahl ausgeben
SELECT 100

-- Text ausgeben
SELECT 'Testtext'

-- Rechnung ausgeben
SELECT 100*3



SELECT '100*3' -- wird als Text ausgegeben, nicht berechnet!


SELECT 100, 'Testtext' -- zwei Spalten (durch Komma getrennt)




-- SELECT 'Testtext' AS Spaltenüberschrift

SELECT 'Leo' AS Kunde


-- Format?
SELECT 'Test', 'Text', 100, 200




SELECT 'Test',
	   'Text', 
	   100, -- Fehlermeldung unten bei Select wegen dieses Kommas
--	   200

-- Konvention (kein Muss, macht aber Sinn:)
SELECT    'Test'
		, 'Text'
		, 100 AS Zahl
--		, 200
-- Auskommentieren der letzten Zeile funktioniert so auch noch


-- Groß-/Kleinschreibung funktioniert
select 100

SELECT 100


