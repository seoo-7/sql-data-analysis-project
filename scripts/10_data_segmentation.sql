/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis.
===============================================================================
*/


/* 
group customer into three segments based on their spending behavior : 

	-VIP : customer with at least 12 months of history and spending more than 5000 .
	-Regular : customer with at least 12 months of history but spending 5000 or less .
	-New : customer with a lifepan less then 12 months 
and find the total number of customer by each group
*/
WITH  customer_segment AS (
SELECT 
	c.customer_key,
	SUM(sales_amount) AS total_spending,
	MIN(order_date) AS first_order,
	MAX(order_date) AS last_order,
	DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) AS lifespan
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c
ON s.customer_key = c.customer_key
GROUP BY c.customer_key )

SELECT 
	customer_segments,
	COUNT(customer_key) as total_customer
FROM (
SELECT 
	customer_key,
	total_spending,
	lifespan,
	CASE 
		WHEN lifespan > 12 AND total_spending > 5000 THEN 'Vip'
		WHEN lifespan > 12 AND total_spending <= 5000 THEN 'Regular'
		ELSE 'New'
	END customer_segments 
FROM customer_segment
) t
GROUP BY customer_segments
ORDER BY total_customer DESC;


/*segement product into cost range
and count how many product fall into each segment */ 
WITH product_segments AS (
SELECT 
	product_key,
	product_name,
	cost,
	CASE 
		WHEN cost < 100 THEN 'below 100'
		WHEN cost BETWEEN 100 AND 500 THEN '100-500'
		WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
		ELSE 'above 1000' 
	END cost_range
FROM gold.dim_products  ) 

SELECT 
	cost_range,
	COUNT(product_key) AS total_products
FROM product_segments
GROUP BY cost_range 
ORDER BY total_products DESC;
