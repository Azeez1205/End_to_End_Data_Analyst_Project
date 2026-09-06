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
