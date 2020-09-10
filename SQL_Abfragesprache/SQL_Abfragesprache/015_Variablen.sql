-- Variablen

/*
	-- lokale
	-- Zugriff nur in der Session, in der sie erstellt wurde
	@Variablenname


	-- globale
	-- Zugriff auch von auﬂerhalb der Session
	@@Variablenname


	-- Lebenszeit: nur solange der Batch l‰uft

	DECLARE @varname AS Datentyp

*/


-- Bsp.:

DECLARE @var1 AS int


-- Wert zuweisen:

SET @var1 = 100


SELECT @var1


-- Beispiel mit Format und Datum:
DECLARE @myDate datetime2 = SYSDATETIME()

SELECT FORMAT(@myDate, 'd', 'de-de')


DECLARE @freight AS money = 500

SELECT *
FROM Orders
WHERE Freight < @freight
