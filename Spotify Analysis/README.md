<p align="center">
  <img src="logo.png" alt="Logo" width="350"/>
</p>

# 🎧 Spotify Listening Behavior Analysis (Power BI + SQL)

---

## 📌 Project Overview

This repository contains **two advanced analytical projects** based on Spotify listening and track performance data, built using:

- 📊 **Power BI** for visual storytelling and dashboarding
- 🧮 **Advanced SQL** for deep data querying and metric derivation

Both projects aim to uncover patterns in music consumption, artist performance, and listener behavior over time.

---

## 🗂️ Folder Structure

| File / Folder             | Description                                 |
|---------------------------|---------------------------------------------|
| `dash.pbix`   | Power BI dashboard file                     |
| `Spotify Data(powerbi_project).rar`  | Cleaned data used in the Power BI project   |
| `spotify_cleaned(sql_project).csv` | Raw dataset used for SQL analysis           |
| `spotify_sql_project.sql` | Complete SQL script with EDA and practice queries |
| `Spotify_Dashboard.mp4`   | Walkthrough video of Power BI dashboard     |

---

## 📊 Project 1 – Power BI Dashboard

### 🎯 Business Objectives

#### 🟩 Albums
- Total albums played over time  
- Yearly album diversity  
- Weekday vs weekend album trends  
- Top 5 albums by frequency  
- Year-over-year comparison  

#### 🟩 Artists
- Artist performance over time  
- Top artists by listening frequency  
- Unique artists per year  
- Weekday vs weekend artist engagement  

#### 🟩 Tracks
- Total tracks played  
- Diversity of tracks per year  
- Top tracks  
- Track popularity trends  

#### 🟩 Listening Patterns
- 🎛️ Heatmaps for hour-by-hour listening  
- 🎯 Quadrant Analysis of Frequency vs Time:
  - **High Frequency + High Time** = Most Engaging  
  - **Low Frequency + High Time** = Niche Impactful  
  - **High Frequency + Low Time** = Short Popular  
  - **Low Frequency + Low Time** = Less Popular  

#### 🟩 Drillthrough Table
- Album Name, Artist Name, Track Name, Duration  
- Export enabled to CSV  

### 🛠 Tools & Techniques Used

| Tool               | Usage                                             |
|--------------------|--------------------------------------------------|
| Power BI Desktop   | Dashboard design, visualizations, DAX            |
| DAX                | Date intelligence, ranking logic, YoY metrics    |
| Power Query        | ETL – data shaping and cleaning                  |
| Drill-throughs     | User-level data exploration                      |
| Custom Visuals     | Heatmaps, scatter plots, slicers, tables         |

---

## 🧮 Project 2 – Advanced SQL Project

The SQL-based project uses a Spotify dataset to perform EDA, filtering, aggregation, window functions, and practice-level queries across multiple difficulty levels.

### 🔍 Exploratory Data Analysis (EDA)

- Count of rows, albums, and cleanup of invalid durations  
- Filtering zero-duration tracks  
- Summary of dataset attributes  

### ✅ Practice SQL Queries

#### 🟢 Very Easy
- Tracks with >1B streams  
- Albums with artists  
- Total comments where licensed = TRUE  
- Single-type albums  
- Count of tracks by each artist  

#### 🟡 Medium
- Tracks with above-average liveness  
- Avg danceability per album  
- Top 5 tracks by energy  
- Tracks with official videos and their views/likes  
- Views by album  
- Tracks streamed more on Spotify than YouTube  
- Cumulative likes by views using window functions  

#### 🔴 Advanced
- Top 3 viewed tracks per artist using `DENSE_RANK()`  
- Energy range per album using `WITH` clause  
- Tracks with energy-to-liveness ratio > 1.2 (two approaches)

---

## 💼 Skills Demonstrated

- SQL Window Functions (`RANK()`, `SUM() OVER`)  
- Aggregations & Grouping  
- Subqueries & Common Table Expressions (CTEs)  
- Power BI DAX Measures  
- Interactive Slicers, Drill-downs, Tooltips  

---

## 📬 Connect With Me

- 🔗 [LinkedIn – Yash Ingle](https://www.linkedin.com/in/yashingle24)  
- 📧 yashingle.work@gmail.com  

---

⭐ **If you found this project insightful or helpful, don't forget to star this repository!**
