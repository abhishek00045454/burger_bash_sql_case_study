create database c3;
use c3;

##Q1
SELECT COUNT(*) as 'no of orders' FROM runner_orders;

##Q2
SELECT COUNT(DISTINCT order_id) AS unique_order_count
FROM customer_orders;

##Q3
SELECT
  runner_id,
  COUNT(DISTINCT order_id) AS successful_orders
FROM runner_orders
WHERE cancellation IS NULL
GROUP BY runner_id
ORDER BY successful_orders DESC;

##Q4
SELECT p.burger_name, COUNT(c.burger_id) AS delivered_burger_count
FROM customer_orders AS c
JOIN runner_orders AS r
 ON c.order_id = r.order_id
JOIN burger_names AS p
 ON c.burger_id = p.burger_id
WHERE r.distance != 0
GROUP BY p.burger_name;

##Q5
SELECT c.customer_id, p.burger_name, COUNT(p.burger_name) AS order_count
FROM customer_orders AS c
JOIN burger_names AS p
 ON c.burger_id= p.burger_id
GROUP BY c.customer_id, p.burger_name
ORDER BY c.customer_id;

##Q6
WITH burger_count_cte AS
(
 SELECT c.order_id, COUNT(c.burger_id) AS burger_per_order
 FROM customer_orders AS c
 JOIN runner_orders AS r
  ON c.order_id = r.order_id
 WHERE r.distance != 0
 GROUP BY c.order_id
)
SELECT MAX(burger_per_order) AS burger_count
FROM burger_count_cte;

##Q7
SELECT c.customer_id,
 SUM(CASE 
  WHEN c.exclusions <> ' ' OR c.extras <> ' ' THEN 1
  ELSE 0
  END) AS at_least_1_change,
 SUM(CASE 
  WHEN c.exclusions = ' ' AND c.extras = ' ' THEN 1 
  ELSE 0
  END) AS no_change
FROM customer_orders AS c
JOIN runner_orders AS r
 ON c.order_id = r.order_id
WHERE r.distance != 0
GROUP BY c.customer_id
ORDER BY c.customer_id;

##Q8
SELECT EXTRACT(HOUR from order_time) AS hour_of_day, 
 COUNT(order_id) AS burger_count
FROM customer_orders
GROUP BY EXTRACT(HOUR from order_time);

##Q9
SELECT EXTRACT(WEEK from registration_date) AS registration_week,
 COUNT(runner_id) AS runner_signup
FROM burger_runner
GROUP BY EXTRACT(WEEK from registration_date);

##Q10
SELECT c.customer_id, AVG(r.distance) AS avg_distance
FROM customer_orders AS c
JOIN runner_orders AS r
 ON c.order_id = r.order_id
WHERE r.duration != 0
GROUP BY c.customer_id;

