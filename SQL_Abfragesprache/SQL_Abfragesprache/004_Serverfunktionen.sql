-- häufige Serverfunktionen

-- ***************  TRIM, LEN, DATALENGTH *******************************

SELECT 'Test'
SELECT 'Test          '


SELECT LEN('Test          ') -- 4! Leerzeichen am Ende werden nicht mitgezählt!
SELECT LEN('Te st          ') -- 5 Leerzeichen in der Mitte werden mitgezählt
SELECT LEN(' Te st          ') -- 6 Leerzeichen davor werden mitgezählt

SELECT DATALENGTH('Test          ') -- 14


SELECT LTRIM('     Test') -- schneidet Leerzeichen davor weg

SELECT RTRIM('Test          ') -- schneidet Leerzeichen danach weg

SELECT TRIM('          Test          ') -- schneidet Leerzeichen davor und danach weg



SELECT TRIM('          Test          ')
SELECT DATALENGTH('          Test          ')

SELECT DATALENGTH(TRIM('          Test          '))


-- DATALENGTH: Vorsicht bei Datentyp nchar, nvarchar: Verwendet Unicode - doppelt so viel!



-- ************************** REVERSE *************************************
-- Eintrag in umgekehrter Reihenfolge anzeigen


SELECT REVERSE('REITTIER')
SELECT REVERSE('Trug Tim eine so hello Hose nie mit Gurt?')


-- *********************** LEFT, RIGHT, SUBSTRING *********************************
-- Zeichen "ausschneiden":

-- schneidet die ersten vier Zeichen aus (Test)
SELECT LEFT('Testtext', 4)

-- schneidet die letzten vier Zeichen aus (text)
SELECT RIGHT('Testtext', 4)

-- Textausschnitt erstellen mit SUBSTRING
SELECT SUBSTRING('Testtext', 4, 2) -- tt 
-- von welcher Stelle ausgehend? (4)
-- wie viele Zeichen? (2)



-- ************************** STUFF ***************************************
-- etwas "reinstopfen" (einfügen)

SELECT STUFF('Testtext', 5, 0, '_Hallo_')
-- wo soll etwas eingefügt werden? (Testtext)
-- von welcher Stelle ausgehend? (5)
-- wieviel soll weggelöscht werden? (0)
-- was soll eingefügt werden? (_Hallo_)


-- Möglichkeit 1
SELECT STUFF('1234567890', 8, 3, 'xxx')
-- funktioniert nur für Telefonnummern mit gleicher Länge

-- Möglichkeit 2
SELECT LEFT('1234567890', 7) + 'xxx'
-- funktioniert auch nur für Telefonnummern mit gleicher Länge, und das + 'xxx' ist nicht besonders schön!

-- Möglichkeit 3
SELECT LEFT('1234567890', DATALENGTH('1234567890')-3) + 'xxx'


-- Möglichkeit 4
-- langsam aufgebaut:

SELECT REVERSE('1234567890') -- 0987654321

SELECT STUFF('0987654321', 1, 3, 'xxx') -- xxx7654321

SELECT REVERSE('xxx7654321') -- 1234567xxx


SELECT REVERSE(STUFF(REVERSE('1234567890'), 1, 3, 'xxx'))



SELECT REVERSE(STUFF(REVERSE(Phone), 1, 3, 'xxx'))
FROM Customers


-- ********************* Strings zusammenfügen mit CONCAT ***************************


SELECT CONCAT('abc', 'def', 'ghi', 'jkl')

SELECT CONCAT('Ich weiß, ', 'dass ich', ' nichts weiß.') AS Zitat


SELECT CONCAT('James', ' ', 'Bond') AS FullName


SELECT CONCAT(FirstName, ' ', LastName, ', ', Title)
FROM Employees


SELECT CONCAT(RTRIM('James   '), ' ', RTRIM('Bond   ')) AS FullName


SELECT CONCAT(RTRIM(FirstName), ' ', RTRIM(LastName), ', ', Title)
FROM Employees


-- William Shakespeare
SELECT	  CONCAT(
		      SUBSTRING((STUFF('Wilham Shakesbeer', 4, 1, 'li')), 1, 14)
		    , SUBSTRING((STUFF('Wilham Shakesbeer', 14, 4, 'pe')), 14, 5)
			, SUBSTRING((STUFF('Wilham Shakesbeer',17, 0, 'a')), 17, 2)
			, 'e'
		  )



-- ********************** REPLICATE *********************************************
-- Zeichen oder Zeichenfolge mehrfach ausgeben

