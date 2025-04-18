SELECT * FROM orders


-- Business Questions
-- 1. **Find top 10 highest revenue-generating products.**

SELECT 
	product_id,
	SUM(sale_price)::DECIMAL(10,2) AS sales
FROM orders
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10

-- 2. **Find top 5 highest selling products in each region.**

SELECT *
FROM
	(
		SELECT 	
			region,
			product_id,
			SUM(sale_price) AS sales,
			RANK() OVER(PARTITION BY region ORDER BY SUM(sale_price) DESC) as rnk
		FROM orders 
		GROUP BY 1,2
	)
WHERE rnk <=5


-- 3. **Find month-over-month sales growth comparison for 2022 and 2023 (e.g., Jan 2022 vs Jan 2023).**

WITH cte AS (
	SELECT 
		EXTRACT(YEAR FROM order_date) AS order_year,
		EXTRACT(MONTH FROM order_date) AS order_month_num,
		TO_CHAR(order_date, 'Mon') AS order_month,
		SUM(sale_price) AS sales
	FROM orders
	GROUP BY 1, 2, 3
)

SELECT 
	order_month,
	SUM(CASE WHEN order_year = 2022 THEN sales ELSE 0 END)::DECIMAL(10,2) AS sales_2022,
	SUM(CASE WHEN order_year = 2023 THEN sales ELSE 0 END)::DECIMAL(10,2) AS sales_2023
FROM cte
GROUP BY order_month, order_month_num
ORDER BY order_month_num;


-- 4. **For each category, determine which month had the highest sales.**

WITH cte AS
(
	SELECT 
	  category,
	  TO_CHAR(order_date, 'YYYY-Mon') AS order_year_month,
	  SUM(sale_price)::DECIMAL(10,2) AS sales,
	  ROW_NUMBER() OVER(PARTITION BY category ORDER BY SUM(sale_price) DESC) AS rn
	FROM orders
	GROUP BY 1, 2
)
SELECT 
	category,
	order_year_month,
	sales
FROM cte
WHERE rn = 1


-- 5. **Which sub-category had the highest growth in profit in 2023 compared to 2022?**


SELECT * FROM orders

WITH cte AS (
  SELECT 
    sub_category,
    EXTRACT(YEAR FROM order_date) AS order_year,
    SUM(sale_price) AS sales
  FROM orders
  GROUP BY sub_category, EXTRACT(YEAR FROM order_date)
),
cte2 AS (
  SELECT 
    sub_category,
    SUM(CASE WHEN order_year = 2022 THEN sales ELSE 0 END)::DECIMAL(10,2) AS sales_2022,
    SUM(CASE WHEN order_year = 2023 THEN sales ELSE 0 END)::DECIMAL(10,2) AS sales_2023
  FROM cte
  GROUP BY sub_category
)
SELECT 
  *,
  (sales_2023 - sales_2022)::DECIMAL(10,2) AS sales_growth
FROM cte2
ORDER BY sales_growth DESC
LIMIT 1;



