-- Remove duplicate records from the jobs staging table
-- A duplicate is defined as a row with the same customer, date, job type,
-- duration, travel time, distance, price, hourly rate, payment method, and location.

BEGIN;

-- Preview duplicate rows before deletion
WITH duplicates AS (
    SELECT
        ctid,
        customer_id,
        job_date,
        job_type,
        job_duration_mins,
        travel_time_mins,
        distance_miles,
        price_gbp,
        hourly_rate_gbp,
        payment_method,
        location,
        ROW_NUMBER() OVER (
            PARTITION BY
                customer_id,
                job_date,
                job_type,
                job_duration_mins,
                travel_time_mins,
                distance_miles,
                price_gbp,
                hourly_rate_gbp,
                payment_method,
                location
            ORDER BY job_id
        ) AS row_num
    FROM jobs_stg
)
SELECT *
FROM duplicates
WHERE row_num > 1
ORDER BY customer_id, job_date, job_type;

-- Delete duplicate rows while keeping the first occurrence
WITH duplicates AS (
    SELECT
        ctid,
        ROW_NUMBER() OVER (
            PARTITION BY
                customer_id,
                job_date,
                job_type,
                job_duration_mins,
                travel_time_mins,
                distance_miles,
                price_gbp,
                hourly_rate_gbp,
                payment_method,
                location
            ORDER BY job_id
        ) AS row_num
    FROM jobs_stg
)
DELETE FROM jobs_stg
WHERE ctid IN (
    SELECT ctid
    FROM duplicates
    WHERE row_num > 1
);

COMMIT;