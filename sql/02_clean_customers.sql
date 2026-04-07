-- Cleaning the customers table

-- Standardise customer IDs by trimming spaces, removing dashes, and uppercasing
UPDATE customers_stg
SET customer_id = UPPER(TRIM(REPLACE(customer_id, '-', '')));

-- Standardise text columns by trimming spaces and converting to lowercase
UPDATE customers_stg
SET 
    location = LOWER(TRIM(location)),
    service_plan = LOWER(TRIM(service_plan)),
    preferred_day = LOWER(TRIM(preferred_day)),
    status = LOWER(TRIM(status)),
    property_size = LOWER(TRIM(property_size)),
    acquisition_channel = LOWER(TRIM(acquisition_channel));

-- Standardise preferred day values
UPDATE customers_stg
SET preferred_day = CASE 
    WHEN preferred_day LIKE 'mon%' THEN 'Monday'
    WHEN preferred_day LIKE 'tue%' THEN 'Tuesday'
    WHEN preferred_day LIKE 'wed%' THEN 'Wednesday'
    WHEN preferred_day LIKE 'thu%' THEN 'Thursday'
    WHEN preferred_day LIKE 'fri%' THEN 'Friday'
    ELSE INITCAP(preferred_day)
END;

-- Standardise acquisition channel values
UPDATE customers_stg
SET acquisition_channel = CASE 
    WHEN acquisition_channel LIKE 'goo%' THEN 'Google Search'
    WHEN acquisition_channel LIKE 'face%' THEN 'Facebook'
    WHEN acquisition_channel LIKE '%boa%' THEN 'Board'
    WHEN acquisition_channel LIKE 'rep%' THEN 'Repeat'
    WHEN acquisition_channel LIKE 'ref%' THEN 'Referral'
    WHEN acquisition_channel LIKE 'word%' THEN 'Word Of Mouth'
    ELSE INITCAP(acquisition_channel)
END;

-- Convert mixed signup_date formats into a clean DATE column
UPDATE customers_stg
SET signup_date_clean = CASE
    WHEN signup_date ~ '^\d{2}/\d{2}/\d{4}$'
        THEN TO_DATE(signup_date, 'DD/MM/YYYY')
    WHEN signup_date ~ '^\d{4}/\d{2}/\d{2}$'
        THEN TO_DATE(signup_date, 'YYYY/MM/DD')
    WHEN signup_date ~ '^\d{4}-\d{2}-\d{2}$'
        THEN TO_DATE(signup_date, 'YYYY-MM-DD')
    WHEN signup_date ~ '^\d{2}-\d{2}-\d{4}$'
        THEN TO_DATE(signup_date, 'DD-MM-YYYY')
    WHEN signup_date ~ '^[A-Za-z]{3} \d{1,2} \d{4}$'
        THEN TO_DATE(signup_date, 'Mon DD YYYY')
    WHEN signup_date ~ '^\d{1,2} [A-Za-z]{3} \d{4}$'
        THEN TO_DATE(signup_date, 'DD Mon YYYY')
    WHEN signup_date ~ '^[A-Za-z]+ \d{1,2} \d{4}$'
        THEN TO_DATE(signup_date, 'Month DD YYYY')
    ELSE NULL::DATE
END;

-- Convert mixed preferred_time formats into a clean TIME column
UPDATE customers_stg
SET preffered_time_clean = CASE
    WHEN TRIM(preferred_time) ~ '^\d{1,2}:\d{2}$' THEN
        TRIM(preferred_time)::TIME
    WHEN TRIM(preferred_time) ~ '^\d{1,2}\.\d{2}$' THEN
        REPLACE(TRIM(preferred_time), '.', ':')::TIME
    WHEN TRIM(preferred_time) ~ '^\d{4}$' THEN
        (LEFT(TRIM(preferred_time), 2) || ':' || RIGHT(TRIM(preferred_time), 2))::TIME
    WHEN LOWER(TRIM(preferred_time)) ~ '^\d{1,2}(am|pm)$' THEN
        TO_TIMESTAMP(LOWER(TRIM(preferred_time)), 'HH12am')::TIME
    WHEN LOWER(TRIM(preferred_time)) ~ '^\d{1,2}:\d{2}\s?(am|pm)$' THEN
        TO_TIMESTAMP(REPLACE(LOWER(TRIM(preferred_time)), ' ', ''), 'HH12:MIam')::TIME
END;

-- Replace null property sizes with 'unknown'
UPDATE customers_stg
SET property_size = CASE 
    WHEN property_size IS NULL THEN 'unknown'
    ELSE property_size
END;

-- Drop unnecessary notes column
ALTER TABLE customers_stg
DROP COLUMN notes;