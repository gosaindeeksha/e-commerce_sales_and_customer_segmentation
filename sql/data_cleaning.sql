--SQL Queries to populate facts and dimension tables (data cleaning and preprocessing)

--1. Populating products dimension table
INSERT INTO dim_products (product_id, product_description)
SELECT UPPER(StockCode) AS product_id, 
MAX(Description) AS product_description -- MAX(Description) makes sure that there are no duplicated values of description
FROM staging_table
WHERE Quantity > 0 AND UnitPrice > 0 -- removing incorrect values
GROUP BY UPPER(StockCode);

SELECT COUNT(*) FROM dim_products; --to check if data was imported correctly

--2. Populating customers dimension table
INSERT INTO dim_customers (CustomerID, Country)
SELECT
    CAST(CustomerID AS INTEGER) AS CustomerID, --typecasting CustomerID as Integer 
    MAX(Country) AS Country
FROM staging_table
WHERE Quantity > 0
  AND UnitPrice > 0
  AND CustomerID <> '' --removing blanks
GROUP BY CustomerID;

SELECT COUNT(*) FROM dim_customers;

--3. Populating date dimension table
INSERT INTO dim_date (date_key,date,year,month,month_name,quarter,day_of_week)
SELECT
    CAST(STRFTIME('%Y%m%d', iso_date) AS INTEGER) AS date_key, --typecasting datekey as an integer and storing it
    iso_date AS date,
    CAST(STRFTIME('%Y', iso_date) AS INTEGER) AS year, --extracting year from date
    CAST(STRFTIME('%m', iso_date) AS INTEGER) AS month, --extracting month number from date
    STRFTIME('%m', iso_date) AS month_name, --WILL UPDATE TABLE to replace month number to month name in Subsequent Query 
    ((CAST(STRFTIME('%m', iso_date) AS INTEGER) - 1) / 3) + 1 AS quarter,
    STRFTIME('%w', iso_date) AS day_of_week --WILL UPDATE TABLE to replace day of week number to name in Subsequent Query 
FROM (
    SELECT DISTINCT
    DATE( --Date cant change text to date that is not in YYYY-mm-dd format
    SUBSTR(InvoiceDate, 7, 4) || '-' || SUBSTR(InvoiceDate, 4, 2) || '-' || SUBSTR(InvoiceDate, 1, 2) -- Converting dd-mm-YYYY format of original dataset to YYYY-mm-dd
    FROM staging_table
    ) AS iso_date 
    WHERE Quantity > 0
      AND UnitPrice > 0
      AND iso_date IS NOT NULL
);

SELECT COUNT(*) FROM dim_date;
--Query to update day of week in dim_date
UPDATE dim_date
SET day_of_week =
    CASE day_of_week
        WHEN '0' THEN 'Sunday'
        WHEN '1' THEN 'Monday'
        WHEN '2' THEN 'Tuesday'
        WHEN '3' THEN 'Wednesday'
        WHEN '4' THEN 'Thursday'
        WHEN '5' THEN 'Friday'
        WHEN '6' THEN 'Saturday'
    END;
--Query to update month name in dim_date
UPDATE dim_date
SET month_name =
    CASE month
        WHEN 1 THEN 'January'
        WHEN 2 THEN 'February'
        WHEN 3 THEN 'March'
        WHEN 4 THEN 'April'
        WHEN 5 THEN 'May'
        WHEN 6 THEN 'June'
        WHEN 7 THEN 'July'
        WHEN 8 THEN 'August'
        WHEN 9 THEN 'September'
        WHEN 10 THEN 'October'
        WHEN 11 THEN 'November'
        WHEN 12 THEN 'December'
    END;

--4. Populating SALES fact table
INSERT INTO fact_sales (invoice_no,product_id,customer_id, date_key,quantity,unit_price,revenue)
SELECT
    s.InvoiceNo AS invoice_no,
    s.StockCode AS product_id,
    CAST(s.CustomerID AS INTEGER) AS customer_id,
    d.date_key, --extracting date_key directly from the dim_date table
    s.Quantity AS quantity,
    s.UnitPrice AS unit_price,
    s.Quantity * s.UnitPrice AS revenue --calculated column revenue=Quantity*unit_price
FROM staging_table s
JOIN dim_date d
    ON d.date = DATE(
        SUBSTR(s.InvoiceDate, 7, 4) || '-' ||
        SUBSTR(s.InvoiceDate, 4, 2) || '-' ||
        SUBSTR(s.InvoiceDate, 1, 2)
    )
WHERE s.Quantity > 0 AND s.UnitPrice > 0 AND s.CustomerID IS NOT NULL AND s.CustomerID <> ''; 




