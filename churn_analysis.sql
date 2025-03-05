-- Use the churn database
USE churn_db;

-- Check for Missing Values
SELECT 
    'customers' AS table_name, COUNT(*) AS missing_values 
FROM customers WHERE customer_name IS NULL
UNION
SELECT 
    'subscriptions', COUNT(*) 
FROM subscriptions WHERE subscription_type IS NULL
UNION
SELECT 
    'transactions', COUNT(*) 
FROM transactions WHERE amount IS NULL;

-- Remove Duplicate Transactions
DELETE t1 FROM transactions t1
INNER JOIN transactions t2 
ON t1.transaction_id > t2.transaction_id 
AND t1.customer_id = t2.customer_id 
AND t1.transaction_date = t2.transaction_date 
AND t1.amount = t2.amount;

-- Exploratory Data Analysis (EDA)
-- Total Customers & Churn Rate
CREATE TABLE IF NOT EXISTS churn_summary AS
SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN status = 'Churned' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN status = 'Churned' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customers;

select * from churn_summary;

-- Monthly Revenue Trends
CREATE TABLE IF NOT EXISTS revenue_trends AS
SELECT 
    DATE_FORMAT(transaction_date, '%Y-%m') AS month, 
    SUM(amount) AS total_revenue 
FROM transactions 
GROUP BY month 
ORDER BY month;

select * from revenue_trends;

-- Churn by Subscription Type
CREATE TABLE IF NOT EXISTS churn_by_subscription AS
SELECT 
    s.subscription_type, 
    COUNT(c.customer_id) AS total_customers,
    SUM(CASE WHEN c.status = 'Churned' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN c.status = 'Churned' THEN 1 ELSE 0 END) * 100.0 / COUNT(c.customer_id), 2) AS churn_rate
FROM customers c
JOIN subscriptions s ON c.customer_id = s.customer_id
GROUP BY s.subscription_type;

select * from churn_by_subscription;

-- Customer Segmentation & Insights
-- High-Risk Customers (Late Payments)
CREATE TABLE IF NOT EXISTS high_risk_customers AS
SELECT customer_id, COUNT(*) AS late_payments 
FROM transactions 
WHERE transaction_date > DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY customer_id
HAVING late_payments < 2;

select * from high_risk_customers;

-- Top 10 Customers by Revenue
CREATE TABLE IF NOT EXISTS top_customers AS
SELECT customer_id, SUM(amount) AS total_spent
FROM transactions
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

select * from top_customers;

-- Churn Prediction
-- Label Customers as Churned
CREATE TABLE IF NOT EXISTS churn_predictions AS
SELECT customer_id, 
       MAX(transaction_date) AS last_transaction,
       CASE 
           WHEN MAX(transaction_date) < DATE_SUB(CURDATE(), INTERVAL 6 MONTH) THEN 'Churned'
           ELSE 'Active' 
       END AS churn_status
FROM transactions
GROUP BY customer_id;

select * from churn_predictions;

-- Factors Causing Churn
CREATE TABLE IF NOT EXISTS churn_factors AS
SELECT c.customer_id, c.status, s.subscription_type, COUNT(st.ticket_id) AS support_tickets
FROM customers c
LEFT JOIN subscriptions s ON c.customer_id = s.customer_id
LEFT JOIN support_tickets st ON c.customer_id = st.customer_id
WHERE c.status = 'Churned'
GROUP BY c.customer_id, c.status, s.subscription_type;

select * from churn_factors;

-- Final Report & Visualization Tables
-- Summary Report of Churned vs Active Customers
CREATE TABLE IF NOT EXISTS churn_status_summary AS
SELECT status, COUNT(*) AS total_customers 
FROM customers 
GROUP BY status;

select * from churn_status_summary;

-- Monthly Churn Rate Trend
CREATE TABLE IF NOT EXISTS monthly_churn AS
SELECT 
    DATE_FORMAT(end_date, '%Y-%m') AS churn_month,
    COUNT(*) AS churned_customers
FROM subscriptions
WHERE end_date IS NOT NULL
GROUP BY churn_month
ORDER BY churn_month;

select * from monthly_churn;
