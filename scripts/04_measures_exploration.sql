
-- MEASURE EXPLORATION 

-- generate a report that shows all key metric of the bisness 

SELECT 'total_sales' AS MEASURE_NAME ,	SUM(sales_amount) AS MEASURE_VALUE FROM gold.fact_sales 
UNION ALL 
SELECT 'total quantity' , SUM(quantity) FROM gold.fact_sales 
UNION ALL 
SELECT 'avg_price',	AVG(price)  FROM gold.fact_sales
UNION ALL 
SELECT 'total_orders' , COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL 
SELECT 'total_products' , COUNT(product_key)  FROM gold.dim_products
UNION ALL 
SELECT 'total_customer' ,COUNT(customer_key) FROM gold.dim_customers

-- find the total sales 
SELECT 
	SUM(sales_amount) AS total_sales
FROM gold.fact_sales 

-- frind how many items are sold 
SELECT 
	SUM(quantity) AS total_quantity
FROM gold.fact_sales 

-- find the average sellling price 
SELECT 
	AVG(price) AS avg_price
FROM gold.fact_sales

-- find the total number of orders 
SELECT 
	COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales

-- find the total number of products 
SELECT 
	COUNT(product_key)  AS total_products
FROM gold.dim_products

-- find the total number of customers
SELECT 
	 COUNT(customer_key) AS total_customer
FROM gold.dim_customers

-- find the total number of products that has places an order 
SELECT 
	 COUNT(DISTINCT customer_key) AS total_customer
FROM gold.fact_sales