SELECT REPLICATE('?', 5) -- ?????
SELECT REPLICATE('xxx', 3) -- xxxxxxxxx

SELECT REPLICATE('x', 3) -- xxx

SELECT REPLICATE('abc', 3) -- abcabcabc


-- Groß- und Kleinschreibung
SELECT UPPER('test') -- TEST

SELECT LOWER('TEST') -- test

SELECT UPPER(FirstName) AS FirstName
FROM Employees


-- ************************** CHARINDEX ******************************
-- an welcher Stelle befindet sich ein gesuchtes Zeichen?

SELECT CHARINDEX('a', 'Leo') -- 0 (kommt nicht vor)

SELECT CHARINDEX('f', 'ALFKI') -- 3
SELECT CHARINDEX('F', 'alfki') -- 3

-- Leerzeichen gesucht
SELECT CHARINDEX(' ', 'James Bond') -- 6

SELECT ContactName
FROM Customers

-- nach Zeichenfolgen suchen
SELECT CHARINDEX('schnecke', 'Zuckerschnecke') -- 7

-- Charindex gibt die ERSTE Stelle an, an der das gesuchte Zeichen (oder Zeichenfolge) gefunden wird

SELECT CHARINDEX(' ', 'Wolgang Amadeus Mozart') -- 8


-- wie finde ich das LETZTE Leerzeichen?

-- langsam: 
SELECT REVERSE('Wolfgang Amadeus Mozart') -- trazoM suedamA gnagfloW

SELECT CHARINDEX(' ', 'trazoM suedamA gnagfloW') -- 7

-- 7 von der Gesamtlänge abziehen

SELECT LEN('Wolfgang Amadeus Mozart') - CHARINDEX(' ', 'trazoM suedamA gnagfloW') -- 16 (bei s)


-- Mozart
-- 123456


-- Stelle! (nicht Anzahl)
SELECT LEN('Wolfgang Amadeus Mozart') - CHARINDEX(' ', 'trazoM suedamA gnagfloW')+1 -- 17

-- REVERSE einsetzen:
SELECT LEN('Wolfgang Amadeus Mozart') - CHARINDEX(' ', REVERSE('Wolfgang Amadeus Mozart'))+1 -- 17


SELECT LEN('Johann Sebastian Bach') - CHARINDEX(' ', REVERSE('Johann Sebastian Bach'))+1 -- 17

SELECT LEN('Georg Friedrich Händel') - CHARINDEX(' ', REVERSE('Georg Friedrich Händel'))+1 -- 16


-- Suche nach Sonderzeichen mit Charindex funktioniert auch
SELECT CHARINDEX('$', '450$') -- 4
SELECT CHARINDEX('%', '50%') -- 3


-- ***************************** REPLACE **********************************
-- ein bestimmtes Zeichen ersetzen
SELECT REPLACE('Hallo!', 'a', 'e') -- Hello!

SELECT REPLACE(REPLACE('Hallo!', 'a', 'e'), '!', '?') -- Hello?

SELECT REPLACE(REPLACE(REPLACE('Hallo!', 'a', 'e'), '!', '?'), 'H', 'B') -- Bello?


-- Von der Telefonnummer aus der Customers-Tabelle sollen nur die letzten 3 Zeichen angezeigt werden; alle anderen sollen mit x ersetzt werden. (xxxxxxxxxxxxxxx789)



-- Schlampige Variante:

SELECT CONCAT('xxxxx', RIGHT(Phone, 3))
FROM Customers

SELECT CONCAT(REPLICATE('x', 5), RIGHT(Phone, 3))
FROM Customers


-- letzte 3 Zeichen:
SELECT RIGHT(Phone, 3)
FROM Customers

SELECT LEN(Phone)
FROM Customers


-- einsetzen:
SELECT	  CONCAT(REPLICATE('x', LEN(Phone)-3), RIGHT(Phone, 3)) AS Phone
--		, Phone
FROM Customers

-- oder:
--SELECT REPLACE(Phone, SUBSTRING(Phone, 1, LEN(Phone)-3), REPLICATE('x', LEN(Phone)-3))
--	, Phone
--FROM Customers

-- oder:
 --SELECT STUFF(Phone,1,LEN(Phone)- 3,REPLICATE('x',LEN(Phone)- 3)) AS Phone, Phone as AltePhonenummer
 --FROM Customers


 SELECT SQUARE(5) -- Quadrat
 SELECT SQRT(25) -- Wurzel
