--SQL Queries to CREATE facts and dimension tables

--1.Query to create products dimension table
CREATE TABLE IF NOT EXISTS dim_products (
    product_id TEXT PRIMARY KEY,
    product_description TEXT
);

--2.Query to create customers dimension table
CREATE TABLE IF NOT EXISTS dim_customers(
    CustomerID INTEGER PRIMARY KEY,
    Country TEXT
);

--3.Query to create date dimension table
CREATE TABLE IF NOT EXISTS dim_date (
    date_key INTEGER PRIMARY KEY,   -- YYYYMMDD (for join purposes)
    date TEXT NOT NULL,             -- YYYY-MM-DD
    year INTEGER,                   
    month INTEGER,    
    month_name TEXT,
    quarter INTEGER,
    day_of_week TEXT
);

--4.Query to create Sales Fact table
CREATE TABLE IF NOT EXISTS fact_sales (
    sales_id INTEGER PRIMARY KEY AUTOINCREMENT,
    invoice_no TEXT NOT NULL,
    product_id TEXT NOT NULL,
    customer_id INTEGER,
    date_key INTEGER NOT NULL, --using date key instead of original invoice_date as time will not be needed for the analysis
    quantity INTEGER NOT NULL,
    unit_price REAL NOT NULL,
    revenue REAL NOT NULL,

    FOREIGN KEY (product_id) REFERENCES dim_products(product_id),
    FOREIGN KEY (customer_id) REFERENCES dim_customers(customer_id),
    FOREIGN KEY (date_key) REFERENCES dim_date(date_key)
);