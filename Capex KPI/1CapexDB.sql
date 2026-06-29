Create Database CapExDB;
Go;

Use CapExDB;
Go

CREATE TABLE Equipment_Capex_Forecast (
    ForecastID        INT IDENTITY(1,1) PRIMARY KEY,
    FiscalYear        INT NOT NULL,
    Zone              VARCHAR(50) NOT NULL,
    CountryTerritory  VARCHAR(100) NOT NULL,
    BusinessUnit      VARCHAR(100),
    Department        VARCHAR(100),
    EquipmentCategory VARCHAR(100),
    EquipmentName     VARCHAR(150),
    CurrencyCode      CHAR(3) DEFAULT 'USD',

    Q1Amount          DECIMAL(18,2) DEFAULT 0,
    Q2Amount          DECIMAL(18,2) DEFAULT 0,
    Q3Amount          DECIMAL(18,2) DEFAULT 0,
    Q4Amount          DECIMAL(18,2) DEFAULT 0,

    AnnualTotal AS
    (
        ISNULL(Q1Amount,0) +
        ISNULL(Q2Amount,0) +
        ISNULL(Q3Amount,0) +
        ISNULL(Q4Amount,0)
    ),

    ApprovalStatus    VARCHAR(30) DEFAULT 'Draft',
    CreatedDate       DATETIME DEFAULT GETDATE()
);

Go

--Year 2027 Sample data
INSERT INTO Equipment_Capex_Forecast
(FiscalYear, Zone, CountryTerritory, BusinessUnit, Department,
 EquipmentCategory, EquipmentName, CurrencyCode,
 Q1Amount, Q2Amount, Q3Amount, Q4Amount)
VALUES
(2027,'North America','USA','Manufacturing','Production',
 'Production Equipment','CNC Machine','USD',0,550000,0,0),

(2027,'North America','Canada','Warehouse','Logistics',
 'Material Handling','Forklift','CAD',45000,0,0,0),

(2027,'Europe','Germany','Manufacturing','Production',
 'Plant Equipment','Air Compressor','EUR',0,0,120000,0),

(2027,'Europe','France','IT','Infrastructure',
 'IT Equipment','Servers','EUR',0,0,80000,0),

(2027,'Asia Pacific','India','Corporate','Administration',
 'Office Equipment','Office Furniture','INR',0,0,0,35000),

(2027,'Asia Pacific','China','Manufacturing','Production',
 'Production Equipment','Packaging Machine','CNY',0,0,0,150000);

 Go

 --Year 2028 Sample data

 INSERT INTO Equipment_Capex_Forecast
(FiscalYear, Zone, CountryTerritory, BusinessUnit, Department,
 EquipmentCategory, EquipmentName, CurrencyCode,
 Q1Amount, Q2Amount, Q3Amount, Q4Amount)
VALUES
(2028,'North America','USA','Manufacturing','Production',
 'Production Equipment','CNC Machine Upgrade','USD',0,300000,0,0),

(2028,'Europe','France','IT','Infrastructure',
 'IT Equipment','Server Refresh','EUR',0,0,120000,0),

(2028,'Asia Pacific','China','Manufacturing','Production',
 'Production Equipment','Packaging Machine','CNY',0,300000,0,0),

(2028,'Asia Pacific','India','Corporate','Administration',
 'Office Equipment','Office Renovation','INR',25000,0,0,0);

 Go

 CREATE VIEW vw_CapexForecast
AS
SELECT
    ForecastID,
    FiscalYear,
    Zone,
    CountryTerritory,
    BusinessUnit,
    Department,
    EquipmentCategory,
    EquipmentName,
    CurrencyCode,
    Q1Amount,
    Q2Amount,
    Q3Amount,
    Q4Amount,
    AnnualTotal,
    ApprovalStatus
FROM Equipment_Capex_Forecast;

