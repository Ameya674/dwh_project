-- ===============================================================
-- CREATE VIEWS IN GOLD SCHEMA
-- ===============================================================


DROP VIEW IF EXISTS gold.customers;
DROP VIEW IF EXISTS gold.products;
DROP VIEW IF EXISTS gold.sales;

GO

CREATE VIEW gold.customers AS
SELECT
ROW_NUMBER() OVER(ORDER BY customer_info.cst_id) AS customer_key,
customer_info.cst_id AS customer_id,
customer_info.cst_key AS customer_number,
customer_info.cst_firstname AS first_name,
customer_info.cst_lastname AS last_name,
customer_location_details.cntry AS country,
customer_info.cst_marital_status AS marital_status,
CASE
	WHEN customer_info.cst_gndr != 'n/a' THEN customer_info.cst_gndr
	ELSE COALESCE(extra_customer_details.gen, 'n/a')
END as gender,
extra_customer_details.bdate AS birth_date,
customer_info.cst_create_date AS create_date
FROM silver.crm_cust_info AS customer_info
LEFT JOIN silver.erp_CUST_AZ12 AS extra_customer_details
ON customer_info.cst_key = extra_customer_details.cid
LEFT JOIN silver.erp_LOC_A101 AS customer_location_details
ON customer_info.cst_key = customer_location_details.cid;

GO

CREATE VIEW gold.products AS
SELECT 
ROW_NUMBER() OVER(ORDER BY product_info.prd_start_dt, product_info.prd_key) AS product_key,
product_info.prd_id AS product_id,
product_info.prd_key AS product_number,
product_info.prd_nm AS product_name,
product_info.cat_id AS category_id,
product_catalog.cat AS category,
product_catalog.subcat AS subcategory,
product_catalog.maintenance AS maintenance,
product_info.prd_cost AS product_cost,
product_info.prd_line AS product_line,
product_info.prd_start_dt AS start_date
FROM silver.crm_prd_info AS product_info
LEFT JOIN silver.erp_PX_CAT_G1V2 AS product_catalog
ON product_info.cat_id = product_catalog.id
WHERE product_info.prd_end_dt IS NULL

GO

CREATE VIEW gold.sales AS
SELECT 
sales.sls_ord_num AS order_number,
products.product_key AS product_key,
customers.customer_key AS customer_key,
sales.sls_order_dt AS order_date,
sales.sls_ship_dt AS shipping_date,
sales.sls_due_dt AS due_date,
sales.sls_sales AS sales_amount,
sales.sls_quantity AS quantity,
sales.sls_price AS price
FROM silver.crm_sales_details AS sales
LEFT JOIN gold.products AS products
ON sales.sls_prd_key = products.product_number
LEFT JOIN gold.customers AS customers
ON sales.sls_cust_id = customers.customer_id

GO


