-- tempor�re Tabellen


/*
	
	-- lokale tempor�re Tabelle
	-- existiert nur in der aktuellen Session
	-- #Tabellenname


	-- globale tempor�re Tabelle
	-- Zugriff auch aus anderen Sessions
	-- ##Tabellenname


	-- existiert so lange, wie die Session besteht/die Verbindung da ist

	-- kann auch gel�scht werden

*/


SELECT CustomerID, Freight
INTO #testtable
FROM Orders


SELECT *
FROM #testtable


SELECT CustomerID, Freight
INTO ##testtable1
FROM Orders