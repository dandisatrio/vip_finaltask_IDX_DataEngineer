CREATE DATABASE DWH_PROJECT

CREATE TABLE DimProduct (
	ProductID INT NOT NULL,
	ProductName VARCHAR (50) NOT NULL,
	ProductCategory VARCHAR (50) NOT NULL,
	ProductPrice INT NOT NULL,
	CONSTRAINT PK_DimProduct PRIMARY KEY (ProductID)
)

CREATE TABLE DimCustomer (
	CustomerID INT NOT NULL,
	CustomerName VARCHAR (50) NOT NULL,
	Age INT NOT NULL,
	Gender VARCHAR (50) NOT NULL,
	City VARCHAR (50) NOT NULL,
	NoHP VARCHAR (50) NOT NULL,
	CONSTRAINT PK_DimCustomer PRIMARY KEY (CustomerID)
)

CREATE TABLE DimStatusOrder (
	StatusID INT NOT NULL,
	StatusOrder VARCHAR (50) NOT NULL,
	StatusOrderDesc VARCHAR (50) NOT NULL,
	CONSTRAINT PK_DimStatusOrder PRIMARY KEY (StatusID)
)

CREATE TABLE FactSalesOrder (
	OrderID INT NOT NULL,
	CustomerID INT NOT NULL,
	ProductID INT NOT NULL,
	Quantity INT NOT NULL,
	Amount INT NOT NULL,
	StatusID INT NOT NULL,
	OrderDate DATE NOT NULL,
	CONSTRAINT PK_FactSalesOrder PRIMARY KEY (OrderID),
	CONSTRAINT FK_SalesCustomer FOREIGN KEY (CustomerID) REFERENCES DimCustomer (CustomerID),
	CONSTRAINT FK_SalesProduct FOREIGN KEY (ProductID) REFERENCES DimProduct (ProductID),
	CONSTRAINT FK_SalesStatus FOREIGN KEY (StatusID) REFERENCES DimStatusOrder (StatusID)
)

SELECT * FROM FactSalesOrder

CREATE OR ALTER PROCEDURE summary_status_order
(@StatusID int) AS
BEGIN
	SELECT
		a.OrderID,
		b.CustomerName,
		c.ProductName,
		a.Quantity,
		d.StatusOrder
	FROM FactSalesOrder a
	INNER JOIN DimCustomer b ON b.CustomerName = b.CustomerName
	INNER JOIN DimProduct c ON c.ProductName = c.ProductName
	INNER JOIN DimStatusOrder d ON d.StatusOrder = d.StatusOrder
	WHERE (d.StatusID) = @StatusID
END

EXEC summary_status_order @StatusID = 1
