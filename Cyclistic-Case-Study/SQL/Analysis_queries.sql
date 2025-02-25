-- DATA ANALYSIS QUERIES

-- 1. Ride Volume: Members vs. Casual Riders
SELECT 
    member_casual, 
    COUNT(*) AS total_rides,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM trips_table), 2) AS percentage
FROM trips_table
GROUP BY member_casual;

-- 2. Average Trip Duration by User Type
SELECT 
    member_casual, 
    ROUND(AVG(ride_duration), 2) AS avg_ride_duration
FROM trips_table
GROUP BY member_casual;

-- 3. Ride Frequency by Day of the Week
SELECT 
    STRFTIME('%w', started_at) AS day_of_week,
    member_casual,
    COUNT(*) AS ride_count
FROM trips_table
GROUP BY day_of_week, member_casual
ORDER BY day_of_week, member_casual;

-- 4. Ride Frequency by Hour of the Day
SELECT 
    STRFTIME('%H', started_at) AS hour_of_day,
    member_casual,
    COUNT(*) AS ride_count
FROM trips_table
GROUP BY hour_of_day, member_casual
ORDER BY hour_of_day, member_casual;

-- 5. Ride Trends by Month
SELECT 
    STRFTIME('%m', started_at) AS month,
    member_casual,
    COUNT(*) AS ride_count
FROM trips_table
GROUP BY month, member_casual
ORDER BY month, member_casual;

-- 6. Bike Type Preferences
SELECT 
    rideable_type,
    member_casual,
    COUNT(*) AS ride_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM trips_table WHERE member_casual = t.member_casual), 2) AS percentage
FROM trips_table t
GROUP BY rideable_type, member_casual
ORDER BY member_casual, ride_count DESC;

-- 7. Docked vs. Dockless Rides
SELECT 
    CASE 
        WHEN start_station_name IS NULL THEN 'Dockless' 
        ELSE 'Docked' 
    END AS ride_type,
    COUNT(*) AS ride_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM trips_table), 2) AS percentage
FROM trips_table
GROUP BY ride_type
ORDER BY ride_count DESC;

-- 8. Peak Start Stations (Top 10 most used start stations)
SELECT 
    start_station_name, 
    COUNT(*) AS ride_count
FROM trips_table
WHERE start_station_name IS NOT NULL
GROUP BY start_station_name
ORDER BY ride_count DESC
LIMIT 10;

-- 9. Peak End Stations (Top 10 most used end stations)
SELECT 
    end_station_name, 
    COUNT(*) AS ride_count
FROM trips_table
WHERE end_station_name IS NOT NULL
GROUP BY end_station_name
ORDER BY ride_count DESC
LIMIT 10;

-- Analysis completed! These insights can help Cyclistic optimize bike availability and convert casual riders into members.
