
-- drop the bronze.crm_cust_info table if it already exists
IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
	DROP bronze.crm_cust_info

GO

-- create the bronze.crm_cust_info table
CREATE TABLE bronze.crm_cust_info
(
	cst_id INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_material_status NVARCHAR(50),
	cst_gndr NVARCHAR(50),
	cst_create_date DATE
);

GO

-- drop the bronze.crm_prd_info table if it already exists
IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
	DROP bronze.crm_prd_info

GO

-- create the bronze.crm_prd_info table
CREATE TABLE bronze.crm_prd_info 
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

-- drop the bronze.crm_sales_details table if it already exists
IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
	DROP bronze.crm_sales_details

GO

-- create the bronze.crm_sales_details table
CREATE TABLE bronze.crm_sales_details 
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

-- drop the bronze.erp_CUST_AZ12 table if it already exists
IF OBJECT_ID('bronze.erp_CUST_AZ12', 'U') IS NOT NULL
	DROP bronze.erp_CUST_AZ12

GO

-- create the bronze.erp_CUST_AZ12 table
CREATE TABLE bronze.erp_CUST_AZ12 
(
cid NVARCHAR(50),
bdate DATE,
gen NVARCHAR(50)
);

GO

-- drop the bronze.erp_LOC_A101 table if it already exists
IF OBJECT_ID('bronze.erp_LOC_A101', 'U') IS NOT NULL
	DROP bronze.erp_LOC_A101

GO

-- create the bronze.erp_LOC_A101 table
CREATE TABLE bronze.erp_LOC_A101 
(
cid NVARCHAR(50),
cntry NVARCHAR(50)
);

GO

-- drop the bronze.erp_PX_CAT_G1V2 table if it already exists
IF OBJECT_ID('bronze.erp_PX_CAT_G1V2', 'U') IS NOT NULL
	DROP bronze.erp_PX_CAT_G1V2

GO

-- create the bronze.erp_PX_CAT_G1V2 table
CREATE TABLE bronze.erp_PX_CAT_G1V2 
(
cid NVARCHAR(50),
cntry NVARCHAR(50),
subcat NVARCHAR(50),
maintenance NVARCHAR(50)
);
