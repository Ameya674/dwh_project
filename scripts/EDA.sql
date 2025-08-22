-- 1. What is the total number of customers?
SELECT COUNT(*) AS total_customers FROM gold.customers; 

-- 2. Which top 3 countries generate the highest revenue from sales?
SELECT TOP 3 
c.country, 
ROUND(CAST(SUM(s.sales_amount) AS FLOAT) / (SELECT SUM(sales_amount) FROM gold.sales) * 100, 2) AS total_sales_pct
FROM gold.sales AS s
LEFT JOIN gold.customers AS c
ON s.customer_key = c.customer_key
GROUP BY c.country
ORDER BY total_sales_pct DESC;

-- 3. What is the distribution of customers by gender?
SELECT 
gender, 
ROUND(CAST(COUNT(*) AS FLOAT) / (SELECT COUNT(*) FROM gold.customers) * 100, 2) AS gender_pct
FROM gold.customers
GROUP BY gender
ORDER BY gender_pct DESC;

-- 4. What is the distribution of customers by marital status?
SELECT 
marital_status, 
ROUND(CAST(COUNT(*) AS FLOAT) / (SELECT COUNT(*) FROM gold.customers) * 100, 2) AS marital_status_pct
FROM gold.customers
GROUP BY marital_status
ORDER BY marital_status_pct DESC;

-- 5. What is the distribution of customers by country?
SELECT 
country, 
ROUND(CAST(COUNT(*) AS FLOAT) / (SELECT COUNT(*) FROM gold.customers) * 100, 2) AS country_pct
FROM gold.customers
GROUP BY country
ORDER BY country_pct DESC;

-- 6. What is the average, minimum, and maximum age of customers by country?
SELECT
country,
MIN(DATEDIFF(year, birth_date, CAST(GETDATE() AS DATE))) AS min_age,
AVG(DATEDIFF(year, birth_date, CAST(GETDATE() AS DATE))) AS mean_age,
MAX(DATEDIFF(year, birth_date, CAST(GETDATE() AS DATE))) AS max_age
FROM gold.customers
GROUP BY country ORDER BY mean_age;

-- 7. Which product categories generate the highest total sales?
SELECT  
p.category,
SUM(s.sales_amount) AS total_sales
FROM gold.sales AS s
LEFT JOIN gold.products AS p
ON s.product_key = p.product_key
GROUP BY p.category
ORDER BY total_sales DESC;

-- 8. Which product subcategories generate the highest total sales
SELECT  
p.subcategory,
SUM(s.sales_amount) AS total_sales
FROM gold.sales AS s
LEFT JOIN gold.products AS p
ON s.product_key = p.product_key
GROUP BY p.subcategory
ORDER BY total_sales DESC;

-- 9. Which 10 orders have the highest sales amount?
SELECT TOP 10 *
FROM gold.sales
ORDER BY sales_amount DESC;

-- 10. What is the average order value?
SELECT AVG(price) AS avg_order_value
FROM gold.sales;

-- 11. How have total sales, total customers, and total quantity sold changed year-over-year?
SELECT 
YEAR(order_date) order_year,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(quantity) AS total_quantity
FROM gold.sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date);

-- 12. How many customers were added each year?
SELECT 
order_year,
total_customers - total_customers_prev_year AS customer_count_increase
FROM 
(
SELECT 
    YEAR(order_date) AS order_year,
    COUNT(DISTINCT customer_key) AS total_customers,
    LAG(COUNT(DISTINCT customer_key)) OVER (ORDER BY YEAR(order_date)) AS total_customers_prev_year
FROM gold.sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
)t
WHERE total_customers_prev_year IS NOT NULL

-- 13. What is the running total of sales month over month?
SELECT
mnth,
monthly_sales,
SUM(monthly_sales) OVER(ORDER BY mnth ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) running_total
FROM
(
SELECT
DATETRUNC(MONTH, order_date) AS mnth,
SUM(sales_amount) AS monthly_sales
FROM gold.sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date)
)t;

-- 14. For each product, how does its yearly sales compare to the average sales across all products and to its own 
-- sales in the previous year? Which products are outperforming or underperforming relative to these benchmarks?
SELECT
order_year,
product_name, 
total_sales,
AVG(total_sales) OVER(PARTITION BY product_name) AS avg_sales,
total_sales - AVG(total_sales) OVER(PARTITION BY product_name) AS diff
FROM 
(
SELECT 
YEAR(s.order_date) AS order_year,
p.product_name,
SUM(s.sales_amount) AS total_sales
FROM gold.sales AS s
LEFT JOIN gold.products AS p
ON s.product_key = p.product_key
WHERE s.order_date IS NOT NULL
GROUP BY YEAR(s.order_date), p.product_name
)t;

-- 15. What is the Customer Lifetime Value(CLV)?
SELECT
customer_key,
SUM(sales_amount) AS lifetime_value
FROM gold.sales
GROUP BY customer_key
ORDER BY SUM(sales_amount) DESC;

-- 16. What is the ratio of the repeat vs one-time customers?
SELECT 
CASE WHEN order_count = 1 THEN 'One-time' ELSE 'Repeat' END AS customer_type,
COUNT(*) AS num_customers
FROM (
SELECT customer_key, COUNT(DISTINCT order_number) AS order_count
FROM gold.sales
GROUP BY customer_key
)t
GROUP BY CASE WHEN order_count = 1 THEN 'One-time' ELSE 'Repeat' END;












