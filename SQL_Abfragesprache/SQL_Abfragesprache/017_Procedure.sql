-- Procedure (Prozedur)


CREATE PROC pDemo1
AS
SELECT TOP 1 * FROM Orders ORDER BY Freight
SELECT TOP 1 * FROM Orders ORDER BY Freight DESC
SELECT Country FROM Customers WHERE CustomerID LIKE 'a%'
GO


EXEC pDemo1


CREATE PROC pCustomersCity @City varchar(30)
AS
SELECT * FROM Customers WHERE City = @City
GO


EXEC pCustomersCity @City = 'Buenos Aires'



CREATE PROC pCustomerCountryCity @Country varchar(30), @City varchar(30)
AS
SELECT * FROM Customers WHERE City = @City AND Country = @Country
GO

EXEC pCustomerCountryCity @City = 'Buenos Aires', @Country = 'Argentina'


