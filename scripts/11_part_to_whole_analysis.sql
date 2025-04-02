/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - To compare performance or metrics across dimensions or time periods.
    - To evaluate differences between categories.
    - Useful for A/B testing or regional comparisons.
===============================================================================
*/

-- which category contributed the most overall sales?
WITH category_product AS (
SELECT 	
	category,
	SUM(sales_amount)  AS totalsales
FROM gold.dim_products p 
RIGHT JOIN  gold.fact_sales s
ON s.product_key = p.product_key
GROUP BY category ) 

SELECT
	category,
	totalsales,
	SUM(totalsales) OVER() AS overall_sales , 
	CONCAT(ROUND((CAST(totalsales AS FLOAT ) / SUM(totalsales) OVER()) * 100 ,2),'%')AS percentage
FROM category_product ;

------------------------------------
--which category contributed the most overall order
WITH order_product AS (
SELECT 	
	category,
	COUNT(order_number)  AS totalorder
FROM gold.dim_products p 
RIGHT JOIN  gold.fact_sales s
ON s.product_key = p.product_key
GROUP BY category ) 

SELECT
	category,
	totalorder,
	SUM(totalorder) OVER() AS overall_order , 
	CONCAT(ROUND((CAST(totalorder AS FLOAT ) / SUM(totalorder) OVER())*100 ,2),'%')AS percentage
FROM order_product ;
---------------------------------------------------------
