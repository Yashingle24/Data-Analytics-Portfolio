# 🛒 Walmart Data Analysis: End-to-End SQL + Python Project

---
![Project Pipeline](walmart_project-piplelines.png)
---
![Python](https://img.shields.io/badge/Python-3.8%2B-blue?logo=python)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Used-blue?logo=postgresql)
![Jupyter](https://img.shields.io/badge/Jupyter-Notebook-orange?logo=jupyter)
![License](https://img.shields.io/badge/License-MIT-green.svg)
   
## 📚 Table of Contents
- [Overview](#project-overview)
- [Project Steps](#project-steps)
- [Set Up the Environment](#1-set-up-the-environment)
- [Set Up Kaggle API](#2-set-up-kaggle-api)
- [Download Walmart Sales Data](#3-download-walmart-sales-data)
- [Install Required Libraries and Load Data](#4-install-required-libraries-and-load-data)
- [Explore the Data](#5-explore-the-data)
- [Data Cleaning](#6-data-cleaning)
- [Feature Engineering](#7-feature-engineering)
- [Load Data into PostgreSQL](#8-load-data-into-postgresql)
- [SQL Analysis](#9-sql-analysis-complex-queries-and-business-problem-solving)
- [Project Structure](#project-structure)
- [Results and Insights](#results-and-insights)
- [Future Enhancements](#future-enhancements)
- [Contact](#contact)


---

## 🧠 Overview

This project presents an end-to-end data analysis pipeline built to extract key business insights from Walmart’s sales data. Using Python and PostgreSQL, I cleaned and transformed raw data, engineered new features, and solved real-world business problems through advanced SQL queries. The focus was on creating a structured, scalable pipeline that can answer critical retail questions around sales, profitability, and customer behavior.

---

## 🔧 Tools & Technologies Used

- **Languages**: Python, SQL  
- **Database**: PostgreSQL  
- **Libraries**: `pandas`, `numpy`, `sqlalchemy`, `psycopg2`  
- **Other Tools**: Jupyter Notebook, VS Code, Kaggle API  

---

## ⚙️ Project Workflow

### 1. Environment Setup  
Organized a structured workspace using Visual Studio Code with proper folder separation for data, scripts, and notebooks.

### 2. Kaggle API Configuration  
Configured the Kaggle API to programmatically download the dataset into the project directory.

### 3. Data Acquisition  
Fetched Walmart’s 10K+ sales records dataset using Kaggle API and stored it in the `data/` folder.

### 4. Library Installation & Data Loading  
Installed all required Python libraries and loaded the dataset into a Pandas DataFrame for processing.

### 5. Initial Data Exploration  
Explored the dataset using `.info()`, `.head()`, and `.describe()` to understand structure, column types, and basic stats.

### 6. Data Cleaning  
Performed key cleaning steps:
- Removed duplicates  
- Handled missing values  
- Converted data types  
- Fixed inconsistent currency formatting  
- Ensured overall data quality  

### 7. Feature Engineering  
Created new features such as `Total Amount = unit_price * quantity` to enable deeper business analysis.

### 8. Data Loading into PostgreSQL  
Loaded the cleaned and enriched dataset into a PostgreSQL database using SQLAlchemy, automating table creation and insertion.

### 9. SQL-Based Business Analysis  
Executed multiple SQL queries to answer high-impact business questions, such as:
- 📊 Revenue trends across branches and product categories  
- 🔥 Best-selling product types  
- 🏙️ City-wise sales performance  
- 🧾 Analysis of payment methods  
- 🕒 Peak shopping hours  
- 📈 Profit margin insights  

---

## 📈 Key Insights

- **Branch Performance**: Certain branches consistently outperformed others in both revenue and profit margins.  
- **Top Categories**: Specific product categories were identified as top-sellers based on unit volume and revenue.  
- **Customer Preferences**: Most customers preferred digital payments, and peak footfall occurred during evening hours.  
- **Profit Drivers**: The most profitable branches often had a combination of high transaction volume and larger average cart values.

---

## 📂 Project Structure

```plaintext
|-- data/                     # Raw and cleaned datasets
|-- sql_queries/              # SQL scripts for insights and business questions
|-- notebooks/                # Jupyter Notebook for data cleaning & transformation
|-- README.md                 # Project documentation
|-- requirements.txt          # Python dependency list
|-- main.py                   # Main script for full pipeline execution
```

---
## Included Files

This repository contains the following main files:

- `notebooks/walmart_analysis.ipynb` — Jupyter Notebook for data cleaning, processing, and transformation using Python.
- `sql_queries/walmart_analysis_queries.sql` — SQL script containing all queries used to solve the business problems in PostgreSQL.
- `requirements.txt` — Python library dependencies.
- `README.md` — Complete project documentation.

---
## Results and Insights

This section summarizes key findings from the analysis conducted on the Walmart sales data.

- **Sales Trends**: 
  - We identified significant seasonality in the sales data. Certain months (e.g., November and December) showed a sharp increase in sales, aligning with holiday shopping trends. This is critical for inventory planning and marketing campaigns.
  
- **High-Performing Branches**: 
  - Some branches consistently outperformed others, particularly those located in urban areas with higher population densities. This trend suggests that location plays a major role in sales volume.

- **Customer Behavior**: 
  - Payment method preferences were analyzed, revealing a strong preference for card payments over cash. This could indicate a shift in customer behavior toward digital payments.
  - We also observed peak shopping times, with the highest sales occurring during weekends and evening hours. This information is valuable for staffing and promotional strategies.

- **Category Performance**: 
  - Certain product categories, such as electronics and clothing, were consistently among the highest in sales, accounting for a large percentage of total revenue. These categories should be prioritized in marketing and stocking strategies.
  
- **Revenue Insights**: 
  - Revenue was directly correlated with specific promotional periods. When discounts were applied, we saw a spike in sales across multiple product categories.
  
- **Profit Margin Analysis**: 
  - The analysis of profit margins across various product categories indicated that some branches with high sales volume had lower profit margins. This suggests that the pricing strategy for these branches may need to be revisited.

These insights provide a clear understanding of sales performance, customer behavior, and product category dynamics that can help drive business decisions at Walmart.

---

## 🚀 Future Enhancements

- Integration with Tableau or Power BI for interactive dashboards  
- Real-time data updates via automated ETL pipelines  
- Deeper customer segmentation and churn prediction using ML  

---

## 📢 Acknowledgments

- **Dataset**: [Walmart Sales Dataset on Kaggle](https://www.kaggle.com/najir0123/walmart-10k-sales-datasets)  
- **Inspiration**: Real-world business cases from Walmart’s retail strategies

---
## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
## 👤 Author

**Yash Ingle**  
📧 [yashingle.work@gmail.com](mailto:yashingle.work@gmail.com)  
🔗 [LinkedIn: yashingle](https://www.linkedin.com/in/yashingle24)

---
