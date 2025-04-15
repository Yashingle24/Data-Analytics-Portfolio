
SELECT * FROM bookings

 -- !!! CHECK THE BOTTOM OF THIS PAGE FOR ONE-LINE QUERIES FOR DIRECT ANSWERS TO EACH QUESTION !!!

 

-- 10 BUSINESS QUESTIONS
--1. Retrieve all successful bookings:

CREATE VIEW successfull_bookings AS
SELECT *
FROM bookings 
WHERE booking_status ILIKE '%Success%'; -- even tho the data is cleaned, using ILIKE is always a better option is cases such


--  2. Find the average ride distance for each vehicle type:

CREATE VIEW vehicle_avg_distance AS 
SELECT vehicle_type, ROUND(AVG(ride_distance), 2) as average_ride_distance
FROM bookings
GROUP BY 1;


--  3. Get the total number of cancelled rides by customers:

CREATE VIEW cancelled_rides_by_cust AS 
SELECT COUNT(*)
FROM bookings 
WHERE booking_status ILIKE '%Canceled by customer%';


--  4. List the top 5 customers who booked the highest number of rides:

CREATE VIEW top_5_cust AS
SELECT customer_id, COUNT(8) AS Total_rides
FROM bookings
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


--  5. Get the number of rides cancelled by drivers due to personal and car-related issues:

CREATE VIEW rdes_canceled_by_driver_P_C_issues
AS
SELECT COUNT(*) AS total_rides
FROM bookings
WHERE canceled_rides_by_driver = 'Personal & Car related issue';


--  6. Find the maximum and minimum driver ratings for Prime Sedan bookings:

CREATE VIEW max_min_rating_for_prime_sedan AS 

SELECT vehicle_type, MAX(driver_ratings) AS max_rating, MIN(driver_ratings) AS min_rating
FROM bookings
WHERE vehicle_type = 'Prime Sedan'
GROUP BY 1;


--  7. Retrieve all rides where payment was made using UPI:

CREATE VIEW upi_payment AS 

SELECT * 
FROM bookings
WHERE payment_method = 'UPI';


--  8. Find the average customer rating per vehicle type:

CREATE VIEW avg_cust_rating_by_vehicle AS 

SELECT vehicle_type, ROUND(AVG(customer_rating), 2) AS average_cust_rating
FROM bookings
GROUP BY 1;


--  9. Calculate the total booking value of rides completed successfully:

CREATE VIEW successful_rides_booking_value AS 

SELECT SUM(booking_value) AS total_booking_value
FROM bookings
WHERE booking_status = 'Success';

--  10. List all incomplete rides along with the reason:

CREATE VIEW incomplete_rides_reason AS 

SELECT booking_id, incomplete_rides_reason
FROM bookings
WHERE incomplete_rides = 'Yes';



-- 5  Additional questions with higher difficulty level

-- 1. Find the average ride distance for completed rides, grouped by booking status (including both successful and canceled rides).

CREATE VIEW avg_distance_by_status AS
SELECT 
    booking_status, 
    ROUND(AVG(ride_distance), 2) AS avg_ride_distance
FROM bookings
GROUP BY booking_status;

-- 2. Retrieve the customer who has made the highest number of bookings for each vehicle type.


CREATE VIEW top_customer_by_vehicle_type AS
WITH ranked_customers AS (
    SELECT 
        vehicle_type,
        customer_id,
        COUNT(*) AS total_bookings,
        RANK() OVER (PARTITION BY vehicle_type ORDER BY COUNT(*) DESC) AS rank
    FROM bookings
    GROUP BY vehicle_type, customer_id
)
SELECT vehicle_type, customer_id, total_bookings
FROM ranked_customers
WHERE rank = 1;


--3. Calculate the average ride duration and the average booking value for each day of the week.

CREATE VIEW avg_ride_duration_and_booking_value_by_dow  AS
SELECT to_char(TO_TIMESTAMP(date, 'DD-MM-YYYY HH24:M1'), 'Day'),
		ROUND(AVG(v_tat + c_tat), 2) AS average_duration,
		ROUND(AVG(booking_value), 2) AS average_booking_value
