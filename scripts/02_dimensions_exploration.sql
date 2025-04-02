
-- DIMENSION EXPLORATION 

--explore all countries our customers come from 
SELECT 
	DISTINCT country
FROM gold.dim_customers

-- explore all categories 
SELECT 
	DISTINCT category, -- you have 3 category
	subcategory,       -- you have 36 subcategory
	product_name	   -- you have 295 product
FROM gold.dim_products