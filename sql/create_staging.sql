--SQL query to CREATE staging table to transfer raw data in our data model

CREATE TABLE IF NOT EXISTS staging_table (
    InvoiceNo TEXT,
    StockCode TEXT,
    Description TEXT,
    Quantity INTEGER,
    InvoiceDate TEXT,
    UnitPrice REAL,
    CustomerID INTEGER,
    Country TEXT
);

-- Some Queries to check if data has been imported properly from the CSV file
SELECT COUNT(*) FROM staging_table;

SELECT * FROM staging_table LIMIT 5;

SELECT COUNT(*) AS Valid_Rows_Num FROM staging_table WHERE Quantity>0 AND UnitPrice>0;