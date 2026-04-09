-- Cleaning the jobs table

-- Standardise core text columns by trimming spaces and fixing IDs
UPDATE jobs_stg
SET 
    job_id = UPPER(TRIM(job_id)),
    customer_id = UPPER(TRIM(REPLACE(customer_id, '-', ''))),
    job_type = LOWER(TRIM(REPLACE(job_type, '-', ''))),
    payment_method = LOWER(TRIM(payment_method)),
    location = INITCAP(TRIM(location));

-- Standardise job type values
UPDATE jobs_stg
SET job_type = CASE
    WHEN job_type LIKE '%cut%' OR job_type LIKE '%mow%' THEN 'Grass Cut'
    WHEN job_type LIKE '%hedge%' THEN 'Hedge Trim'
    WHEN job_type LIKE '%weed%' OR job_type LIKE '%tidy%' THEN 'Weed and Tidy'
    WHEN job_type LIKE '%jet%' OR job_type LIKE '%pressure%' THEN 'Pressure Wash'
    WHEN job_type LIKE '%leaf%' OR job_type LIKE '%leaves%' THEN 'Leaf Clearance'
    ELSE INITCAP(job_type)
END;

-- Standardise payment method values
UPDATE jobs_stg
SET payment_method = CASE 
    WHEN payment_method LIKE 'ba%' OR payment_method LIKE 'bank xfer%' OR payment_method LIKE 'bacs%' THEN 'Bank Transfer' 
    WHEN payment_method LIKE '%card%' THEN 'Debit Card'
    WHEN payment_method LIKE 'ca%' THEN 'Cash'
    ELSE INITCAP(payment_method)
END;

-- Drop unnecessary notes column
ALTER TABLE jobs_stg
DROP COLUMN notes;

-- Standardise location values
UPDATE jobs_stg
SET location = CASE 
    WHEN location LIKE 'Cas%' THEN 'Caston'
    WHEN location LIKE 'Sah%' THEN 'Saham Toney'
    WHEN location LIKE 'Nor%' THEN 'Norwich'
    WHEN location LIKE 'Attle%' THEN 'Attleborough'
    WHEN location LIKE 'Hing%' THEN 'Hingham'
    WHEN location LIKE 'Der%' THEN 'Dereham'
    WHEN location LIKE 'Heth%' THEN 'Hethersett'
    WHEN location LIKE 'Ash%' THEN 'Ashwellthorpe'
    WHEN location LIKE 'Wym%' THEN 'Wymondham'
    WHEN location LIKE 'Por%' THEN 'Poringland'
    ELSE location 
END;

-- Convert mixed job_date formats into a clean DATE value
UPDATE jobs_stg
SET job_date = CASE
    WHEN job_date ~ '^\d{2}/\d{2}/\d{4}$' THEN TO_DATE(job_date, 'DD/MM/YYYY')
    WHEN job_date ~ '^\d{4}/\d{2}/\d{2}$' THEN TO_DATE(job_date, 'YYYY/MM/DD')
    WHEN job_date ~ '^\d{4}-\d{2}-\d{2}$' THEN TO_DATE(job_date, 'YYYY-MM-DD')
    WHEN job_date ~ '^\d{2}-\d{2}-\d{4}$' THEN TO_DATE(job_date, 'DD-MM-YYYY')
    WHEN job_date ~ '^[A-Za-z]{3} \d{1,2} \d{4}$' THEN TO_DATE(job_date, 'Mon DD YYYY')
    WHEN job_date ~ '^\d{1,2} [A-Za-z]{3} \d{4}$' THEN TO_DATE(job_date, 'DD Mon YYYY')
    WHEN job_date ~ '^[A-Za-z]+ \d{1,2} \d{4}$' THEN TO_DATE(job_date, 'Month DD YYYY')
    ELSE NULL::DATE
END;

-- Remove non-numeric characters from duration and travel columns
UPDATE jobs_stg
SET 
    job_duration_mins = REGEXP_REPLACE(job_duration_mins, '[^0-9]', '', 'g'),
    travel_time_mins = REGEXP_REPLACE(travel_time_mins, '[^0-9]', '', 'g'),
    distance_miles = REGEXP_REPLACE(distance_miles, '[^0-9\.]', '', 'g');

-- Convert numeric columns to the correct datatypes
ALTER TABLE jobs_stg
ALTER COLUMN job_duration_mins TYPE INTEGER
USING job_duration_mins::INTEGER;

ALTER TABLE jobs_stg
ALTER COLUMN travel_time_mins TYPE INTEGER
USING travel_time_mins::INTEGER;

ALTER TABLE jobs_stg
ALTER COLUMN distance_miles TYPE NUMERIC(5,2)
USING distance_miles::NUMERIC(5,2);

ALTER TABLE jobs_stg
ALTER COLUMN price_gbp TYPE NUMERIC(10,2)
USING price_gbp::NUMERIC(10,2);