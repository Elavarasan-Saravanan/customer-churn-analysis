# Customer Churn Analysis Project

## Tools Used:
- MySQL
- Power BI

## Dataset Used:
Customer churn dataset from [your data source]

## Business Problem:
Customer churn is a significant challenge for businesses, leading to revenue loss and increased acquisition costs. The objective of this analysis is to understand customer churn patterns, identify key factors contributing to churn, and derive actionable insights that can help businesses retain customers.

## Approach to Solving the Problem:
To address the business problem, I utilized MySQL for data extraction and analysis. By leveraging SQL queries, I identified trends, patterns, and key metrics such as churn rates, customer demographics, and usage behavior. Additionally, I visualized the findings in Power BI to create an interactive dashboard that enables businesses to explore churn trends and take informed actions to improve retention.

## Questions Answered with SQL Analysis:

### 1. What is the overall churn rate?
```sql
SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN status = 'Churned' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN status = 'Churned' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customers;
```
**Result:** ![image](https://github.com/user-attachments/assets/bce1cc70-03a8-4e18-8163-b92cff9c869f)

**Insight:** The overall churn rate provides an overview of customer retention challenges and helps assess the scale of churn.

### 2. What are the monthly revenue trends?
```sql

SELECT
    DATE_FORMAT(transaction_date, '%Y-%m') AS month,
    SUM(amount) AS total_revenue
FROM transactions
GROUP BY month
ORDER BY month;

```
**Result:** ![image](https://github.com/user-attachments/assets/bc304b78-577d-4f94-90b0-c00cf78d3ae9)

#### Insight:
This query helps track revenue trends over time, identifying peak months and periods of revenue decline. This can assist in understanding seasonal patterns or the impact of business strategies.

---
### 3. How does churn vary by subscription type?
```sql
SELECT
    s.subscription_type,
    COUNT(c.customer_id) AS total_customers,
    SUM(CASE WHEN c.status = 'Churned' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN c.status = 'Churned' THEN 1 ELSE 0 END) * 100.0 / COUNT(c.customer_id), 2) AS churn_rate
FROM customers c
JOIN subscriptions s ON c.customer_id = s.customer_id
GROUP BY s.subscription_type;

```
**Result:** ![image](https://github.com/user-attachments/assets/89272e9e-b169-454c-8f19-473c7c85f9bf)

#### Insight:
Different subscription types may have varying churn rates. Identifying high-churn subscription types can help businesses tailor retention strategies and improve service offerings.

---
### 4. Which customers are at high risk due to late payments?
```sql
SELECT customer_id, COUNT(*) AS late_payments
FROM transactions
WHERE transaction_date > DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY customer_id
HAVING late_payments < 2;

```
**Result:** ![image](https://github.com/user-attachments/assets/cfa6af55-3e92-4534-a5b8-746cc5a7ef23)

#### Insight:
Customers with frequent late payments are at higher risk of churn. Identifying these customers allows businesses to implement proactive engagement strategies to retain them.

---
### 5. Who are the top 10 customers by revenue?
```sql
SELECT customer_id, SUM(amount) AS total_spent
FROM transactions
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

```
**Result:** ![image](https://github.com/user-attachments/assets/228bae03-f62f-497f-9b54-5ec6a2eb4cf6)

#### Insight:
Understanding the top revenue-generating customers helps businesses focus on retaining their most valuable customers and providing them with personalized services.

---
### 6. How can we predict churned customers?
```sql
SELECT customer_id,
       MAX(transaction_date) AS last_transaction,
       CASE
           WHEN MAX(transaction_date) < DATE_SUB(CURDATE(), INTERVAL 6 MONTH) THEN 'Churned'
           ELSE 'Active'
       END AS churn_status
FROM transactions
GROUP BY customer_id;

```
**Result:** ![image](https://github.com/user-attachments/assets/a29a67ee-7555-42ee-8b3f-98a7bfbf2b24)

#### Insight:
Predicting potential churn based on transaction activity allows businesses to take preventive actions before customers leave.

---
### 7. What are the key factors contributing to churn?
```sql
SELECT c.customer_id, c.status, s.subscription_type, COUNT(st.ticket_id) AS support_tickets
FROM customers c
LEFT JOIN subscriptions s ON c.customer_id = s.customer_id
LEFT JOIN support_tickets st ON c.customer_id = st.customer_id
WHERE c.status = 'Churned'
GROUP BY c.customer_id, c.status, s.subscription_type;

```
**Result:** ![image](https://github.com/user-attachments/assets/c7d946c1-29ad-497a-91c7-038da0d24c93)

#### Insight:
By analyzing the number of support tickets and subscription types for churned customers, we can identify common issues leading to customer dissatisfaction. A high number of support tickets may indicate unresolved customer complaints or technical difficulties.

## Power BI Dashboard:
The findings from the SQL analysis are visualized using Power BI, allowing for:
- Interactive exploration of churn trends
- Dynamic filtering by customer demographics and subscription types
- Identification of key churn drivers and risk factors

(Screenshots to be added here)

## Conclusion:
By analyzing customer churn data, this project provides valuable insights into customer behavior and key factors influencing churn. The findings can be used to implement data-driven retention strategies, improve customer satisfaction, and enhance business profitability.

## Next Steps:
- Implement machine learning models to predict customer churn
- Develop personalized retention campaigns based on insights
- Continuously update the dashboard with real-time data

---
*This project showcases my ability to perform SQL-based data analysis and create impactful visualizations in Power BI.*

