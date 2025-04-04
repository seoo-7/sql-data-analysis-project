
--MAGNITUDE ANALYSIS 

-- find the total customer by countries 

SELECT 
	country,
	COUNT(DISTINCT customer_id) AS total_customers
FROM gold.dim_customers
GROUP BY country
ORDER BY total_customers DESC

-- find the total customer by gender 
SELECT 
	gender,
	COUNT(DISTINCT customer_id) AS total_customers
FROM gold.dim_customers
GROUP BY gender
ORDER BY total_customers DESC

-- find the total product by category 

SELECT 
	category ,
	COUNT(product_id) AS total_product
FROM gold.dim_products
GROUP BY category
ORDER BY total_product DESC

-- what is the average cost for each category ?

SELECT 
	category,
	AVG(cost) AS average_cost
FROM gold.dim_products
GROUP BY category
ORDER BY average_cost DESC

-- what is the total revenue generated for each category 
SELECT	 
	P.category,
	SUM(F.sales_amount) AS total_revenue
FROM gold.fact_sales F 
LEFT JOIN gold.dim_products P
ON F.product_key = P.product_key
GROUP BY category
ORDER BY total_revenue DESC

-- find the total revenue generated by customer 
SELECT	 
	C.customer_key,
	CONCAT(C.first_name ,' ',C.last_name) AS full_name,
	SUM(F.sales_amount) AS total_revenue
FROM gold.fact_sales F 
LEFT JOIN gold.dim_customers C
ON F.customer_key = C.customer_key
GROUP BY 
	C.customer_key,
	CONCAT(C.first_name ,' ',C.last_name)
ORDER BY total_revenue DESC 

-- what is the distribution of sold a cross countries ?

SELECT 
	C.country,
	SUM(F.quantity) AS total_sold_item
FROM gold.fact_sales F 
LEFT JOIN gold.dim_customers C
ON F.customer_key = C.customer_key
GROUP BY country
ORDER BY total_sold_item DESC