# 🚗 Ola Ride Analytics Project

![Project Logo](logo.png)

## 🎯 Objective  
This project aims to analyze Ola’s ride booking data using SQL. It focuses on successful bookings, customer behavior, ride statistics, and the reasons behind cancellations and incomplete rides. The goal is to uncover actionable insights that support better decision-making.

---

## 🧱 Database Overview  
The analysis is based on a database named `ola_db`, containing the primary table `bookings`, with fields such as:
- `booking_status`, `ride_distance`, `driver_ratings`, `customer_ratings`
- `vehicle_type`, `payment_method`, `v_tat`, `c_tat`
- `canceled_rides_by_customer`, `canceled_rides_by_driver`, `incomplete_rides`, etc.

---

## 🔍 Key Business Questions Answered via SQL Views  
✔️ Total successful bookings  
✔️ Average ride distance by vehicle type  
✔️ Top 5 customers by ride count  
✔️ Cancellations by customers and drivers  
✔️ UPI payment usage  
✔️ Driver ratings for specific vehicle types  
✔️ Incomplete rides with reasons  
✔️ Booking value of completed rides  
✔️ Daily trends in ride duration and booking value  
✔️ Cancellation reasons and their proportions  

---

## 🛠 Tools & Technologies Used  
- **SQL** – Data Analysis & View Creation  
- **PostgreSQL / pgAdmin** – Query Execution  
- **Excel** – Report Writing and Insights Summarization  

---

## 📌 Folder Contents
This project folder includes:

Ola_Ride_SQL_Queries.sql – SQL views and business logic
Ola_Ride_Dashboard.pbix – Power BI dashboard
Screenshots/ – Visuals of key dashboard pages
ola_bookings_data.csv – Raw data used for analysis
Ola_Ride_Project_Report.pdf – Complete project report
README.md – Project overview and documentation 

---

## 📈 Insights Summary  
- UPI is the most preferred payment method  
- Driver-related cancellations need further intervention  
- Top customers offer strong potential for loyalty programs  
- Incomplete rides and undefined reasons highlight a gap in data collection  
- Weekday trends in ride duration and booking value can inform pricing strategies

---

## 💡 Recommendations  
- Enhance driver support to reduce cancellations  
- Launch loyalty programs for frequent riders  
- Improve data tracking for incomplete rides  
- Use insights to optimize vehicle type usage  
- Promote UPI with exclusive offers  
- Apply ride duration trends to pricing models  

---

## 📍 Conclusion  
The Ola Ride Analytics project provides valuable insights into ride booking patterns, customer behavior, and operational pain points. These findings and recommendations can help Ola improve its service quality, customer satisfaction, and efficiency.

---

