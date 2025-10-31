/* ============================================================
   PROYECTO: Análisis de Ventas - Business Intelligence - Advanced queries

   DESCRIPCIÓN GENERAL: Estas son algunas consultas para profundizar en los datos 
   y analizar otros aspectos claves.

-- Northwind Basic Queries
-- Author: Bryan Orellana
-- Description: Advanced queries for the Northwind database
   ============================================================ */

   use Northwind
   
   /* ============================================================
   ⚙️ 1️ Crecimiento de ventas interanual (con CTE + window functions)

	Objetivo: medir el crecimiento o caída de ventas de un año respecto al anterior.
   ============================================================ */
   WITH VentasAnuales AS (
    SELECT 
        YEAR(o.OrderDate) AS Año,
        SUM(od.UnitPrice * od.Quantity) AS VentasTotales
    FROM Orders o
    INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
    GROUP BY YEAR(o.OrderDate)
)
SELECT 
    Año,
    VentasTotales,
    LAG(VentasTotales) OVER (ORDER BY Año) AS VentasPrevias,
    ROUND(
        (VentasTotales - LAG(VentasTotales) OVER (ORDER BY Año)) * 100.0 
        / LAG(VentasTotales) OVER (ORDER BY Año),
        2
    ) AS CrecimientoPorcentual
FROM VentasAnuales
ORDER BY Año;

  /* ============================================================
⚙️ 2️ Ranking de clientes top dentro de cada país (con RANK y partición)

Objetivo: ver los mejores clientes de cada país, no solo en general,
para mostrar segmentación y ranking dinámico.
   ============================================================ */

SELECT 
    c.Country,
    c.CompanyName AS Cliente,
    SUM(od.UnitPrice * od.Quantity) AS VentasTotales,
    RANK() OVER(PARTITION BY c.Country ORDER BY SUM(od.UnitPrice * od.Quantity) DESC) AS RankingPais
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.Country, c.CompanyName
HAVING SUM(od.UnitPrice * od.Quantity) > 0
ORDER BY c.Country, RankingPais;

  /* ============================================================
⚙️ 3 SP Stored Procedure

Este procedimiento devuelve el Top N clientes de un país y año que se escojan.
Objetivo: ver los mejores clientes de cada país, no solo en general,
para mostrar segmentación y ranking dinámico.
   ============================================================ */

CREATE PROCEDURE sp_TopClientesPorPaisYAño
    @Pais NVARCHAR(50),
    @Año INT,
    @TopN INT = 5
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (@TopN)
        c.CompanyName AS Cliente,
        SUM(od.UnitPrice * od.Quantity) AS VentasTotales
    FROM Orders o
    INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
    INNER JOIN Customers c ON o.CustomerID = c.CustomerID
    WHERE c.Country = @Pais
      AND YEAR(o.OrderDate) = @Año
    GROUP BY c.CompanyName
    ORDER BY VentasTotales DESC;
END;

