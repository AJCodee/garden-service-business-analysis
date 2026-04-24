-- Q2: What location generates the lowest revenue relative to time spent?

SELECT
    location,
    COUNT(*) AS total_jobs,
    ROUND(SUM(price_gbp), 2) AS total_revenue,
    ROUND(AVG(price_gbp), 2) AS avg_revenue_per_job,
    ROUND(AVG(travel_time_mins), 2) AS avg_travel_time,
    ROUND(
        SUM(price_gbp) / SUM((job_duration_mins + travel_time_mins) / 60.0),
        2
    ) AS revenue_per_hour
FROM jobs_clean
GROUP BY location
ORDER BY revenue_per_hour ASC;