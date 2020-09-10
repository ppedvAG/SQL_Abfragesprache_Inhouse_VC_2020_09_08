-- Wildcard

-- % steht für beliebig viele unbekannte Zeichen
-- [] genau 1 Zeichen aus einem bestimmten Wertebereich
-- _ (Unterstrich) genau 1 unbekanntes Zeichen
-- ^ NOT (darf NICHT vorkommen)
-- | OR (oder innerhalb [])

USE Northwind


SELECT *
FROM Customers
WHERE CustomerID LIKE 'ALF%'

-- alle Kunden, deren CustomerID mit A beginnt
SELECT *
FROM Customers
WHERE CustomerID LIKE 'A%'

-- alle Kunden, deren CustomerID mit MI endet
SELECT *
FROM Customers
WHERE CustomerID LIKE '%MI'


-- alle Kunden, deren Firmenname eine bestimmte Zeichenfolge enthält
SELECT *
FROM Customers
WHERE CompanyName LIKE '%kist%'



-- eckige Klammern bisher [Order Details]

-- eckige Klammern als Wildcard:
-- Wertebereiche []
-- [] steht für genau 1 Zeichen aus einem bestimmten Wertebereich


-- alle, die mit a, b oder c beginnen (a-c)
SELECT *
FROM Customers
WHERE CustomerID LIKE '[a-c]%'

-- die mit a oder c beginnen
SELECT *
FROM Customers
WHERE CustomerID LIKE '[ac]%'


-- alle, die mit a-c beginnen und mit e-g enden
-- entweder so:
SELECT *
FROM Customers
WHERE CompanyName LIKE '[a-c]%' AND CompanyName LIKE '%[e-g]'


/*
	axxxxxg
	axf
	axxxxxxxe
	bf
	cxxxxg

*/

-- oder:
SELECT *
FROM Customers
WHERE CompanyName LIKE '[a-c]%[e-g]'


-- alle, die mit a-c oder e-g enden
SELECT *
FROM Customers
WHERE CompanyName LIKE '%[a-c]' OR CompanyName LIKE '%[e-g]'

-- oder:
SELECT *
FROM Customers
WHERE CompanyName LIKE '%[a-c|e-g]'


-- [] kann auch Sonderzeichen suchen

-- Suche nach %- Zeichen
SELECT *
FROM Customers
WHERE CompanyName LIKE '%[%]%'


-- Suche nach Sonderzeichen mit ESCAPE-Character
SELECT *
FROM Customers
WHERE CompanyName LIKE '%!%%' ESCAPE '!' -- wir suchen nach % irgendwo im Namen
-- wir dürfen selbst festlegen, was der Escape-character sein soll (könnte auch ein $ Zeichen o.Ä. sein)


-- Suche nach Hochkomma??
SELECT *
FROM Customers
WHERE CompanyName LIKE '%''%'


-- Geben Sie alle Produkte aus, die vom Anbieter (SupplierID) 2, 7 oder 15 geliefert werden.
SELECT *
FROM Products
WHERE SupplierID IN(2, 7, 15)


-- Geben Sie alle Produkte aus, die ein 'ost' im Namen haben.
SELECT *
FROM Products
WHERE ProductName LIKE '%ost%'


-- Geben Sie alle Produkte aus, deren Name mit D-L beginnt und mit a, b, c, d oder m, n, o endet.
SELECT *
FROM Products
WHERE ProductName LIKE '[d-l]%' AND (ProductName LIKE '%[a-d]' OR ProductName LIKE '%[m-o]')


-- Profilösung:
SELECT *
FROM Products
WHERE ProductName LIKE '[d-l]%[a-d|m-o]'




-- CustomerID besteht aus 5 Buchstaben
-- angenommen, es ist ein Fehler passiert
-- CMX5Z ... wie finde ich die falschen Einträge?

-- wie finde ich die richtigen Einträge? (5 Buchstaben)
SELECT *
FROM Customers
WHERE CustomerID LIKE '[a-z][a-z][a-z][a-z][a-z]'

SELECT *
FROM Employees
WHERE FirstName LIKE REPLICATE('[a-z]', LEN(FirstName))

-- CMX5Z ... wie finde ich die falschen Einträge?
SELECT *
FROM Customers
WHERE CustomerID NOT LIKE '[a-z][a-z][a-z][a-z][a-z]'


-- z.B. bei PIN-Code
--SELECT *
--FROM Tabelle
--WHERE PinCode NOT LIKE '[0-9][0-9][0-9][0-9]'


-- NOT Wildcard
SELECT *
FROM Customers
WHERE CompanyName LIKE '[^a-c]%' -- ^ steht für NICHT, also alle, die NICHT mit a, b oder c beginnen


-- EIN unbekanntes Zeichen
SELECT *
FROM Customers
WHERE Phone LIKE '(5) 555-472[0-9]'

SELECT *
FROM Customers
WHERE Phone LIKE '(5) 555-472_' -- _ (Unterstrich) steht für genau 1 unbekanntes Zeichen


-- alle Kunden, deren CompanyName mit d, e oder f beginnt, der letzte Buchstabe ist ein l und der drittletzte ein d

SELECT *
FROM Customers
WHERE CompanyName LIKE '[d-f]%[d]_[l]'

-- oder [] weglassen, brauchen wir hier für d und l nicht:
SELECT *
FROM Customers
WHERE CompanyName LIKE '[d-f]%d_l'

/*

	edel
	dxdxl
	fidel
	fxxxxxxxxxxxxxxxxxxxxxxxxxdxl

	Ernst Handel (Treffer in DB)
	e........d.l

*/



SELECT *
FROM Customers
WHERE CompanyName LIKE 'a%'
