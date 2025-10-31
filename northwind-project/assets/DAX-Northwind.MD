# 🧮 DAX Measures – Northwind Sales Dashboard

Este archivo contiene todas las medidas DAX creadas para el modelo de datos **Northwind BI**, con el fin de analizar las ventas desde diferentes perspectivas (producto, cliente, país, transportista, tiempo y empleados).

---

## ⚙️ 1. Medidas Base

```DAX
-- Total de Ventas
Total Ventas = 
SUM ( FactVentas[TotalVenta] )

-- Total de Unidades Vendidas
Total Unidades = 
SUM ( FactVentas[Cantidad] )

-- Ventas Mensuales
Ventas Mensuales = 
CALCULATE (
    [Total Ventas],
    DATESMTD ( DimTiempo[Fecha] )
)

-- Ventas Anuales
Ventas Anuales = 
CALCULATE (
    [Total Ventas],
    DATESYTD ( DimTiempo[Fecha] )
)

-- Top 10 Productos más Vendidos
Top 10 Productos = 
TOPN (
    10,
    SUMMARIZE (
        DimProducto,
        DimProducto[NombreProducto],
        "Ventas", [Total Ventas]
    ),
    [Ventas],
    DESC
)

-- Top 10 Clientes por Ventas
Top 10 Clientes = 
TOPN (
    10,
    SUMMARIZE (
        DimCliente,
        DimCliente[NombreCliente],
        "Ventas", [Total Ventas]
    ),
    [Ventas],
    DESC
)

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
Crecimiento Anual % = 
VAR VentasActual = [Total Ventas]
VAR VentasPrevias = CALCULATE (
    [Total Ventas],
    SAMEPERIODLASTYEAR ( DimTiempo[Fecha] )
)
RETURN
DIVIDE ( VentasActual - VentasPrevias, VentasPrevias )

📊 Notas

Todas las medidas usan el modelo estrella con FactVentas como tabla de hechos y las dimensiones:
DimCliente, DimEmpleado, DimShipper, DimProducto y DimTiempo.

Cada visual en Power BI usa una o más de estas medidas.

Algunas medidas (como Top N) funcionan mejor en visuales de tabla o matriz.

📅 Última actualización: {{Fecha de hoy}}
✍️ Autor: Bryan Odair Orellana Chavez


---

¿Querés que te lo deje con formato más “GitHub-friendly” (colores, emojis y encabezados bonitos tipo portfolio), o preferís algo más técnico y sobrio, como documentación profesional?
