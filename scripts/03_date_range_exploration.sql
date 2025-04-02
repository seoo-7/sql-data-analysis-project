
-- DATE EXPLORATION 

--find the date of the first and last order
--how many years and months of sales are available
SELECT 
	MIN(order_date) AS first_orderdate,
	MAX(order_date) AS last_orderdaet,
	DATEDIFF(YEAR,MIN(order_date),MAX(order_date) ) AS order_range_year,
	DATEDIFF(MONTH,MIN(order_date),MAX(order_date) ) AS order_range_month
FROM gold.fact_sales 

-- find the youngest and oldest customers
SELECT 
	MIN(birthdate) AS oldest_customer ,
	DATEDIFF(YEAR,MIN(birthdate),GETDATE()) AS oldest_customer_age,
	MAX(birthdate) AS youngest_customer,
	DATEDIFF(YEAR,MAX(birthdate),GETDATE()) AS youngest_customer_age
FROM gold.dim_customers