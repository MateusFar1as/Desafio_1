CREATE DATABASE adventure;

USE adventure;

CREATE TABLE calendar (
	Date DATE
);

CREATE TABLE customers (
	CustomerKey INT NOT NULL,
	Prefix VARCHAR(4),
	FirstName VARCHAR(25),
	LastName  VARCHAR(25),
	BirthDate DATE,
	MaritalStatus CHAR(1),
	Gender VARCHAR(2),
	EmailAddress VARCHAR(50),
	AnnualIncome DECIMAL(10,2),
	TotalChildren INT,
	EducationLevel VARCHAR(25),
	Occupation VARCHAR(50),
	HomeOwner CHAR(1),
	PRIMARY KEY (CustomerKey)
);

CREATE TABLE product_categories (
	ProductCategoryKey INT NOT NULL,
	CategoryName VARCHAR(15),
	PRIMARY KEY (ProductCategoryKey)
);

CREATE TABLE product_subcategories (
    ProductSubcategoryKey INT NOT NULL,
    SubcategoryName VARCHAR(15),
    ProductCategoryKey INT NOT NULL,
    PRIMARY KEY (ProductSubcategoryKey),
    FOREIGN KEY (ProductCategoryKey) REFERENCES product_categories (ProductCategoryKey)
);

CREATE TABLE products (
	ProductKey INT NOT NULL,
	ProductSubcategoryKey INT NOT NULL,
	ProductSKU VARCHAR(15),
	ProductName TEXT,
	ModelName TEXT,
	ProductDescription TEXT,
	ProductColor VARCHAR(25),
	ProductSize VARCHAR(5),
	ProductStyle CHAR(1),
	ProductCost DECIMAL(15,4),
	ProductPrice DECIMAL(15,4),
	PRIMARY KEY (ProductKey),
	FOREIGN KEY (ProductSubcategoryKey) REFERENCES product_subcategories (ProductSubcategoryKey)
);

CREATE TABLE territories (
	SalesTerritoryKey INT NOT NULL,
	Region VARCHAR(25),
	Country VARCHAR(25),
	Continent VARCHAR(25),
	PRIMARY KEY (SalesTerritoryKey)
);

CREATE TABLE returns (
	ReturnDate DATE,
	TerritoryKey INT NOT NULL,
	ProductKey INT NOT NULL,
	ReturnQuantity INT,
	FOREIGN KEY (ProductKey) REFERENCES products (ProductKey),
	FOREIGN KEY (TerritoryKey) REFERENCES territories (SalesTerritoryKey)
);

CREATE TABLE sales_2015 (
	OrderDate DATE,
	StockDate DATE,
	OrderNumber VARCHAR(15),
	ProductKey INT NOT NULL,
	CustomerKey INT NOT NULL,
	TerritoryKey INT NOT NULL,
	OrderLineItem INT,
	OrderQuantity INT,
	FOREIGN KEY (CustomerKey) REFERENCES customers (CustomerKey),
	FOREIGN KEY (ProductKey) REFERENCES products (ProductKey),
	FOREIGN KEY (TerritoryKey) REFERENCES territories (SalesTerritoryKey)
);

CREATE TABLE sales_2016 (
	OrderDate DATE,
	StockDate DATE,
	OrderNumber VARCHAR(15),
	ProductKey INT NOT NULL,
	CustomerKey INT NOT NULL,
	TerritoryKey INT NOT NULL,
	OrderLineItem INT,
	OrderQuantity INT,
	FOREIGN KEY (CustomerKey) REFERENCES customers (CustomerKey),
	FOREIGN KEY (ProductKey) REFERENCES products (ProductKey),
	FOREIGN KEY (TerritoryKey) REFERENCES territories (SalesTerritoryKey)
);

CREATE TABLE sales_2017 (
	OrderDate DATE,
	StockDate DATE,
	OrderNumber VARCHAR(15),
	ProductKey INT NOT NULL,
	CustomerKey INT NOT NULL,
	TerritoryKey INT NOT NULL,
	OrderLineItem INT,
	OrderQuantity INT,
	FOREIGN KEY (CustomerKey) REFERENCES customers (CustomerKey),
	FOREIGN KEY (ProductKey) REFERENCES products (ProductKey),
	FOREIGN KEY (TerritoryKey) REFERENCES territories (SalesTerritoryKey)
);
