-- VIEWS (Sichten)



CREATE VIEW vTestView
AS
SELECT CustomerID, CompanyName
FROM Customers
GO


SELECT CustomerID
FROM vTestView


SELECT CustomerID
FROM vTestView
WHERE CompanyName LIKE '[a-c]%'



CREATE VIEW vCustomerProducts
AS
SELECT	  c.CustomerID
		, c.CompanyName
		, c.ContactName
		, c.Phone
		, o.OrderID
		, o.OrderDate
		, o.ShippedDate
		, od.Quantity
		, p.ProductID
		, p.ProductName
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
				 INNER JOIN Products p ON p.ProductID = od.ProductID
GO



SELECT *
FROM vCustomerProducts
WHERE CustomerID = 'PARIS'
-- kein Ergebnis! PARIS kommt nicht vor, weil er noch nichts bestellt hat (INNER JOIN!)



CREATE VIEW vCustomersArgentina1
AS
SELECT c.CustomerID
		, c.CompanyName
		, o.OrderID
		, o.Freight
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE Country = 'Argentina'
GO



CREATE TABLE Helden(
		firstname char(30)
		, lastname varchar(30)
		)

INSERT INTO Helden (firstname, lastname)
VALUES( 'Bruce', 'Wayne'), ('Peter', 'Parker')


SELECT *
FROM Helden

CREATE VIEW vHeldenTest
AS
SELECT firstname, lastname
FROM Helden

SELECT *
FROM vHeldenTest


INSERT INTO Helden (firstname, lastname)
VALUES ('Mickey', 'Mouse')


SELECT *
FROM vHeldenTest