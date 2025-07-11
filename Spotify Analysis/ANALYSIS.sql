-- Advance SQL Project  -- Spotify Dataset

-- create table
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

-- EDA
SELECT COUNT(*) FROM spotify 

SELECT COUNT(DISTINCT album) FROM spotify	

SELECT MIN(duration_min)
FROM spotify

SELECT * FROM spotify
WHERE duration_min = 0

DELETE FROM spotify
WHERE duration_min = 0

--check
SELECT * FROM spotify
WHERE duration_min = 0


-- 15 Practice Questions
-- Very Easy Level
-- 1. Retrieve the names of all tracks that have more than 1 billion streams.

SELECT *  FROM spotify
WHERE stream >= 1000000000;

-- 2. List all albums along with their respective artists.

SELECT DISTINCT album , artist
FROM spotify
ORDER BY 1;

-- 3. Get the total number of comments for tracks where licensed = TRUE.

SELECT SUM(comments) AS total_comments
FROM spotify
WHERE licensed = true;

-- 4. Find all tracks that belong to the album type single.

SELECT *
FROM spotify
WHERE album_type = 'single';

-- 5. Count the total number of tracks by each artist.

SELECT artist, COUNT(track) AS total_tracks
FROM spotify
GROUP BY 1;



-- Medium Level


-- Write a query to find tracks where the liveness score is above the average.

SELECT * 
FROM spotify
WHERE liveness >	(
					SELECT AVG(liveness) AS average_liveness 
					FROM spotify
					)

-- Calculate the average danceability of tracks in each album.

SELECT album, AVG(danceability):: DECIMAL (10, 2) AS average_danceability
FROM spotify
GROUP BY 1
ORDER BY 2 DESC;

-- Find the top 5 tracks with the highest energy values.

SELECT track, MAX(energy) 
FROM spotify
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5


-- List all tracks along with their views and likes having official video.

SELECT track AS tracks_having_official_video, 
	   SUM(views) AS total_views,
	   SUM(likes) AS total_likes
FROM spotify
WHERE official_video = true
GROUP BY 1
ORDER BY 2 DESC

-- For each album, calculate the total views of all associated tracks.

SELECT album, track, SUM(views) AS total_views
FROM spotify
GROUP BY 1,2
ORDER BY 3 DESC

-- Retrieve the track names that have been streamed on Spotify more than YouTube.

SELECT * 
FROM (
		SELECT track ,
					COALESCE(SUM(CASE WHEN most_played_on = 'Youtube' THEN stream END), 0) AS streamed_on_youtube,
					COALESCE(SUM(CASE WHEN most_played_on = 'Spotify' THEN stream END), 0) AS streamed_on_spotify
		FROM spotify
		GROUP BY 1
) AS t1
WHERE streamed_on_spotify > streamed_on_youtube
	  AND 
	  streamed_on_youtube <> 0


-- Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.

SELECT track, 
       SUM(likes) OVER (PARTITION BY track ORDER BY views) AS cumulative_likes
FROM spotify; 


-- Somewhat Advance Level
-- Find the top 3 most-viewed tracks for each artist using window functions.

WITH cte AS (
SELECT artist, track,
		SUM(VIEWS) AS total_views,
		DENSE_RANK() OVER(PARTITION BY artist ORDER BY SUM(VIEWS) DESC ) AS ranking
FROM spotify
GROUP BY 1,2
ORDER BY 1,3 DESC
)
SELECT * FROM CTE
WHERE ranking <= 3
ORDER BY artist, ranking

--OR

SELECT *
FROM (SELECT artist, track,
		SUM(VIEWS) AS total_views,
		DENSE_RANK() OVER(PARTITION BY artist ORDER BY SUM(VIEWS) DESC ) AS ranking
FROM spotify
GROUP BY 1,2
ORDER BY 1,3 DESC)
WHERE ranking <= 3
ORDER BY 1, 3 DESC


-- Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.

-- Since we're specifically asked to solve using WITH clause :

WITH CTE AS (
SELECT album, MAX(energy) AS highest_energy, MIN(energy) AS lowest_energy
FROM spotify 
GROUP BY 1
)
SELECT album, highest_energy - lowest_energy AS energy_diff
FROM CTE 
ORDER BY 2 DESC


--Otherwise the easy method


SELECT album, MAX(energy) - MIN(energy) AS energy_diff
FROM spotify
GROUP BY album
ORDER BY 2 DESC


-- Find tracks where the energy-to-liveness ratio is greater than 1.2.

-- Two approaches are provided below to answer the question: "Find tracks where the energy-to-liveness ratio is greater than 1.2."
-- These approaches were chosen based on how we handle tracks with multiple entries (e.g., different artists or versions with varying views and likes).
-- The choice of approach depends on whether we want to treat tracks as unique versions (with their individual view/like data) or as a single track regardless of artist/version.

-- Approach 1 (Query 1):

-- Query to find tracks where the energy-to-liveness ratio is greater than 1.2
-- This query considers each row (even with different artists or view counts) separately.
-- Each row of a track is treated as an individual entry and filtered if the ratio is greater than 1.2.

SELECT * 
FROM spotify
WHERE (energy / liveness) > 1.2
ORDER BY track, (energy / liveness) DESC;

-- AND

-- Approach 2 (Query 2):

-- Query to find tracks where the aggregated energy-to-liveness ratio is greater than 1.2
-- This query aggregates energy and liveness for each track, treating all rows of the same track as one entry.
-- It sums the energy and liveness values for all versions of the track (e.g., different artists or view counts).
-- The ratio is then calculated and filtered for tracks where the ratio exceeds 1.2.

SELECT track, (SUM(energy) / SUM(liveness)) AS ratio
FROM spotify
GROUP BY track
HAVING (SUM(energy) / SUM(liveness)) > 1.2
ORDER BY ratio DESC;


-----------------------------------------------------------------------------------------------------






