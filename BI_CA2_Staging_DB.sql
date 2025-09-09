-- Creating Stagging area
create database BusinessIntelligence_Staging_DB;
use BusinessIntelligence_Staging_DB;
create table Customers (CustomerKey int, GeographyKey int, CustomerLabel varchar(100),
        Title varchar (5), FirstName varchar(50), MiddleName varchar(50),
        LastName varchar (50), NameStyle int, BirthDate date, MaritalStatus varchar (1),
        Suffix varchar(10), Gender varchar(1), EmailAddress varchar(100), YearlyIncome decimal(10,2),
        TotalChildren int, NumberChildrenAtHome int, Education varchar(30), Occupation varchar(30), 
        HouseOwnerFlag int, NumberCarsOwned int, AddressLine1 varchar(50), AddressLine2 varchar(50),
        Phone int, DateFirstPurchase date, CustomerType varchar(10), CompanyName varchar(4), 
        ETLLoadID int, LoadDate date, UpdateDate date);
        
create table products ( ProductKey int, ProductName varchar(150),
        UnitCost decimal(10, 2), UnitPrice decimal(10, 2));
        
create table sales(SalesOrderNumber int, SalesAmount decimal (10, 2), Quantity int,
		ProductName varchar(150), CustomerKey int, CustomerName varchar (50));
        
create table returns (SalesKey int, SalesAmount decimal (10,2), ReturnQuantity int,
		ReturnAmount decimal (10, 2), UnitCost decimal(10, 2), UnitPrice decimal(10,2),
        ProductName varchar(150), CustomerKey int, CustomerName varchar(50));
        
create table stock (ProductKey int, SafetyStockQuantity int, UnitCost decimal(10,2));

create table expenses (Expense_ID int, Department varchar(100), Category varchar(50),
		Year int, Amount decimal(10, 2));
        
        
        
        -- Creating Data warehouse
create database BusinessIntelligence_warehouse;

create table customers (CustomerID int primary key, CustomerName varchar(50), Gender varchar(1),
		EmailAddress varchar(150), Education varchar(150), Occupation varchar(150),
        Address varchar(150), GeographyKey int, Phone int
 );
create table products(ProductID int primary key, ProductName varchar(150), 
        UnitCost decimal(10,2), UnitPrice decimal(10,2)
 );
create table sales (SalesID int primary key, SalesAmount decimal(10,2), Quantity int, 
		ProductID int, ProductName varchar(150), CustomerID int, CustomerName varchar(150), 
        OrderDate date,
        
        FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
        FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
 );
create table returns (ReturnID int primary key, SalesID int, SalesAmount decimal (10, 2), 
        Quantity int, ProductID int, ProductName varchar(150), CustomerID int, 
        CustomerName varchar(150), OrderDate date,
        
        FOREIGN KEY (SalesID) REFERENCES Sales(SalesID),
        FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
        FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
 );
create table stock (StockID int primary key, ProductID int, StockQuantity int, 
        UnitCost decimal(10, 2),
        
        FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
 );
create table espenses(Id int primary key, MachineKey int, ITMachineKey int, DateKey date,
		CostAmount decimal (10, 2), CostType decimal (10, 2)); 
        
        
        
        -- Creating DataMart
CREATE SCHEMA IF NOT EXISTS businessintelligence_datamart;
 
CREATE TABLE businessintelligence_datamart.dim_customers (
   CustomerID INT PRIMARY KEY,
   CustomerName VARCHAR(100),
   GeographyKey VARCHAR(50)
);
 
CREATE TABLE businessintelligence_datamart.dim_products (
   ProductID INT PRIMARY KEY,
   ProductName VARCHAR(100),
   UnitPrice DECIMAL(10,2)
);
 
CREATE TABLE businessintelligence_datamart.fact_sales (
   SalesID INT PRIMARY KEY,
   ProductID INT,
   CustomerID INT,
   Quantity INT,
   SalesAmount DECIMAL(10,2),
   OrderDate date
);
 
CREATE TABLE businessintelligence_datamart.fact_returns (
   ReturnsID INT PRIMARY KEY,
   SalesID INT,
   ReturnAmount DECIMAL(10,2)
   
);
 
CREATE TABLE businessintelligence_datamart.fact_stock (
   StockID INT PRIMARY KEY,
   ProductID INT,
   StockQuantity INT
   
);