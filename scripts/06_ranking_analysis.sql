
--RANKING 

-- find the top 10 customers who have generate the highest revenue
SELECT	TOP 10
	C.customer_key,
	CONCAT(C.first_name ,' ',C.last_name) AS full_name,
	SUM(F.sales_amount) AS total_revenue,
	COUNT(DISTINCT f.order_number ) AS total_order
FROM gold.fact_sales F 
LEFT JOIN gold.dim_customers C
ON F.customer_key = C.customer_key
GROUP BY 
	C.customer_key,
	CONCAT(C.first_name ,' ',C.last_name)	
ORDER BY total_revenue DESC 

--which the 5 products generate the highest revenue

SELECT *
FROM (
	SELECT 
		P.product_name,
		SUM(F.sales_amount) AS total_revenue,
		ROW_NUMBER() OVER(ORDER BY SUM(F.sales_amount) DESC ) AS rank_product
	FROM gold.fact_sales F
	LEFT JOIN gold.dim_products P
	ON F.product_key = P.product_key
	GROUP BY product_name ) Q
WHERE rank_product <= 5

-- OR 
SELECT TOP 5 
	P.product_name,
	SUM(F.sales_amount) AS total_revenue
FROM gold.fact_sales F
LEFT JOIN gold.dim_products P
ON F.product_key = P.product_key
GROUP BY product_name
ORDER BY total_revenue DESC

-- find are the 5 worest-performing products in term of sales 
SELECT *
FROM (
	SELECT 
		P.product_name,
		SUM(F.sales_amount) AS total_revenue,
		ROW_NUMBER() OVER(ORDER BY SUM(F.sales_amount)  ) AS rank_product
	FROM gold.fact_sales F
	LEFT JOIN gold.dim_products P
	ON F.product_key = P.product_key
	GROUP BY product_name ) Q
WHERE rank_product <= 5

-- OR
SELECT TOP 5 
	P.product_name,
	SUM(F.sales_amount) AS total_revenue
FROM gold.fact_sales F
LEFT JOIN gold.dim_products P
ON F.product_key = P.product_key
GROUP BY product_name
ORDER BY total_revenue ASC
	

--which the 5 subcategory generate the highest revenue
SELECT *
FROM (
	SELECT 
	    P.subcategory,
		SUM(F.sales_amount) AS total_revenue,
		ROW_NUMBER() OVER(ORDER BY SUM(F.sales_amount) DESC ) AS rank_product
	FROM gold.fact_sales F
	LEFT JOIN gold.dim_products P
	ON F.product_key = P.product_key
	GROUP BY subcategory ) Q
WHERE rank_product <= 5 

-- OR 
SELECT TOP 5 
	P.subcategory,
	SUM(F.sales_amount) AS total_revenue
FROM gold.fact_sales F
LEFT JOIN gold.dim_products P
ON F.product_key = P.product_key
GROUP BY subcategory
ORDER BY total_revenue DESC


-- find are the 5 worest-performing subcategory in term of sales 
SELECT *
FROM (
	SELECT 
	    P.subcategory,
		SUM(F.sales_amount) AS total_revenue,
		ROW_NUMBER() OVER(ORDER BY SUM(F.sales_amount) ASC ) AS rank_product
	FROM gold.fact_sales F
	LEFT JOIN gold.dim_products P
	ON F.product_key = P.product_key
	GROUP BY subcategory ) Q
WHERE rank_product <= 5 

-- OR 
SELECT TOP 5 
	P.subcategory,
	SUM(F.sales_amount) AS total_revenue
FROM gold.fact_sales F
LEFT JOIN gold.dim_products P
ON F.product_key = P.product_key
GROUP BY subcategory
ORDER BY total_revenue ASC
	