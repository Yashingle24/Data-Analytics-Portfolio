SELECT *
FROM walmart

---
SELECT payment_method, COUNT(*)
FROM walmart
GROUP BY 1

-- Business Problems
--Q.1 Find different payment method and number of transactions, number of qty sold

SELECT 
	payment_method,
	COUNT(*) AS total_payments,
	SUM(quantity) AS num_of_qty_sold
FROM walmart
GROUP BY 1

-- Q2 Identify the highest-rated category in each branch, displaying the branch, category
-- AVG RATING

SELECT 
	branch,
	category,
	avg_rating
FROM 
		( SELECT 
			branch,
			category,
			AVG(rating) AS avg_rating,
			RANK() OVER(PARTITION BY branch ORDER BY AVG(rating) DESC) AS rnk
		FROM walmart
		GROUP BY 1,2
		)
WHERE rnk = 1

-- Q.3 Identify the busiest day for each branch based on the number of transactions

SELECT
	branch,
	day_name,
	num_of_trans
FROM 
	(	SELECT 
			branch,
			TO_CHAR(TO_DATE(date, 'DD/MM/YY'), 'Day') AS day_name,
			COUNT(*) AS num_of_trans,
			RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) AS rnk
		FROM walmart
		GROUP BY 1, 2
	)
WHERE rnk = 1
	

- Q. 4 
-- Calculate the total quantity of items sold per payment method. List payment_method and total_quantity.

SELECT 
	payment_method,
	SUM(quantity) AS num_of_qty_sold
FROM walmart
GROUP BY 1

-- Q.5
-- Determine the average, minimum, and maximum rating of category for each city. 
-- List the city, average_rating, min_rating, and max_rating.

SELECT 
	city,
	category,
	AVG(rating):: DECIMAL(4,2) AS avg_rating,
	MIN(rating) AS minimum_rating,
	MAX(rating) AS maximum_rating
FROM walmart
GROUP BY 1,2

-- Q.6 Calculate the total profit for each category by considering total_profit as 
-- (unit_price * quantity * profit_margin). 
-- List category and total_profit, ordered from highest to lowest profit.

SELECT 
	category,
	SUM(total) AS total_revenue,
	SUM(profit_margin) AS profit
FROM walmart
GROUP BY 1

-- Q.7 Determine the most common payment method for each Branch. 
-- Display Branch and the preferred_payment_method.

SELECT
	branch,
	payment_method,
	total_trans
FROM
	(	SELECT 
			branch,
			payment_method,
			COUNT(*) AS total_trans,
			RANK()  OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) AS rnk 
		FROM walmart
		GROUP BY 1,2
	)
WHERE rnk = 1


-- Q.8 Categorize sales into 3 group MORNING, AFTERNOON, EVENING 
-- Find out each of the shift and number of invoices


SELECT 
	branch,
CASE 
	WHEN EXTRACT(HOUR FROM(time::time)) < 12 THEN 'Morning'
	WHEN EXTRACT(HOUR FROM(time::time)) BETWEEN 12 AND 17 THEN 'Afternoon'
	ELSE 'Evening' 
END day_time,
	COUNT(*) AS num_of_invoices
FROM walmart
GROUP BY 1, 2
ORDER BY 1, 3 DESC



-- #9 Identify 5 branch with highest decrese ratio in 
-- revevenue compare to last year(current year 2023 and last year 2022)
-- rdr == last_rev-cr_rev/ls_rev*100


WITH revenue_2022 AS 
(
	SELECT 
		branch,
		SUM(total) AS revenue
	FROM walmart
	WHERE EXTRACT(YEAR FROM(TO_DATE(date, 'DD/MM/YY'))) =2022
	GROUP BY 1
), 

revenue_2023 AS
(
	SELECT 
		branch,
		SUM(total) AS revenue
	FROM walmart
	WHERE EXTRACT(YEAR FROM(TO_DATE(date, 'DD/MM/YY'))) =2023
	GROUP BY 1
)

SELECT 
	ls.branch,
	ls.revenue AS last_year_revenue,
	cs.revenue AS cr_year_revenue,
	ROUND(
	(ls.revenue - cs.revenue)::numeric/
	ls.revenue::numeric * 100
	,2) AS rev_dec_ratio
FROM 
	revenue_2022 AS ls
JOIN
	revenue_2023 AS cs
ON 
	ls.branch = cs.branch
WHERE 
	ls.revenue > cs.revenue
ORDER BY 4 DESC
LIMIT 5


-- For each category, find the day of the week with the highest average revenue per invoice,
-- and show the category, day, average revenue, and number of invoices that day.



SELECT 
    category,
    day_of_week,
    avg_revenue_per_invoice,
    num_invoices
FROM (
    SELECT 
        category,
        TO_CHAR(TO_DATE(date, 'DD/MM/YY'), 'Day') AS day_of_week,
        (SUM(total) / COUNT(*))::decimal(5,2) AS avg_revenue_per_invoice,
        COUNT(*) AS num_invoices,
        RANK() OVER(PARTITION BY category ORDER BY SUM(total) / COUNT(*) DESC) AS rnk
    FROM walmart
    GROUP BY category, day_of_week
) sub
WHERE rnk = 1
ORDER BY avg_revenue_per_invoice DESC;












