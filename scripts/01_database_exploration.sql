
-- DATABASE EXPLORATION : 

--explore all object in database: 
SELECT * FROM INFORMATION_SCHEMA.TABLES

--explore all columns in the db :
SELECT * 
FROM INFORMATION_SCHEMA.COLUMNS

--explore columns for every table in db :
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers'

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_products'

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_products'

SELECT * 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'fact_sales'



