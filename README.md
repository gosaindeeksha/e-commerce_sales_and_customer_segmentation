# E-commerce Sales & Customer Segmentation Analysis

## Project Overview
This project analyzes transaction-level e-commerce data to understand sales performance, customer behavior, and revenue concentration.  
The goal is to help a business **optimize product offerings, improve customer targeting, and reduce revenue risk** using data-driven insights.

The analysis combines **SQL-based data modeling**, **Python analytics (RFM & clustering)**, and **interactive dashboards (Power BI & Tableau)** to translate raw transactions into actionable business decisions.

---

## Dataset
- **Source:** UCI Online Retail Dataset  
- **Time Period:** December 2010 – December 2011  

The dataset contains information on:
- Customers
- Products
- Quantities and prices
- Invoice dates
- Countries

---

## Tools & Technologies
- **SQL (SQLite):** Data cleaning, transformation, and star-schema modeling  
- **Python (pandas, numpy, scikit-learn):**  
  - Exploratory Data Analysis (EDA)  
  - RFM customer segmentation  
  - K-Means clustering for behavioral validation  
- **Power BI & Tableau:** Interactive dashboards  
- **PowerPoint:** Executive presentation of insights  

---

## Data Modeling
A star-schema model was created for analysis:
- **Fact Table:** Sales transactions (quantity, price, revenue)
- **Dimension Tables:** Customers, Products, Dates

This structure supports efficient aggregation, segmentation, and BI reporting.

---

## Analytical Approach

### Exploratory Data Analysis (EDA)
- Revenue distribution was highly skewed
- Small number of products and customers drive a large share of revenue

### RFM Customer Segmentation
Customers were segmented using:
- **Recency**
- **Frequency**
- **Monetary value**

Segmentation logic:
- *Activeness* defined using **both recency and frequency**
- *Customer value* defined using **monetary contribution**

Final segments:
- Active High-Value  
- Active Low-Value  
- Inactive High-Value  
- Inactive Low-Value  

### K-Means Clustering (Supporting Analysis)
K-Means clustering was used to:
- Validate RFM segments
- Identify extreme customer behavior

This revealed **4 VVIP customers** with exceptionally high spend, frequency, and recency.  
While they do not dominate total revenue, they represent **high per-customer risk** and require special retention focus.

---

## Dashboards
Three interactive dashboards were built in **both Power BI and Tableau**:
---

## Key Business Insights
- Revenue is highly concentrated among a small group of customers
- Inactive high-value customers represent significant revenue risk
- Active low-value customers present strong upsell opportunities
- A very small set of VVIP customers require proactive retention strategies
- Product performance varies significantly by customer segment

---

## Business Recommendations
- Launch win-back campaigns targeting inactive high-value customers
- Implement upsell and bundling strategies for active low-value customers
- Provide white-glove retention for VVIP customers
- Align product promotions with segment-specific purchasing behavior
- Monitor revenue concentration to reduce dependency risk

---

## Local Setup (Optional)

This project can be reproduced locally using SQLite and VS Code.

### Prerequisites
- Python 3.x
- VS Code
- Power BI Desktop and/or Tableau (for dashboard viewing)

### Steps
1. Open the project folder in VS Code.
2. Install the **SQLTools** extension and the **SQLite driver**.
3. Create a SQLite connection pointing to the local database file (`ecommerce.db`).
4. Run the SQL scripts in the `sql/` folder to create tables and preprocess data.
5. Open the Jupyter notebooks in the `notebooks/` folder to reproduce the analysis.
6. Open the dashboard files from the `dashboards/` folder to explore insights.

> Note: The database is not included in the repository due to size.  
> Instructions to recreate the database are provided via SQL Queries.
