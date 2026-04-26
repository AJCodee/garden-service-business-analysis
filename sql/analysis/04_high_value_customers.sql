-- Q4: Who are our highest-value customers based on total revenue and job frequency?

WITH customer_jobs AS (
    SELECT
        jc.customer_id,
        cc.customer_name,
        jc.price_gbp,
        jc.travel_time_mins
    FROM jobs_clean jc
    JOIN customers_clean cc
        ON jc.customer_id = cc.customer_id
)
SELECT
    customer_id,
    customer_name,
    COUNT(*) AS total_jobs_done,
    ROUND(SUM(price_gbp), 2) AS total_revenue,
    ROUND(AVG(price_gbp), 2) AS avg_price,
    ROUND(AVG(travel_time_mins), 2) AS avg_travel_time
FROM customer_jobs
GROUP BY customer_id, customer_name
ORDER BY total_revenue DESC
LIMIT 10;

-- Insight: A small group of customers contributes a significant share of total revenue, 
-- highlighting the importance of retaining high-frequency, high-value clients.