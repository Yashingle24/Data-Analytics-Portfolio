-- DATA CLEANING & PREPROCESSING

-- 1. Remove duplicate rows (if any)
DELETE FROM trips_table
WHERE rowid NOT IN (
    SELECT MIN(rowid) 
    FROM trips_table 
    GROUP BY ride_id
);

-- 2. Remove NULL or missing values in essential columns
DELETE FROM trips_table
WHERE ride_id IS NULL 
   OR started_at IS NULL 
   OR ended_at IS NULL 
   OR member_casual IS NULL;

-- 3. Convert date columns to proper timestamp format (if needed)
UPDATE trips_table
SET started_at = STRFTIME('%Y-%m-%d %H:%M:%S', started_at),
    ended_at = STRFTIME('%Y-%m-%d %H:%M:%S', ended_at);

-- 4. Create a new column for ride duration (in minutes)
ALTER TABLE trips_table ADD COLUMN ride_duration INTEGER;

UPDATE trips_table
SET ride_duration = (JULIANDAY(ended_at) - JULIANDAY(started_at)) * 1440;

-- 5. Remove incorrect data (negative or very short ride durations)
DELETE FROM trips_table
WHERE ride_duration <= 0;

-- 6. Standardize user type values (if inconsistent values exist)
UPDATE trips_table
SET member_casual = LOWER(TRIM(member_casual));

-- 7. Remove any outliers in ride duration (optional)
DELETE FROM trips_table
WHERE ride_duration > 1440; -- Removing rides longer than 24 hours

-- Data cleaning completed! The dataset is now ready for analysis.
