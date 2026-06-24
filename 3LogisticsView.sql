

-- =========================================
-- VIEW FOR POWER BI
-- =========================================

CREATE VIEW vw_LogisticsDashboard
AS
SELECT
    fs.ShipmentID,
    fs.OrderID,
    fs.DispatchDate,
    fs.DeliveryDate,

    c.CustomerName,
    c.City AS CustomerCity,

    w.WarehouseName,

    v.VehicleNumber,
    v.VehicleType,

    r.SourceCity,
    r.DestinationCity,
    r.DistanceKM,

    fs.Revenue,
    fs.Cost,
    fs.Status,

    fc.FuelCost,
    fc.TollCost,
    fc.DriverCost,
    fc.MaintenanceCost,

    DATEDIFF(
        DAY,
        fs.DispatchDate,
        fs.DeliveryDate
    ) AS DeliveryDays

FROM FactShipment fs
INNER JOIN DimCustomer c
    ON fs.CustomerID = c.CustomerID
INNER JOIN DimWarehouse w
    ON fs.WarehouseID = w.WarehouseID
INNER JOIN DimVehicle v
    ON fs.VehicleID = v.VehicleID
INNER JOIN DimRoute r
    ON fs.RouteID = r.RouteID
LEFT JOIN FactCost fc
    ON fs.ShipmentID = fc.ShipmentID;
GO