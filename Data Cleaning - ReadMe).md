# E-Commerce Sales Project - Data Cleaning Project

This project focuses on cleaning and preparing raw, inconsistent data using SQL.
It demonstrates practical SQL techniques commonly used in real-world data analysis and data engineering workflows.

## Project Objectives

- Identify and handle missing values
- Remove duplicate records
- Standardize inconsistent data formats
- Correct invalid or incorrect values
- Prepare clean datasets for analysis

## Technologies Used

- MySQL
- Relational databases
- Common Table Expressions (CTEs)
- Window functions

## Dataset Description
The dataset contains 97 sales records from an E-commerce dataset

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
-- Data Cleaning Project Of a Messy E-Commerce Sales Dataset

SELECT *
FROM messy_ecommerce_sales_data;

-- Cleaning/Formatting the date colume
SELECT order_date, str_to_date(order_date, '%m/%d/%Y')
FROM messy_ecommerce_sales_data;

-- To find date in string format
SELECT order_date
FROM messy_ecommerce_sales_data
WHERE order_date  NOT LIKE '%_%/%_%/%_%';

-- To change it to date format
UPDATE messy_ecommerce_sales_data
SET order_date = '1/5/2023'
WHERE order_date = 'Jan 5 2023';

-- To change the date format 
SELECT order_date, str_to_date(order_date, '%m/%d/%Y')
FROM messy_ecommerce_sales_data;

UPDATE messy_ecommerce_sales_data
SET order_date = str_to_date(order_date, '%m/%d/%Y');

-- To Update the date column from text to date
ALTER TABLE messy_ecommerce_sales_data
MODIFY COLUMN order_date date;

SELECT *
FROM messy_ecommerce_sales_data
ORDER BY 8;

