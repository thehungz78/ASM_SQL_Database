CREATE DATABASE ASM_SE07203_Product;
GO

USE  ASM_SE07203_Product;
GO

CREATE TABLE Category (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(100) NOT NULL
);


CREATE TABLE Product (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductCode NVARCHAR(50) NOT NULL,
    ProductName NVARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    InventoryQuantity INT NOT NULL,
    ProductImage NVARCHAR(MAX),
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

Update Product 
Set ProductName = 'Nut'
Where ProductName = 'grape';
select * from Product

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeCode NVARCHAR(50) NOT NULL,
    EmployeeName NVARCHAR(100) NOT NULL,
    Position NVARCHAR(50),
    AuthorityLevel NVARCHAR(50) NOT NULL,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    Password NVARCHAR(255) NOT NULL,
    PasswordChanged BIT DEFAULT 0
);

SELECT * FROM Employee

INSERT INTO Employee VALUES 
('Emp1', 'Nguyen Van A', 'Admin', 'Admin', 'admin1', '123456', 1),
('Emp2', 'Nguyen Van B', 'Warehouse Manager', 'Warehouse Manager', 'warehousemanager1', '123456', 1),
('Emp3', 'Nguyen Van C', 'Sale', 'Sale', 'sale1', '123456', 0);


CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerCode NVARCHAR(50) NOT NULL,
    CustomerName NVARCHAR(100) NOT NULL,
    PhoneNumber NVARCHAR(20),
    Address NVARCHAR(255)
);

INSERT INTO Customer (CustomerCode, CustomerName, PhoneNumber, Address)
VALUES ('CUST001', 'John Doe', '1234567890', '123 Main St'),
       ('CUST002', 'Jane Smith', '9876543210', '456 Elm St');
INSERT INTO Customer (CustomerCode, CustomerName, PhoneNumber, Address)
VALUES 
('CUST001', 'Customer 1', '123456789', 'Address 1'),
('CUST002', 'Customer 2', '987654321', 'Address 2'),
('CUST003', 'Customer 3', '555555555', 'Address 3');


INSERT INTO Customer (CustomerCode, CustomerName, PhoneNumber, Address)
values ('ctm1','Nguyen van an', '03333213','Ha Noi');

select * from Customer

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    OrderDate DATETIME NOT NULL,
    EmployeeID INT,
    CustomerID INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

ALTER TABLE Orders NOCHECK CONSTRAINT ALL;
-- Chạy các lệnh INSERT
ALTER TABLE Orders CHECK CONSTRAINT ALL;



INSERT INTO Orders (OrderDate, EmployeeID, CustomerID)
VALUES 
('2023-12-10', 1, 1), 
('2023-12-11', 3, 1), 
('2023-12-12', 2, 1);


SELECT * FROM Orders;

SELECT * FROM Customer;



CREATE TABLE OrderDetail (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    ProductID INT,
    QuantitySold INT NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE Import (
    ImportID INT PRIMARY KEY IDENTITY(1,1),
    ImportDate DATETIME NOT NULL,
    EmployeeID INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

CREATE TABLE ImportDetail (
    ImportDetailID INT PRIMARY KEY IDENTITY(1,1),
    ImportID INT,
    ProductID INT,
    QuantityImported INT NOT NULL,
    ImportCost DECIMAL(10, 2),
    FOREIGN KEY (ImportID) REFERENCES Import(ImportID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);
INSERT INTO Category (CategoryName)
VALUES 
('cone'),
('popsicle'),
('ice cream cup');
select * from Category


INSERT INTO Product(ProductCode, ProductName, Price, InventoryQuantity, CategoryID)
VALUES 
('P001', 'Apple', 15000, 100, 1),  -- CategoryID 1: apple
('P002', 'Banana', 10000, 150, 1), -- CategoryID 2: Banana
('P003', 'grape', 12000, 120, 1), -- CategoryID 3: Grape
('P004', 'WaterMelon', 15000, 120, 1); --CategoryID 4: WaterMelon


Select * from Product


DECLARE @employeeID INT = 1; -- Giá trị mẫu cho EmployeeID (chỉnh lại giá trị theo thực tế).

SELECT 
    o.OrderID,
    o.OrderDate,
    c.CustomerName,
    c.PhoneNumber,
    e.EmployeeName,
    e.Position
FROM Orders o
INNER JOIN Customer c ON o.CustomerID = c.CustomerID
INNER JOIN Employee e ON o.EmployeeID = e.EmployeeID;
