/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
	   - total orders
	   - total sales
	   - total quantity purchased
	   - total products
	   - lifespan (in months)
    4. Calculates valuable KPIs:
	    - recency (months since last order)
		- average order value
		- average monthly spend
===============================================================================
*/
CREATE VIEW gold.report_customer AS 
WITH base_query AS (
--1)BASE QUERY : retreive core column from tables 
SELECT 
	s.order_number,
	s.product_key,
	s.order_date,
	s.sales_amount,
	s.quantity,
	c.customer_key,
	c.customer_number,
	CONCAT(c.first_name,' ' , c.last_name) AS custmers_names,
	DATEDIFF(year,c.birthdate,GETDATE()) AS age 
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers  c
ON s.customer_key = c.customer_key
WHERE order_date IS NOT NULL)

,customer_aggregation AS (
-- 2) customer aggergation : summarize key metrics at the customer level
SELECT 
	customer_key,
	customer_number,
	custmers_names,
	age,
	COUNT(DISTINCT order_number) AS total_order,
	SUM(sales_amount) AS total_sales,
	SUM(quantity) AS total_quantity,
	COUNT(product_key) AS total_product,
	MIN(order_date) AS first_order ,
	MAX(order_date) AS last_order,
	DATEDIFF(month,MIN(order_date),MAX(order_date) ) AS lifespan
FROM base_query
GROUP BY customer_key,
	customer_number,
	custmers_names,
	age ) 

SELECT 
	customer_key,
	customer_number,
	custmers_names,
	age,
	CASE 
		WHEN age < 20 THEN 'under 20'
		WHEN age BETWEEN 20 AND 29 THEN '20-29'
		WHEN age BETWEEN 30 AND 39 THEN '30-39'
		WHEN age BETWEEN 40 AND 49 THEN '40-49'
		ELSE 'above 50'
	END age_group ,
	CASE 
		WHEN lifespan > 12 AND total_sales > 5000 THEN 'Vip'
		WHEN lifespan > 12 AND total_sales <= 5000 THEN 'Regular'
		ELSE 'New'
	END customer_segment,
	first_order,
	last_order ,
	DATEDIFF(month,last_order,GETDATE()) AS recency,
	lifespan,
	total_order,
	total_product,
	total_quantity,
	total_sales,
	--compute average order value (AVO) 
	CASE 
		WHEN total_sales = 0 THEN 0
		ELSE total_sales / total_order 
	END AS avg_order_value ,
	-- compute average monthly spend
	CASE 
		WHEN lifespan = 0 THEN total_sales
		ELSE total_sales / lifespan 
	END AS avg_month_spend 
FROM customer_aggregation
