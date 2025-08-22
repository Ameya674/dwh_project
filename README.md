# Data Warehouse Project – Medallion Architecture

## Project Overview
This project implements a **Data Warehouse (DW)** using SQL Server, consolidating raw CRM and ERP data, transforming it, and making it analytics-ready. It follows the **Medallion Architecture**, which organizes data into three layers: Bronze, Silver, and Gold.

---

## Medallion Architecture

The Medallion Architecture organizes data into layers:

      +-----------------+
      |      Gold       |  <-- Analytics-ready data
      +-----------------+
               ^
               |
      +-----------------+
      |      Silver     |  <-- Cleaned & transformed data
      +-----------------+
               ^
               |
      +-----------------+
      |      Bronze     |  <-- Raw ingested data
      +-----------------+


- **Bronze**: Raw data ingestion with minimal transformation.
- **Silver**: Cleaned, standardized, deduplicated, validated data.
- **Gold**: Analytics-ready tables/views for BI, dashboards, and reporting.

---

## Layers and Tables

### Bronze Layer
- Raw tables:
  - `crm_cust_info`, `crm_prd_info`, `crm_sales_details`
  - `erp_CUST_AZ12`, `erp_LOC_A101`, `erp_PX_CAT_G1V2`
- Data loaded using `BULK INSERT` from CSV files.

### Silver Layer
- Cleaned and standardized versions of Bronze tables.
- Transformations include:
  - Trimming text fields (`TRIM`)
  - Standardizing gender and marital status
  - Converting date integers (`YYYYMMDD`) to `DATE`
  - Deduplicating records using `ROW_NUMBER()`
- Adds `dwh_create_date` column for tracking load time.

### Gold Layer
- Views for analytics:
  - `gold.customers` – customer dimension
  - `gold.products` – product dimension
  - `gold.sales` – sales fact table linking customers and products

---

## File Structure

---
sql-data-warehouse-project/
│
├── datasets/
│   ├── source_crm/
│   │   ├── cust_info.csv
│   │   ├── prd_info.csv
│   │   └── sales_details.csv
│   └── source_erp/
│       ├── CUST_AZ12.csv
│       ├── LOC_A101.csv
│       └── PX_CAT_G1V2.csv
│
├── scripts/
│   ├── bronze/
│   │   ├── create_bronze_layer.sql
│   │   └── load_bronze_layer.sql
│   ├── silver/
│   │   ├── create_silver_layer.sql
│   │   └── load_silver_layer.sql
│   └── gold/
│       └── create_gold_layer.sql
│
└── README.md


---

## How to Setup the Data Warehouse

Follow these steps to set up and run the data warehouse:

### 1. Prerequisites
- **SQL Server** installed on your machine (Developer or Express edition works).
- **SQL Server Management Studio (SSMS)** or any SQL client.
- Ensure you have access to the `datasets` folder with all CSV files.

---

### 2. Create the Data Warehouse
1. Open SSMS and connect to your SQL Server instance.
2. Run the script in `scripts/bronze/create_bronze_layer.sql` to create the **Bronze tables**.
3. Run the script in `scripts/silver/create_silver_layer.sql` to create the **Silver tables**.
4. Run the script in `scripts/gold/create_gold_layer.sql` to create the **Gold views**.

---

### 3. Load Data
1. Load raw data into the Bronze layer:
   ```sql
   EXEC bronze.load_bronze;

