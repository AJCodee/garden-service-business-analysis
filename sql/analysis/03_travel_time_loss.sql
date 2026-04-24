-- Q3: Which day of the week has the highest travel time and estimated revenue lost?

SELECT
    EXTRACT(DOW FROM job_date) AS day_number,
    TO_CHAR(job_date, 'FMDay') AS day_of_week,
    SUM(travel_time_mins) AS total_travel_time_mins,
    ROUND(
        SUM((travel_time_mins / 60.0) * hourly_rate_gbp),
        2
    ) AS estimated_revenue_lost
FROM jobs_clean
GROUP BY
    EXTRACT(DOW FROM job_date),
    TO_CHAR(job_date, 'FMDay')
ORDER BY estimated_revenue_lost DESC;