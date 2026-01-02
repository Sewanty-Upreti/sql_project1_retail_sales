# sql_project1_retail_sales
# SQL Retail Sales Analysis Project

## Project Overview

This project performs **data cleaning**, **exploration**, and **analysis** on a retail sales dataset using SQL. The dataset is stored in a table named `retail_sales` and contains transaction details such as date, time, customer information, product category, quantity, pricing, and total sales.

Key activities include:
- Creating the database and table
- Handling null values
- Exploratory data analysis
- Answering 10 business-oriented analytical questions

The analysis provides insights into sales performance, customer behavior, category trends, and operational patterns (e.g., shifts).

## Database and Table Schema

```sql
CREATE DATABASE sql_project_p1;

CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(25),
    quantiy INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

## Data Cleaning

```sql
-- Check for null values
SELECT * FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

-- Delete rows with null values
DELETE FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```

## Data Exploration

```sql
-- Total number of sales
SELECT COUNT(*) AS total_sale FROM retail_sales;

-- Number of unique customers
SELECT COUNT(DISTINCT customer_id) AS total_customers FROM retail_sales;

-- Distinct categories
SELECT DISTINCT category FROM retail_sales;
```

## Business Analysis Questions & SQL Queries

### Q1: Retrieve all columns for sales made on '2022-11-05'

```sql
SELECT * 
FROM retail_sales 
WHERE sale_date = '2022-11-05';
```

### Q2: Retrieve all transactions where category is 'Clothing' and quantity sold is more than or equal to 4 in November 2022  


```sql
SELECT * 
FROM retail_sales 
WHERE category = 'Clothing' 
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30'
  AND quantiy >= 4;
```

### Q3: Calculate total sales and number of orders for each category

```sql
SELECT 
    category, 
    SUM(total_sale) AS net_sale,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
```

### Q4: Find the average age of customers who purchased items from the 'Beauty' category

```sql
SELECT ROUND(AVG(age), 2) AS average_age
FROM retail_sales 
WHERE category = 'Beauty';
```

### Q5: Find all transactions where total_sale > 1000

```sql
SELECT * 
FROM retail_sales 
WHERE total_sale > 1000;
```

### Q6: Find the total number of transactions made by each gender in each category

```sql
SELECT 
    category, 
    gender, 
    COUNT(*) AS total_trans 
FROM retail_sales
GROUP BY category, gender
ORDER BY category;
```

### Q7: Calculate the average sale for each month and find the best-selling month (highest average sale) in each year

```sql
SELECT *
FROM (
    SELECT
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        ROUND(AVG(total_sale), 2) AS avg_sale,
        RANK() OVER (
            PARTITION BY YEAR(sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS sales_rank
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) ranked_sales
WHERE sales_rank = 1
ORDER BY year;
```

### Q8: Find the top 5 customers based on highest total sales

```sql
SELECT
    customer_id,
    SUM(total_sale) AS total_sale
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;
```

### Q9: Find the number of unique customers who purchased items from each category

```sql
SELECT 
    COUNT(DISTINCT customer_id) AS no_of_unique_customers, 
    category
FROM retail_sales
GROUP BY category;
```

### Q10: Categorize shifts (Morning ≤12:00, Afternoon 12:00-17:00, Evening >17:00) and count orders per shift

```sql
SELECT
    CASE
        WHEN sale_time < '12:00:00' THEN 'Morning shift'
        WHEN sale_time BETWEEN '12:00:00' AND '17:00:00' THEN 'Afternoon shift'
        ELSE 'Evening shift'
    END AS shift,
    COUNT(*) AS number_of_orders
FROM retail_sales
GROUP BY
    CASE
        WHEN sale_time < '12:00:00' THEN 'Morning shift'
        WHEN sale_time BETWEEN '12:00:00' AND '17:00:00' THEN 'Afternoon shift'
        ELSE 'Evening shift'
    END
ORDER BY shift;
```

## Conclusion

This project demonstrates essential SQL skills for retail data analysis, including data cleaning, aggregation, window functions, and conditional logic. The queries provide actionable business insights such as top-performing categories, customer demographics, peak months, high-value customers, and operational shift performance.


