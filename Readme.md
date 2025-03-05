Customer Churn Analysis Project


 Project Overview

Customer churn is a crucial metric for businesses, as it helps identify why customers leave and what can be done to retain them. This project leverages SQL for data analysis and Power BI for visualization to uncover key insights into churn patterns, helping businesses improve customer retention strategies.

 Objectives

Analyze churn trends over time to identify patterns

Identify high-risk customer segments prone to churn

Examine the impact of subscription types on customer retention

Provide key performance indicators (KPIs) for decision-makers

Analyze customer support interactions and their correlation with churn

 Dataset

Total Records: 10,000+

Columns: Customer ID, Signup Date, Subscription Type, Payment History, Support Tickets, Churn Status, etc.

Data Source: Synthetic data generated for analysis

Storage: MySQL database

 Tech Stack

Database: MySQL

Query Language: SQL

Visualization: Power BI

Connection: MySQL direct import to Power BI

 SQL Queries & Explanations

1. Churn Rate Calculation

This query calculates the churn rate by dividing the number of churned customers by the total customer base.

SELECT COUNT(customer_id) AS churned_customers,
       COUNT(customer_id) * 100.0 / (SELECT COUNT(*) FROM customers) AS churn_rate
FROM customers
WHERE status = 'Churned';

 Insight: Helps assess overall customer attrition and measure business performance.

2. Revenue Trends by Subscription Type

SELECT subscription_type, SUM(amount) AS total_revenue
FROM transactions
GROUP BY subscription_type;

 Insight: Identifies which subscription types generate the most revenue, guiding pricing strategies.

3. Support Ticket Impact on Churn

SELECT status, COUNT(ticket_id) AS ticket_count
FROM support_tickets
GROUP BY status;

 Insight: Reveals how unresolved or pending tickets contribute to churn, emphasizing the importance of customer support.

4 Yearly Churn Trends

SELECT YEAR(signup_date) AS year, COUNT(customer_id) AS churned_customers
FROM customers
WHERE status = 'Churned'
GROUP BY YEAR(signup_date)
ORDER BY year;

 Insight: Identifies which years had the highest churn rates and possible external factors influencing it.

 Power BI Dashboard
View Interactive dashboard
https://app.powerbi.com/view?r=eyJrIjoiOGY2NjA1YjItYjc0NC00OWM2LWFiZDQtYzZlMzRkMzJlMmRjIiwidCI6ImRmODY3OWNkLWE4MGUtNDVkOC05OWFjLWM4M2VkN2ZmOTVhMCJ9

![image](https://github.com/user-attachments/assets/231b5e82-efb9-4293-b212-055057876e91)


Customer Churn Overview

Key Metrics: Churn Rate, Average Revenue Per User (ARPU)

Visuals: Churn Status Pie Chart, Yearly Churn Trends, Subscription Revenue Analysis

Insights: Identify churn hotspots & revenue distribution

Customer Support & Trends

Key Metrics: Total Revenue, Late Payments, Customer Growth

Visuals: Monthly Revenue Trends, Late Payment Summary, Support Ticket Status

Insights: Correlation between support issues, late payments, and churn

 Business Impact & Key Insights

High churn observed in Standard subscription → Need better engagement strategies

ARPU(Average Revenue Per User) is highest in Premium segment → Opportunity to upsell to lower tiers

Late payments correlate with higher churn → Payment reminders & auto-renewal can help

Support tickets with unresolved issues increase churn → Improve customer service response time

