/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.
===============================================================================
*/

--calculate the total sales per month
--running total of sales over time 
SELECT
	order_date,
	total_sales,
	SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales
FROM
(
    SELECT 
        DATETRUNC(MONTH, order_date) AS order_date,
        SUM(sales_amount) AS total_sales
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(MONTH, order_date)
) t

-- another way with cte
WITH CUMALTIVE_MONTH AS (
SELECT 
	DATETRUNC(month,order_date)  AS order_year,
	SUM(sales_amount) as total_sales_per_month
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month,order_date)
) 
SELECT 
	order_year,
	total_sales_per_month,
	SUM(total_sales_per_month) OVER(ORDER BY order_year) AS running_total
FROM CUMALTIVE_MONTH



--calculate the total sales per year
--running total of sales over time 
SELECT
	order_date,
	total_sales,
	SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales
FROM
(
    SELECT 
        DATETRUNC(YEAR, order_date) AS order_date,
        SUM(sales_amount) AS total_sales
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(YEAR, order_date)
) t

-- another way with cte
WITH CUMALTIVE_YEAR AS (
SELECT 
	DATETRUNC(YEAR,order_date)  AS order_year,
	SUM(sales_amount) as total_sales_per_month
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR,order_date)
) 
SELECT 
	order_year,
	total_sales_per_month,
	SUM(total_sales_per_month) OVER(ORDER BY order_year) AS running_total
FROM CUMALTIVE_YEAR


