-- =========================================
-- CUSTOMER DIMENSION
-- =========================================

CREATE TABLE DimCustomer
(
    CustomerID VARCHAR(10) PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50),
    StateName VARCHAR(50),
    CustomerType VARCHAR(30)
);

INSERT INTO DimCustomer VALUES
('C001','ABC Industries','Hyderabad','Telangana','Corporate'),
('C002','XYZ Retail','Bengaluru','Karnataka','Retail'),
('C003','Delta Traders','Chennai','Tamil Nadu','Wholesale'),
('C004','Mega Stores','Mumbai','Maharashtra','Retail'),
('C005','Prime Logistics','Pune','Maharashtra','Corporate');

-- =========================================
-- WAREHOUSE DIMENSION
-- =========================================

CREATE TABLE DimWarehouse
(
    WarehouseID VARCHAR(10) PRIMARY KEY,
    WarehouseName VARCHAR(100),
    City VARCHAR(50),
    Capacity INT
);

INSERT INTO DimWarehouse VALUES
('W001','South Hub','Hyderabad',5000),
('W002','Central Hub','Bengaluru',7000),
('W003','West Hub','Mumbai',6000);

-- =========================================
-- VEHICLE DIMENSION
-- =========================================

CREATE TABLE DimVehicle
(
    VehicleID VARCHAR(10) PRIMARY KEY,
    VehicleNumber VARCHAR(20),
    VehicleType VARCHAR(50),
    CapacityTons DECIMAL(10,2)
);

INSERT INTO DimVehicle VALUES
('V001','AP09AB1234','Truck',15),
('V002','KA01CD5678','Trailer',25),
('V003','TN05EF7890','Mini Truck',8),
('V004','MH12GH4567','Container',30);

-- =========================================
-- ROUTE DIMENSION
-- =========================================

CREATE TABLE DimRoute
(
    RouteID VARCHAR(10) PRIMARY KEY,
    SourceCity VARCHAR(50),
    DestinationCity VARCHAR(50),
    DistanceKM INT
);

INSERT INTO DimRoute VALUES
('R001','Hyderabad','Bengaluru',570),
('R002','Hyderabad','Chennai',630),
('R003','Bengaluru','Chennai',350),
('R004','Mumbai','Pune',150);

-- =========================================
-- FACT SHIPMENT
-- =========================================

CREATE TABLE FactShipment
(
    ShipmentID VARCHAR(10) PRIMARY KEY,
    OrderID VARCHAR(10),
    CustomerID VARCHAR(10),
    WarehouseID VARCHAR(10),
    VehicleID VARCHAR(10),
    RouteID VARCHAR(10),

    DispatchDate DATE,
    DeliveryDate DATE,

    Revenue DECIMAL(18,2),
    Cost DECIMAL(18,2),

    Status VARCHAR(20),

    CONSTRAINT FK_Customer
        FOREIGN KEY(CustomerID)
        REFERENCES DimCustomer(CustomerID),

    CONSTRAINT FK_Warehouse
        FOREIGN KEY(WarehouseID)
        REFERENCES DimWarehouse(WarehouseID),

    CONSTRAINT FK_Vehicle
        FOREIGN KEY(VehicleID)
        REFERENCES DimVehicle(VehicleID),

    CONSTRAINT FK_Route
        FOREIGN KEY(RouteID)
        REFERENCES DimRoute(RouteID)
);

INSERT INTO FactShipment VALUES
('S001','O001','C001','W001','V001','R001',
 '2025-01-01','2025-01-03',12000,8500,'On Time'),

('S002','O002','C002','W001','V002','R002',
 '2025-01-02','2025-01-05',18000,12000,'Delayed'),

('S003','O003','C003','W002','V003','R003',
 '2025-01-03','2025-01-04',9000,6500,'On Time'),

('S004','O004','C001','W002','V001','R001',
 '2025-01-04','2025-01-06',14000,9000,'On Time'),

('S005','O005','C004','W003','V004','R004',
 '2025-01-05','2025-01-08',22000,16000,'Delayed');

-- =========================================
-- FACT COST
-- =========================================

CREATE TABLE FactCost
(
    ShipmentID VARCHAR(10) PRIMARY KEY,

    FuelCost DECIMAL(18,2),
    TollCost DECIMAL(18,2),
    DriverCost DECIMAL(18,2),
    MaintenanceCost DECIMAL(18,2),

    CONSTRAINT FK_ShipmentCost
        FOREIGN KEY(ShipmentID)
        REFERENCES FactShipment(ShipmentID)
);

INSERT INTO FactCost VALUES
('S001',3000,500,2500,500),
('S002',4500,800,3000,700),
('S003',2200,300,1800,400),
('S004',3200,500,2600,400),
('S005',6000,1200,4200,900);

-- =========================================
-- INVENTORY FACT
-- =========================================

CREATE TABLE FactInventory
(
    InventoryID VARCHAR(10) PRIMARY KEY,
    WarehouseID VARCHAR(10),

    ProductName VARCHAR(100),
    Quantity INT,
    InventoryValue DECIMAL(18,2),

    CONSTRAINT FK_InventoryWarehouse
        FOREIGN KEY(WarehouseID)
        REFERENCES DimWarehouse(WarehouseID)
);

INSERT INTO FactInventory VALUES
('I001','W001','Laptop',200,10000000),
('I002','W001','Mobile',500,7500000),
('I003','W002','Printer',150,3000000),
('I004','W003','Scanner',100,1500000),
('I005','W002','Router',300,4500000);