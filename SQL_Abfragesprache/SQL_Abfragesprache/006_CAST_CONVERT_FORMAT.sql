-- Datentypen




/*

-- String Datentypen:
	char(50)
	varchar
	nchar
	nvarchar

-- numerische Datentypen:

	bit - 1, 0, NULL

-- ganze Zahlen
	tinyint
	smallint
	int
	bigint

-- Nachkommastellen
	float
	decimal(10, 2)
	money (4 Nachkommastellen)

-- boolean, bool


-- Datums- und Zeitdatentypen

	datetime - Datum und Uhrzeit auf mehrere Millisekunden genau
	datetime2 - Datum und Uhrzeit auf mehrere Nanosekunden genau

	date
	time

*/



-- Cast, Convert, Format
USE Northwind

-- ************************* CAST ***************************************
-- Umwandeln von Datentypen

-- funktioniert:
SELECT '123' + 2

-- funktioniert NICHT:
SELECT '123.5' + 2
-- Conversion failed when converting the varchar value '123.5' to data type int.


-- explizite Konvertierung
SELECT CAST('123.5' AS float) + 2 -- 125,5

/*
	Implizite und explizite Konvertierung in der Microsoft-Dokumentation:

	https://docs.microsoft.com/de-de/sql/t-sql/data-types/data-type-conversion-database-engine?view=sql-server-ver15

*/


-- geht auch mit Datum, aber kein Einfluss auf das Format:
SELECT CAST(SYSDATETIME() AS varchar)


-- VORSICHT mit Anzahl der Zeichen
SELECT CAST(SYSDATETIME() AS varchar(3)) -- 202 - Blödsinn!

-- mit DB Abfrage; auch hier kein Einfluss auf das Format!
SELECT CAST(BirthDate AS varchar)
FROM Employees


-- VORSICHT!
SELECT CAST('2020-09-08' AS date) -- ob Tag als Tag und Monat als Monat korrekt erkannt wird, ist wieder systemabhängig!!




-- ***************************** CONVERT ********************************************

-- auch mit Convert werden (wie der Funktionsname schon sagt), Datentypen konvertiert; aber Convert kann noch mehr


-- Syntax:
-- SELECT CONVERT(data_type[(length)], expression[, style])
-- 1: in welchen Datentyp soll konvertiert werden
-- 2: WAS soll konvertiert werden
-- 3: WIE soll die Ausgabe aussehen

SELECT CONVERT(varchar(10), 123456.98)

-- funktioniert auch mit Datum
SELECT CONVERT(varchar, SYSDATETIME())


-- über den Style-Parameter geben wir das Format an, in dem die Datumsausgabe erfolgen soll:
SELECT CONVERT(varchar, SYSDATETIME(), 4) -- Jahreszahl zweistellig
SELECT CONVERT(varchar, SYSDATETIME(), 104) -- vierstellige Jahreszahl




/*

-- Date- und Time Styles in der Microsoft-Dokumentation:

	https://docs.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-2017#date-and-time-styles

*/

SELECT	  CONVERT(varchar, SYSDATETIME(), 104) AS DE
		, CONVERT(varchar, SYSDATETIME(), 101) AS US
		, CONVERT(varchar, SYSDATETIME(), 103) AS GB


-- ***************************** FORMAT *************************************
-- Ausgabe-Datentyp: nvarchar
-- Syntax:
-- SELECT FORMAT(expression, format[, culture parameter])


SELECT FORMAT(1234567890, '###-###/##-##')

SELECT FORMAT(431234567890, '+' + '##/### ## ## ###')


-- ACHTUNG:
SELECT FORMAT(GETDATE(), 'dd.mm.yyyy') -- mm kleingeschrieben wird als MINUTE interpretiert!!!


SELECT FORMAT(GETDATE(), 'dd.MM.yyyy') -- MM großgeschrieben funktioniert


-- funktioniert NICHT:
SELECT FORMAT('2020-09-08', 'dd.MM.yyyy')
-- Argument data type varchar is invalid for argument 1 of format function.


-- mit Info aus DB:
SELECT FORMAT(HireDate, 'dd.MM.yyyy') AS Einstellungsdatum
FROM Employees


-- Culture-Parameter:

SELECT	  FORMAT(SYSDATETIME(), 'd', 'de-de') AS DE
		, FORMAT(SYSDATETIME(), 'd', 'en-US') AS US
		, FORMAT(SYSDATETIME(), 'd', 'en-GB') AS GB
		, FORMAT(SYSDATETIME(), 'd', 'sv') AS Schweden

-- kleines "d" bedeutet, Datum wird in Zahlen ausgegeben; großes "D" bedeutet, Monat und je nach regionaler Konvention ev. auch der Wochentag werden als Text ausgeschrieben


SELECT	  FORMAT(SYSDATETIME(), 'D', 'de-de') AS DE
		, FORMAT(SYSDATETIME(), 'D', 'en-US') AS US
		, FORMAT(SYSDATETIME(), 'D', 'en-GB') AS GB
		, FORMAT(SYSDATETIME(), 'D', 'sv') AS Schweden



-- Supported Culture Codes in der Microsoft-Dokumentation:
/*
	https://docs.microsoft.com/de-de/bingmaps/rest-services/common-parameters-and-types/supported-culture-codes
*/