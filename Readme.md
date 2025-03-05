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

### 2. What are the top reasons for customer churn?
```sql
SELECT churn_reason, COUNT(*) AS occurrences
FROM customers
WHERE churn_status = 'Yes'
GROUP BY churn_reason
ORDER BY occurrences DESC;
```
**Insight:** Identifying the top reasons for churn helps businesses target specific issues affecting customer satisfaction.

### 3. How does tenure impact churn?
```sql
SELECT tenure_group, COUNT(*) AS churn_count
FROM (
    SELECT CASE
        WHEN tenure <= 6 THEN '0-6 months'
        WHEN tenure <= 12 THEN '7-12 months'
        WHEN tenure <= 24 THEN '1-2 years'
        ELSE '2+ years' END AS tenure_group,
        churn_status
    FROM customers
) AS tenure_data
WHERE churn_status = 'Yes'
GROUP BY tenure_group
ORDER BY churn_count DESC;
```
**Insight:** Understanding how long customers stay before churning can help develop targeted retention strategies.

### 4. Which customer segments have the highest churn rates?
```sql
SELECT customer_segment,
       (COUNT(*) / (SELECT COUNT(*) FROM customers WHERE customer_segment = c.customer_segment)) * 100 AS churn_rate
FROM customers c
WHERE churn_status = 'Yes'
GROUP BY customer_segment
ORDER BY churn_rate DESC;
```
**Insight:** Segmentation analysis highlights which groups of customers are more likely to churn.

### 5. What subscription types are most prone to churn?
```sql
SELECT subscription_type, COUNT(*) AS churn_count
FROM customers
WHERE churn_status = 'Yes'
GROUP BY subscription_type
ORDER BY churn_count DESC;
```
**Insight:** Subscription-based businesses can use this data to improve offerings and enhance customer retention.

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