-- To check for duplicates
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER()  over(
pARTITION BY id, customer_name, order_id, product, `status`
) AS row_num
FROM messy_ecommerce_sales_data
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- To create a new standardized table 
CREATE TABLE `messy_ecommerce_sales_data2` (
  `ID` int DEFAULT NULL,
  `Customer_Name` text,
  `Order_ID` text,
  `Order_Date` date DEFAULT NULL,
  `Product` text,
  `Category` text,
  `Quantity` int DEFAULT NULL,
  `Price` text,
  `Payment_Method` text,
  `Status` text,
  `Total` text,
  `Row_Num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * 
FROM messy_ecommerce_sales_data2;

-- Adding values int the new updated table
INSERT INTO messy_ecommerce_sales_data2
SELECT *,
ROW_NUMBER()  over(
pARTITION BY id, customer_name, order_id, product, `status`
) AS row_num
FROM messy_ecommerce_sales_data;

-- Deleting duplicates
SELECT * 
FROM messy_ecommerce_sales_data2
WHERE Row_Num > 1;

DELETE 
FROM messy_ecommerce_sales_data2
WHERE Row_Num > 1;

 -- Standardizing the price column
SELECT * 
FROM messy_ecommerce_sales_data2
order by 8 desc;

UPDATE messy_ecommerce_sales_data2
SET price = NULL
WHERE ID = 101;

-- Change empty cells to nulls in the price column
SELECT *
FROM messy_ecommerce_sales_data2
WHERE PRICE = '';

UPDATE messy_ecommerce_sales_data2
SET price = NULL
where price = '';

-- Remove currency from row 20
UPDATE messy_ecommerce_sales_data2
SET price = 300
WHERE id = 120;

-- Change datatype of the price column
ALTER TABLE messy_ecommerce_sales_data2
MODIFY COLUMN price int;

-- Standardize category Column

select category, concat(upper(left(category, 1)), lower(substring(category, 2))) as title_case
from messy_ecommerce_sales_data2;

UPDATE messy_ecommerce_sales_data2
SET category = concat(upper(left(category, 1)), lower(substring(category, 2)));

-- Change empty cells to nulls in the total column
SELECT total
FROM messy_ecommerce_sales_data2
order by 1;

UPDATE messy_ecommerce_sales_data2
SET total = NULL
WHERE total = '';

-- Change datatype of the total column
ALTER TABLE messy_ecommerce_sales_data2
MODIFY COLUMN total int;

-- Looking for the errors(negative sign)
SELECT *
FROM messy_ecommerce_sales_data2
WHERE price LIKE '-%'
OR total LIKE '-%'
OR quantity LIKE '-%';

-- Changing the errors in the quantity column 
UPDATE messy_ecommerce_sales_data2
SET quantity = quantity*-1
WHERE quantity LIKE '-%';

-- Changing the errors in the price column 
UPDATE messy_ecommerce_sales_data2
SET price = price*-1
WHERE price LIKE '-%';

-- Changing the errors in the total column 
UPDATE messy_ecommerce_sales_data2
SET total = total*-1
WHERE total LIKE '-%';

-- Recalculating the total for incorrect rows(since dataset doesn't include discount)
SELECT *
FROM messy_ecommerce_sales_data2
WHERE quantity*price != total;

SELECT quantity, price, total, price*quantity AS total_new
FROM messy_ecommerce_sales_data2;

UPDATE messy_ecommerce_sales_data2
SET total = price*quantity;

-- Populating Data

-- Change Incorrect category(Electronic)
SELECT category, count(category)
FROM messy_ecommerce_sales_data2
GROUP BY category;

UPDATE messy_ecommerce_sales_data2
SET category = 'Electronics'
WHERE category = 'Electronic';

-- Change Incorrect category(nan)
SELECT *
FROM messy_ecommerce_sales_data2
WHERE category = 'nan'
OR product = 'Biography'
OR product = 'Smartphone';

UPDATE messy_ecommerce_sales_data2
SET category = 'Books'
WHERE product = 'Biography'
AND category = 'nan';

UPDATE messy_ecommerce_sales_data2
SET category = 'Electronics'
WHERE product = 'Smartphone'
AND category = 'nan';

-- Populating empty categories using products 
SELECT product, category
FROM messy_ecommerce_sales_data2
WHERE category = '';

-- Headphones
SELECT product, category
FROM messy_ecommerce_sales_data2
WHERE category = ''
OR product = 'Headphones';

UPDATE messy_ecommerce_sales_data2
SET category = 'Electronics'
WHERE category = ''
AND product = 'Headphones';

-- Laptop
SELECT product, category
FROM messy_ecommerce_sales_data2
WHERE category = ''
OR product = 'Laptop';

UPDATE messy_ecommerce_sales_data2
SET category = 'Electronics'
WHERE category = ''
AND product = 'Laptop';

-- Shoes
SELECT product, category
FROM messy_ecommerce_sales_data2
WHERE category = ''
OR product = 'Shoes';

UPDATE messy_ecommerce_sales_data2
SET category = 'Clothing'
WHERE category = ''
AND product = 'Shoes';

-- Jeans
SELECT product, category
FROM messy_ecommerce_sales_data2
WHERE category = ''
OR product = 'Jeans';

UPDATE messy_ecommerce_sales_data2
SET category = 'Clothing'
WHERE category = ''
AND product = 'Jeans';

-- Vacuum
SELECT product, category
FROM messy_ecommerce_sales_data2
WHERE category = ''
OR product = 'Vacuum';

UPDATE messy_ecommerce_sales_data2
SET category = 'Home'
WHERE (category = ''
AND product = 'Vacuum')
OR category = 'Electronics';

-- To confirm if they're all correct
SELECT product, category
from messy_ecommerce_sales_data2
order by 1;

-- To change T-shirt to Clothing where it says "Home"
UPDATE messy_ecommerce_sales_data2
SET category = 'Clothing'
WHERE category = 'Home'
AND product = 'T-shirt';

-- To change Yoga Mat to Sports where it says "Home"
UPDATE messy_ecommerce_sales_data2
SET category = 'Sports'
WHERE category = 'Home'
AND product = 'Yoga Mat';

-- To change Basketbaall to Sports where it says "Books"
UPDATE messy_ecommerce_sales_data2
SET category = 'Sports'
WHERE category = 'Home'
AND product = 'Basketball';

-- Now that we have a clean data, we'll now delete rows with cells that don't have price or total since our aim is no analyse revenue
SELECT *
FROM messy_ecommerce_sales_data2
WHERE price IS NULL
AND total IS NULL;

DELETE 
FROM messy_ecommerce_sales_data2
WHERE price IS NULL
AND total IS NULL;

-- And now we delete the row number column
SELECT *
FROM messy_ecommerce_sales_data2;

ALTER TABLE messy_ecommerce_sales_data2
DROP COLUMN row_num;

-- Our data is now clean.

-- Now, let's start the Exploratory data analysis
SELECT *
FROM messy_ecommerce_sales_data2
```
