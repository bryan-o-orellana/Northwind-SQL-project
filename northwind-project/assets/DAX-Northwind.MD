# 🧮 DAX Measures – Northwind Sales Dashboard
>
This file contains all the DAX measures created for the **Northwind BI** data model, in order to analyze sales from different perspectives (product, customer, country, carrier, time, and employees).

---

## ⚙️ 1. Medidas Base

```DAX
-- Total de Ventas
Total Ventas = 
SUM ( FactVentas[TotalVenta] )

-- Ventas Anuales
Ventas año = 
CALCULATE (
    [Total Ventas],
    DATESYTD ( DimTiempo[Fecha] )
)

-- Top Productos más Vendidos
TopProducto = 
VAR Top1 = 
    TOPN(
        1,
        SUMMARIZE(
            FactVentas,
            DimProducto[Producto],
            "Ventas", [Total Ventas]
        ),
        [Ventas], DESC
    )
RETURN
CONCATENATEX(Top1, DimProducto[Producto], ", ")

-- Top Cliente por Ventas
TopCliente = 
VAR Top1 = 
    TOPN(
        1,
        SUMMARIZE(
            FactVentas,
            DimCliente[Cliente],
            "Ventas", [Total Ventas]
        ),
        [Ventas], DESC
    )
RETURN
CONCATENATEX(Top1, DimCliente[Cliente], ", ")

-- Ventas por Transportista
Ventas por Transportista = 
CALCULATE (
    [Total Ventas],
    ALLEXCEPT ( DimShipper, DimShipper[NombreTransportista] )
)

-- Ventas por Empleado
Ventas por Empleado = 
CALCULATE (
    [Total Ventas],
    ALLEXCEPT ( DimEmpleado, DimEmpleado[NombreEmpleado] )
)

-- Ventas por Cliente
Ventas por Cliente = 
CALCULATE (
    [Total Ventas],
    ALLEXCEPT ( DimCliente, DimCliente[NombreCliente] )
)

-- Ventas por País
Ventas por País = 
CALCULATE (
    [Total Ventas],
    ALLEXCEPT ( DimCliente, DimCliente[País] )
)

-- Crecimiento % vs Año Anterior
YoY Growth = 
VAR VentasActual = [Total Ventas]
VAR VentasPrevias = CALCULATE (
    [Total Ventas],
    SAMEPERIODLASTYEAR ( DimTiempo[Fecha] )
)
RETURN
DIVIDE ( VentasActual - VentasPrevias, VentasPrevias )
```
>
📊 Notes

All measures use the star model with FactVentas as the fact table and the following dimensions: DimCliente, DimEmpleado, DimShipper, DimProducto, and DimTiempo.

Each visual in Power BI uses one or more of these measures.

Some measures (such as Top N) work best in table or matrix visuals.

✍️ Autor: Bryan Odair Orellana Chavez



