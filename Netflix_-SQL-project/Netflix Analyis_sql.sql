DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
	show_id	VARCHAR(6),
	type VARCHAR(10),
	title VARCHAR(150),
	director VARCHAR(208),
	casts VARCHAR(1000),
	country VARCHAR(150),
	date_added VARCHAR(50),
	release_year INT,
	rating VARCHAR(10),	
	duration VARCHAR(15),
	listed_in VARCHAR(100),
	description VARCHAR(250)
)

select * from netflix
select count(*) from netflix

-- 15 Business Problems & Solutions

-- 1. Count the number of Movies vs TV Shows

SELECT type, COUNT(*) as num_of_content
FROM netflix
GROUP BY type

-- 2. Find the most common rating for movies and TV shows

-- just for clarification, MAX can't be used here as rating is not numerical in this case

SELECT type, rating
FROM 
(
SELECT type, rating, 
		COUNT(*),
		RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) AS ranking
FROM netflix
GROUP BY 1, 2
) AS T1
WHERE ranking = 1


-- 3. List all movies released in a specific year (e.g., 2020 or any)

SELECT * 
FROM netflix
WHERE 
	 type = 'Movie'
	 AND
	 release_year = 2019

-- 4. Find the top 5 countries with the most content on Netflix

SELECT DISTINCT TRIM(UNNEST(STRING_TO_ARRAY(country, ','))) AS new_country, count(show_id) as total_content
FROM netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- 5. Identify the longest movie

SELECT  * 
FROM 
(SELECT DISTINCT title as Movie,
		split_part(duration, ' ', 1):: numeric as duration
		FROM netflix
		WHERE type = 'Movie' )
WHERE duration = (SELECT MAX(split_part(duration, ' ', 1):: numeric) FROM netflix)

-- 6. Find content added in the last 5 years

SELECT *
FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 Years'


-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

SELECT *
FROM netflix
WHERE
	 director ILIKE '%Rajiv Chilaka%'

-- 8. List all TV shows with more than 5 seasons

SELECT *
FROM netflix
WHERE 
	 type = 'TV Show'
	 AND
	 SPLIT_PART(duration, ' ', 1):: numeric > 5
	 
-- 9. Count the number of content items in each genre

SELECT TRIM(UNNEST(STRING_TO_ARRAY(listed_in, ','))) as genre, COUNT(show_id) as num_of_content
FROM netflix
GROUP BY 1
ORDER BY 1 DESC

-- 10. Find each year and the average number of content added from India on netflix. 

SELECT  
    EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) AS year_added,
    COUNT(show_id) AS total_content,
    COUNT(show_id) / (SELECT COUNT(DISTINCT EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY'))) 
                      FROM netflix 
                      WHERE country ILIKE '%India%') AS avg_content
FROM netflix
WHERE country ILIKE '%India%'
GROUP BY year_added
ORDER BY year_added DESC;


-- return top 5 year with highest avg content release!

SELECT  release_year, COUNT(show_id) AS total_content,
			ROUND(
				COUNT(show_id):: numeric/ (SELECT COUNT(DISTINCT release_year) FROM netflix)::numeric, 2)
			AS avg_content
FROM netflix 
GROUP BY 1
ORDER BY 3 DESC
LIMIT 5

-- And top 5 year with highes content 'added' on Netflix

SELECT	
	EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) as year_added,
	COUNT(show_id) AS total_content,
	ROUND(
 	COUNT(show_id):: numeric/ (SELECT COUNT( DISTINCT EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY'))) FROM netflix)::numeric
	, 2)
			AS avg_content
FROM netflix
WHERE date_added is not null
GROUP BY 1
ORDER BY 3 DESC
LIMIT 5


-- 11. List all the content that is a documentary

SELECT *
FROM netflix
WHERE  
		listed_in ilike '%Documentaries%'
		
-- 12. Find all content without a director

SELECT * 
FROM netflix 
WHERE director IS NULL 


-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

SELECT * 
FROM netflix
WHERE casts ILIKE '%salman khan%'
	   AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) -10

-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

SELECT 
	 TRIM(UNNEST(STRING_TO_ARRAY(casts, ','))) AS actors, 
	 COUNT(show_id) AS total_appearance
FROM netflix
WHERE country LIKE '%India%'
GROUP BY actors
ORDER BY 2 DESC
LIMIT 10


-- 15.
-- Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
-- the description field. Label content containing these keywords as 'Bad' and all other 
-- content as 'Good'. Count how many items fall into each category.


SELECT CASE 
       WHEN description ILIKE '%kill%'
	   or 
	   description ILIKE '%voilence%' THEN 'Bad'
	   ELSE 'Good'
	   END AS Category,
	   COUNT(show_id) AS total_content
FROM netflix
GROUP BY 1

--OR

WITH t AS (
SELECT CASE 
       WHEN description ILIKE '%kill%'
	   OR 
	   description ILIKE '%voilence%' THEN 'Bad'
	   ELSE 'Good'
	   END AS Category
FROM netflix
)
SELECT Category, 
		COUNT(*)
FROM t
GROUP BY 1



-- 3 additional problems
--1. Find the average duration of movies and TV shows by genre.

-- since durartion for movie is calculated in min and for TV shows it is calculated in 'seasons'
-- AVG duration for both is calculated separetely below  ;

-- for movie

SELECT TRIM(UNNEST(STRING_TO_ARRAY(listed_in, ','))),
       CONCAT(round(AVG(split_part(duration, ' ', 1):: numeric), 2), ' ', 'min')
FROM netflix
WHERE type = 'Movie'
GROUP BY 1

-- for tv show

SELECT TRIM(UNNEST(string_to_array(listed_in, ','))),
       CONCAT(round(AVG(split_part(duration, ' ', 1):: numeric), 2), ' ', 'seasons')

FROM netflix
WHERE type = 'TV Show'
GROUP BY 1

-- 2. Find the top 5 directors who have directed the most content in India.

SELECT director, COUNT(show_id) as total_content
FROM netflix
WHERE country ILIKE '%India%' AND director IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- 3. find the longest-running TV shows in each genre.
-- Let's say top 10 by seasons


SELECT TRIM(UNNEST(STRING_TO_ARRAY(listed_in, ','))) as genre,
		title as TV_show_name,
		CONCAT(round(MAX(split_part(duration, ' ', 1):: numeric), 2), ' ', 'seasons')
FROM netflix
WHERE type = 'TV Show'
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 10
---------------------------------------------------------------------------------------------------



