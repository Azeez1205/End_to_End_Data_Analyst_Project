# E-Commerce Sales Project - Data Analysis Project

This project focuses on analyzing and visualizing data, in order to gain relevamt insights using SQL, Excel and Power BI.

The dashboard for this project can be found here <a href="https://github.com/Azeez1205/Data-Cleaning-Project/blob/main/E%20Commerce%20sales%20dashboard.pdf">View Dashboard</a>
## Project Objectives

- Identify trends and patterns
- Analyze KPI performance metrics
- Summarize key findings clearly
- Visualize data through dashboards
- Generate actionable business insights

## Technologies Used

- MySQL
- Excel
- Power Query
- Power BI

## Dataset Description
The dataset used is the output of the data cleaning project that can be found in this repository and it contains 89 clean sales records from an E-commerce dataset

### Data dictionary

| Column Name     | Description                      | Data Type |
| --------------- | -------------------------------- | --------- |
| ID              | Unique Customer ID               | Integer   |
| Customer_name   | Customer's name                  | Text      |
| Order_id        | Unique Customer's Order ID       | Text      |
| Order_date      | Date the Order was placed        | Date      |
| Product         | Name of the Product              | Text      |
| Category        | Category of the product          | Text      |
| Quantity        | How many products were ordered   | Integer   |
| Price           | Price of the product             | Integer   |
| Payment_method  | Method of payment                | Text      |
| Status          | Current status of the sale       | Text      |
| Total           | Total amount of the order        | Integer   |

## SQL Queries Used
```sql
-- Now, let's start the Exploratory data analysis
SELECT *
FROM ecommerce_dataset;

-- Total Revenue
SELECT sum(total)
FROM ecommerce_dataset;
-- Done

-- Total Orders
SELECT count(distinct order_id)
FROM ecommerce_dataset;
-- Done

-- Average Order value
SELECT SUM(total)/count(DISTINCT order_id)
FROM ecommerce_dataset;
-- Done

-- Total Units Sold
SELECT sum(quantity)
FROM ecommerce_dataset;
-- Done

-- Average Items per order
SELECT SUM(QUANTITY)/count(distinct order_id)
FROM ecommerce_dataset;
-- Done

-- Order Fufillment/Cancelment rate
SELECT `status`, count(order_id)*100/(select count(order_id) from ecommerce_dataset)
from ecommerce_dataset
group by `status`;
-- Done

-- Monthly revenue trend
select monthname(order_date), sum(total)
FROM ecommerce_dataset
GROUP BY monthname(order_date), month(order_date)
ORDER BY month(order_date);
-- Done

-- Revenue Per category
SELECT category, ROUND(SUM(total)*100/(SELECT sum(total) FROM ecommerce_dataset),3)
FROM ecommerce_dataset
GROUP BY category;
-- Done

-- Top 10 Best Selling Products(By Revenue)
SELECT product, sum(total)
FROM ecommerce_dataset
GROUP BY product
ORDER BY 2 DESC
LIMIT 10;
-- Done


-- Order Status Breakdown
SELECT `status`, count(order_id)*100/(select count(order_id) from ecommerce_dataset)
from ecommerce_dataset
group by `status`;
-- Done

-- Revenue by Payment Method
SELECT payment_method, sum(total)
FROM ecommerce_dataset
GROUP BY Payment_Method;
-- Done

-- Daily Order Volume
SELECT dayname(order_date), sum(total)
FROM ecommerce_dataset
GROUP BY dayname(order_date), weekday(order_date)
ORDER BY weekday(order_date);
-- Done
```
