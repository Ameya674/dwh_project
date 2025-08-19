-- ===============================================================
-- CREATE TABLES IN SILVER SCHEMA
-- ===============================================================

-- drop tables if they already exist
DROP TABLE IF EXISTS silver.crm_cust_info;
DROP TABLE IF EXISTS silver.crm_prd_info;
DROP TABLE IF EXISTS silver.crm_sales_details;
DROP TABLE IF EXISTS silver.erp_CUST_AZ12;
DROP TABLE IF EXISTS silver.erp_LOC_A101;
DROP TABLE IF EXISTS silver.erp_PX_CAT_G1V2;
GO

-- create the silver.crm_cust_info table
CREATE TABLE silver.crm_cust_info
(
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_marital_status NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date DATE,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
GO

-- create the silver.crm_prd_info table
CREATE TABLE silver.crm_prd_info 
(
    prd_id INT,
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(50),
    prd_cost INT,
    prd_line NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt DATETIME
);
GO

-- create the silver.crm_sales_details table
CREATE TABLE silver.crm_sales_details 
(
    sls_ord_num NVARCHAR(50),
    sls_prd_key NVARCHAR(50),
    sls_cust_id INT,
    sls_order_dt INT,
    sls_ship_dt INT,
    sls_due_dt INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);
GO

-- create the silver.erp_CUST_AZ12 table
CREATE TABLE silver.erp_CUST_AZ12 
(
    cid NVARCHAR(50),
    bdate DATE,
    gen NVARCHAR(50)
);
GO

-- create the silver.erp_LOC_A101 table
CREATE TABLE silver.erp_LOC_A101 
(
    cid NVARCHAR(50),
    cntry NVARCHAR(50)
);
GO

-- create the silver.erp_PX_CAT_G1V2 table
CREATE TABLE silver.erp_PX_CAT_G1V2 
(
    cid NVARCHAR(50),
    cntry NVARCHAR(50),
    subcat NVARCHAR(50),
    maintenance NVARCHAR(50)
);
GO
