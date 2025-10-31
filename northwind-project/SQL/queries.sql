
/* ============================================================
   PROYECTO: Análisis de Ventas - Business Intelligence
   DESCRIPCIÓN GENERAL:
       Este proyecto implementa un modelo de datos tipo estrella 
       basado en una tabla de hechos (factVentas) y múltiples 
       dimensiones (Clientes, Empleados, Productos, Tiempo y Shippers).
       
-- Northwind Basic Queries
-- Author: Bryan Orellana
-- Description: Basic analytical queries for the Northwind database

       Las consultas SQL contenidas en este proyecto permiten 
       obtener indicadores clave de negocio (KPI) como:
       - Ventas anuales y mensuales
       - Top productos más vendidos
       - Ventas por cliente y región
       - Desempeño por empleado y transportista

       Los resultados de estas consultas sirven como base 
       para la construcción de un dashboard interactivo en Power BI,
       con el objetivo de facilitar la toma de decisiones comerciales.
   ============================================================ */

use Northwind

/* ============================================================
   CONSULTA: Total de ventas por año
   DESCRIPCIÓN:
       Calcula la suma total de las ventas registradas en la tabla
       de hechos (factVentas) agrupadas por año calendario.
       Útil para analizar tendencias anuales de facturación.
   ============================================================ */

select * from dimTiempo

SELECT 
    dt.Anio,
    SUM(fv.ImporteNeto) AS TotalVentas	
FROM factVentas AS fv
JOIN dimTiempo AS dt ON fv.fecha = dt.Fecha
GROUP BY dt.Anio
ORDER BY dt.Anio;


/* ============================================================
   CONSULTA: Top 10 productos más vendidos
   DESCRIPCIÓN:
       Muestra los 10 productos con mayor monto total de ventas.
       Combina los datos de factVentas y dimProducto.
       Ideal para conocer los productos más rentables.
   ============================================================ */

SELECT TOP 10
    dp.Producto,
    SUM(fv.ImporteNeto) AS TotalVentas
FROM factVentas AS fv
JOIN dimProducto AS dp ON fv.ProductID = dp.ProductID
GROUP BY dp.Producto
ORDER BY TotalVentas DESC;

/* ============================================================
   CONSULTA: Ventas por cliente y país
   DESCRIPCIÓN:
       Agrupa las ventas por cliente y país de origen.
       Permite identificar los clientes más valiosos por región.
   ============================================================ */
select * from FactVentas
select * from DimCliente

SELECT 
    dc.Pais,
    dc.Cliente,
    SUM(fv.ImporteNeto) AS TotalVentas
FROM factVentas AS fv
JOIN dimCliente AS dc ON fv.CustomerID = dc.CustomerID
GROUP BY dc.Pais, dc.Cliente
ORDER BY TotalVentas DESC;

/* ============================================================
   CONSULTA: Ventas por transportista
   DESCRIPCIÓN:
       Calcula el total de ventas y el número de envíos realizados
       por cada transportista (shipper). 
       Permite analizar el desempeño o carga de trabajo por proveedor logístico.
   ============================================================ */

select * from DimShipper
select * from FactVentas

SELECT 
    ds.Transportista,
    SUM(fv.ImporteNeto) AS TotalVentas,
    COUNT(DISTINCT fv.OrderID) AS NumeroDeEnvios
FROM factVentas AS fv
JOIN dimShipper AS ds ON fv.ShipperID = ds.ShipperID
GROUP BY ds.Transportista
ORDER BY TotalVentas DESC;

/* ============================================================
   CONSULTA: Ventas mensuales por año
   DESCRIPCIÓN:
       Resume el total de ventas agrupadas por mes y año.
       Ideal para gráficos de series temporales en Power BI.
   ============================================================ */

select * from DimShipper
select * from FactVentas

SELECT 
    dt.Anio,
    dt.MesNombre,
    SUM(fv.ImporteNeto) AS TotalMensual
FROM factVentas AS fv
JOIN dimTiempo AS dt ON fv.Fecha = dt.Fecha
GROUP BY dt.Anio, dt.MesNombre
ORDER BY dt.Anio, dt.MesNombre;

/* ============================================================
   CONSULTA: Ventas por empleado
   DESCRIPCIÓN:
       Muestra el total de ventas y la cantidad de operaciones 
       por cada empleado registrado en dimEmpleado.
       Permite medir desempeño comercial individual.
   ============================================================ */

select * from DimEmpleado
select * from FactVentas

SELECT 
    de.Empleado,
    SUM(fv.ImporteNeto) AS TotalVentas,
    COUNT(DISTINCT fv.OrderID) AS NumeroDeVentas
FROM factVentas AS fv
JOIN dimEmpleado AS de ON fv.EmployeeID = de.EmployeeID
GROUP BY de.Empleado
ORDER BY TotalVentas DESC;


---ADITIONAL ANALISES---

/* ============================================================
   CONSULTA: Ranking de productos por ventas
   DESCRIPCIÓN:
       Muestra un ranking de los productos incluidos en las ventas
   ============================================================ */

SELECT 
    c.CategoryName,
    p.ProductName,
    SUM(od.UnitPrice * od.Quantity) AS TotalSales,
    RANK() OVER(PARTITION BY c.CategoryName ORDER BY SUM(od.UnitPrice * od.Quantity) DESC) AS RankInCategory
FROM [Order Details] od
JOIN Products p ON od.ProductID = p.ProductID
JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName, p.ProductName;