FROM bookings
GROUP BY 1
ORDER BY 3 DESC


-- 4. Identify the most common reasons for incomplete rides, sorted by frequency.

CREATE VIEW common_reasons_for_incomplete_rides AS
select incomplete_rides_reason, count(*) as total_bookings
from bookings
group by 1
order by 2 desc;

-- Null here being the top reason shows that the reason is not submitted for most of the times the ride was incomplete
-- or grouping nulls and other issue together

CREATE VIEW common_reasons_for_incomplete_rides_ AS
SELECT 
    CASE 
        WHEN incomplete_rides_reason is null OR incomplete_rides_reason = 'Other Issue' THEN 'Other Issue'
        ELSE incomplete_rides_reason
    END AS incomplete_rides_reason,
    COUNT(*) AS total_bookings
FROM bookings
GROUP BY 
    CASE 
        WHEN incomplete_rides_reason is null OR incomplete_rides_reason = 'Other Issue' THEN 'Other Issue'
        ELSE incomplete_rides_reason
    END
ORDER BY total_bookings DESC;



-- 5. Retrieve the total number of rides canceled by drivers for different reasons
-- and calculate their percentage share out of total canceled rides.

CREATE VIEW driver_cancel_reasons_percentages AS 
SELECT canceled_rides_by_driver, 
	   COUNT(*) AS total_rides_canceled_by_driver,
	   CONCAT(
			  ROUND(
					COUNT(*)::NUMERIC/
									(
									  SELECT COUNT(*) 
									  FROM bookings
						              WHERE canceled_rides_by_customer IS NOT NULL OR canceled_rides_by_driver IS NOT NULL
									 )
									  ::NUMERIC * 100, 2
				   ), '%'
			  ) AS percent_of_total
FROM bookings
WHERE canceled_rides_by_driver IS NOT NULL
GROUP BY 1






-- ANSWER QUERIES FOR DIRECT ANSWERS :

 -- 1. Retrieve all successful bookings:

SELECT * FROM successfull_bookings
 
 -- 2. Find the average ride distance for each vehicle type:

SELECT * FROM vehicle_avg_distance;
 
 -- 3. Get the total number of cancelled rides by customers:

SELECT * FROM cancelled_rides_by_cust;
 
 -- 4. List the top 5 customers who booked the highest number of rides:

SELECT * FROM top_5_cust;

 -- 5. Get the number of rides cancelled by drivers due to personal and car-related issues:

SELECT * FROM rdes_canceled_by_driver_P_C_issues;

 -- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings:

SELECT * FROM max_min_rating_for_prime_sedan;

 -- 7. Retrieve all rides where payment was made using UPI:

SELECT * FROM upi_payment;

 -- 8. Find the average customer rating per vehicle type:

SELECT * FROM avg_cust_rating_by_vehicle;

 -- 9. Calculate the total booking value of rides completed successfully:

SELECT * FROM successful_rides_booking_value;
 
 -- 10. List all incomplete rides along with the reason:

SELECT * FROM incomplete_rides_reason;

--+5
-- 1. Find the average ride distance for completed rides, grouped by booking status.

SELECT * FROM avg_distance_by_status

-- 2. Retrieve the customer who has made the highest number of bookings for each vehicle type.

SELECT * FROM top_customer_by_vehicle_type;

--3. Calculate the average ride duration and the average booking value for each day of the week.

SELECT * FROM avg_ride_duration_and_booking_value_by_dow;

-- 4. Identify the most common reasons for incomplete rides, sorted by frequency.

SELECT * FROM common_reasons_for_incomplete_rides_;

-- OR

SELECT * FROM common_reasons_for_incomplete_rides;

               -- Returns some nulls

-- 5. Retrieve the total number of rides canceled by drivers for different reasons 
-- and calculate their percentage share out of total canceled rides.

SELECT * FROM driver_cancel_reasons_percentages;







