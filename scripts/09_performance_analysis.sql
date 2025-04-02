/*
===============================================================================
Performance Analysis (Year-over-Year, Month-over-Month)
===============================================================================
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.
===============================================================================
*/

/* 
analyze the year performance of products by comparing their sales 
to both the average sales performance of the product and the previous year's sales 
*/
WITH year_product_sales AS (
SELECT 
	year(f.order_date) AS order_year,
	p.product_name,
	sum(f.sales_amount) AS current_sales
FROM gold.fact_sales f 
left join gold.dim_products p 
ON f.product_key = p.product_key
WHERE order_date is not null
GROUP BY 
	year(f.order_date),
	p.product_name
) 
SELECT 
	order_year,
	product_name,
	current_sales,
	AVG(current_sales) OVER(PARTITION  BY product_name) AS avg_sales,
	current_sales - AVG(current_sales) OVER(PARTITION BY product_name) AS diff_avg,
	CASE
		WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name) > 0 THEN 'above avg'
		WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name) < 0 THEN 'below avg'
		ELSE 'avg'
	END AS avg_change , 

-- year over year anlysis
	COALESCE (LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year)  ,0)as prev_sales ,
	COALESCE(current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year),0) as diff_prev_year,
	CASE
		WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) > 0 THEN 'increase'
		WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY order_year) < 0 THEN 'descrease'
		ELSE 'no cahnge'
	END AS prev_year_change
from year_product_sales
order by product_name , order_year  
