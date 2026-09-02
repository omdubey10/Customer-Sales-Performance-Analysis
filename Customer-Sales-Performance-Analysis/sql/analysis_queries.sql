-- Customer Sales Performance Analysis

-- Revenue by customer segment
SELECT c.segment,
       SUM(s.quantity * p.unit_price * (1-s.discount)) AS revenue
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN products p ON s.product_id = p.product_id
GROUP BY c.segment
ORDER BY revenue DESC;

-- Top products by revenue
SELECT p.product_name,
       SUM(s.quantity * p.unit_price * (1-s.discount)) AS revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;

-- Monthly revenue
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
       ROUND(SUM(s.quantity * p.unit_price * (1-s.discount)), 2) AS revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- Highest-value customers
SELECT c.customer_name, c.segment,
       ROUND(SUM(s.quantity * p.unit_price * (1-s.discount)), 2) AS revenue
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN products p ON s.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name, c.segment
ORDER BY revenue DESC;
