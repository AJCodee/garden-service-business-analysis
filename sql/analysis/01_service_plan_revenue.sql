-- Q1: What service plan generates the most revenue and job volume?

SELECT 
    cc.service_plan,
    COUNT(*) AS total_jobs,
    ROUND(SUM(jc.price_gbp), 2) AS total_revenue
FROM customers_clean cc
JOIN jobs_clean jc 
    ON cc.customer_id = jc.customer_id
GROUP BY cc.service_plan
ORDER BY total_revenue DESC;

-- Insight: Weekly service plans generate the highest revenue and job volume, 
-- indicating that recurring services are the primary driver of business income.