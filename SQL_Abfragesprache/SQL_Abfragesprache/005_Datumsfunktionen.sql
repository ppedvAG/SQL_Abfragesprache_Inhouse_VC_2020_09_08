-- Datumsfunktionen
USE Northwind

-- ********************* Datum abfragen *****************************

-- auf 3-4 Millisekunden genau; Datentyp datetime
SELECT GETDATE()

-- auf mehrere Nanosekunden genau; Datentyp datetime2
SELECT SYSDATETIME()


-- ************************** Datumsberechnungen: DATEADD **************************

SELECT DATEADD(hh, 10, '2020-09-08') -- wenn nicht genauer angegeben, wird von 00:00 Uhr ausgegangen

-- Stunden, Minuten, Sekunden usw. können wir angeben (optional)
SELECT DATEADD(hh, 10, '2020-09-08 14:42')

-- Vorsicht mit Datumsformat! Was ist Tag, was Monat? Systemabhängig!


SELECT DATEADD(hh, 10, SYSDATETIME())

-- negative Vorzeichen sind erlaubt:
SELECT DATEADD(hh, -10, SYSDATETIME())



/*

	year, yyyy, yy = Jahr
	quarter, qq, q = Quartal
	month, MM, M = Monat
	week, ww, wk = Woche
	day, dd, d = Tag
	minute, mi, n = Minute
	second, ss, s = Sekunde
	millisecond, ms = Millisekunde
	nanosecond, ns = Nanosekunde

	weekday, dw, w = Wochentag
	dayofyear, dy, y = Tag im Jahr

*/


-- ***************************** DATEDIFF ************************************
-- Differenz zwischen zwei Daten berechnen
-- wie lange noch bis zum nächsten Feiertag?
SELECT DATEDIFF(dd, '2020-09-08', '2020-09-20') -- 12
SELECT DATEDIFF(dd, '2020-09-20', '2020-09-08') -- -12 (negatives Vorzeichen!)

-- auch das lässt sich mit dem aktuellen Datum kombinieren:
SELECT DATEDIFF(dd, SYSDATETIME(), '2020-09-20') -- 12

-- mit Daten aus Datenbank:
SELECT DATEDIFF(year, BirthDate, HireDate)
FROM Employees


-- Welches Datum haben wir in 38 Tagen?
SELECT DATEADD(dd, 38, SYSDATETIME()) -- 2020-10-16 15:06:09.5430832



-- ****************************** DATEPART ******************************
-- Datumsteile ausgeben

SELECT DATEPART(dd, '2020-09-08')

SELECT DATEPART(dd, SYSDATETIME())

SELECT DATEPART(qq, '2020-09-20') -- dieser Feiertag liegt im 3. Quartal


-- ***************************** DATENAME ***********************************

SELECT DATENAME(dd, '2020-09-08') -- 8 ??????


-- bei DATENAME machen genau zwei Anweisungen Sinn: dw, month
SELECT DATENAME(dw, '2020-09-08')


SELECT DATENAME(month, '2020-09-08')


-- Welcher Wochentag war Ihr Geburtstag?
SELECT DATENAME(dw, '1981-04-22') -- Wednesday


-- Vor wie vielen Jahren kam der erste Star Wars Film in die Kinos? (25. Mai 1977 )
SELECT DATEDIFF(yy, '1977-05-25', GETDATE()) -- 43

-- Tag und Monat dürfen wir hier auch weglassen (wir wollen ja nur die verstrichenen Jahre)
SELECT DATEDIFF(yy, '1977', GETDATE()) -- 43

-- Geben Sie Tag, Monat und Jahr Ihres Geburtstages in einer eigenen Spalte mit der jeweils entsprechenden Überschrift an:
-- Tag	 Monat	 Jahr
--  22	  04	 1981

SELECT	  DATEPART(dd, '1981-04-22') AS Tag
		, DATEPART(MM, '1981-04-22') AS Monat
		, DATEPART(yyyy, '1981-04-22') AS Jahr


-- oder:
SELECT	  DAY('1981-04-22') AS Tag
		, MONTH('1981-04-22') AS Monat
		, YEAR('1981-04-22') AS Jahr


-- mit DAY, MONTH oder YEAR gleiches Ergebnis wie mit DATEPART(dd,...)
-- gleicher Datentyp: Int

SELECT YEAR(Hiredate) AS Einstellungsjahr
FROM Employees






