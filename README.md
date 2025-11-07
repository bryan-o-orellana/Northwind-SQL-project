no# 🌐 Northwind Sales Analysis — SQL + Power BI Project

## 📘 Overview
This project analyzes sales data from the **Northwind** sample database using **SQL Server** and visualizes key business metrics in **Power BI**.  
It demonstrates SQL skills for **data analysis**, **query optimization**, and **business intelligence reporting** — from database creation to advanced analytics and dashboards.

---

## 🎯 Objectives
- Design a **data model** using the *Star Schema* approach.  
- Write **SQL analytical queries** to extract key business insights.  
- Apply **CTEs**, **window functions**, and **stored procedures** for dynamic and advanced reporting.  
- Build an **interactive Power BI dashboard** to visualize sales performance and trends.

---

## 🧱 Repository Structure
```bash
📦 Northwind-SQL-Project/
│
├── sql/
│   ├── database_creation.sql            # Script to create and populate the Northwind database
│   ├── queries.sql                      # Basic analytical queries
│   ├── advanced-queries.sql             # Advanced queries with CTEs and window functions, Stored procedures for dynamic analysis
│            
│
├── assets/
│   ├── ERD.png                          # ERD diagram of the star schema
│   ├── Northwind-project.pdf            # Power BI dashboard and insights
│   ├── Northwind-project.pbix           # .pbix Full Project
│   ├── model.png                        # Pic that I used as a reference to the model
│   ├── DAX-Northwind.MD                 # MD file with the measures used in DAX
│ 
└── README.md                           # Project documentation
```
🧩 Data Model

The project follows a simplified Star Schema, including the following tables:

Table	Type	Description
FactVentas	Fact	Contains sales transactions
DimEmpleado	Dimension	Employee details
DimCliente	Dimension	Customer information
DimShipper	Dimension	Shipper/transport details
DimTiempo	Dimension	Date and time dimension

📄 See assets/diagrama_erd.png for the full ERD diagram.

🧠 SQL Topics Covered

✅ Aggregations and grouping (SUM, COUNT, AVG)
>
✅ Common Table Expressions (CTEs)
>
✅ Window functions: RANK(), LAG()
>
✅ Stored Procedures with parameters
>
✅ Data modeling for reporting
>
✅ KPI and performance calculation
>

| Query Type                                           | Description                                            |
| ---------------------------------------------------- | ------------------------------------------------------ |
| **Total Sales per Year**                             | Calculates annual sales trends                         |
| **Top 10 Products**                                  | Identifies the best-selling products                   |
| **Sales by Customer and Country**                    | Highlights regional performance                        |
| **Sales by Shipper**                                 | Compares transport efficiency                          |
| **Monthly Sales by Year**                            | Evaluates seasonality patterns                         |
| **Sales by Employee**                                | Tracks sales contribution per representative           |
| 🧮 **Year-over-Year Growth (CTE + LAG)**             | Measures growth vs. the previous year                  |
| 🏆 **Top Customers per Country (RANK)**              | Ranks customers by sales within each country           |
| ⚙️ **Stored Procedure:** `sp_TopClientesPorPaisYAño` | Returns top *N* customers for a given country and year |
>
## 📄 DB script creation
📥 [DB Creation .sql](https://github.com/bryan-o-orellana/Northwind-SQL-project/blob/main/northwind-project/SQL/database_creation.sql)
>
## 📄 Basic SQL scripts
📥 [Basic queries .sql](https://github.com/bryan-o-orellana/Northwind-SQL-project/blob/main/northwind-project/SQL/queries.sql)
>
## 📄 Advanced SQL scripts
📥 [Advanced queries .sql](https://github.com/bryan-o-orellana/Northwind-SQL-project/blob/main/northwind-project/SQL/advanced-queries.sql)
>
---
## 📈 Power BI Dashboard
>
## 📊 Preview
>
<img width="487" height="397" alt="1" src="https://github.com/bryan-o-orellana/Northwind-SQL-project/blob/main/northwind-project/assets/preview.png" />
The Power BI report (analisis_bi.pdf) visualizes:
>
💰 Total Sales KPIs and YoY Growth

🛍️ Top Products & Customers charts

🌍  Sales by Customer

🚚 Performance by Shipper

👤 Employee Contribution Breakdown

| Tool           | Purpose                         |
| -------------- | ------------------------------- |
| **SQL Server** | Database & query execution      |
| **Power BI**   | Data visualization & reporting  |
| **GitHub**     | Version control & documentation |
>

## 📄 Report File
📥 [Download Report (PDF)]![Full report](./northwind-project/assets/Northwind-project.pdf) 
>
## 📄 DAX Measures
📥 [Go to DAX measures]![DAX](https://github.com/bryan-o-orellana/Northwind-SQL-project/blob/main/northwind-project/assets/DAX-Northwind.MD) 
>
>
## 💬 Author
**Bryan Odair Orellana Chávez**  
💼 Business Intelligence & Data Analytics
📍 Honduras  
📧 [Contact me on LinkedIn](https://www.linkedin.com/in/bryanxavez)

💬 Notes

This project is part of my data analytics portfolio and aims to showcase:

SQL querying and optimization skills

Business-oriented data modeling

Data visualization and storytelling through Power BI

Feel free to explore the repository, reuse the queries, or connect with me for collaboration.
