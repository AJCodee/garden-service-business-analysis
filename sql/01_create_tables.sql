-- Data imported via DBeaver from CSV files into raw tables

-- Create customers raw table
CREATE TABLE customers_raw (
    customer_id VARCHAR,
    customer_name VARCHAR,
    signup_date VARCHAR,
    location VARCHAR,
    postcode_area VARCHAR,
    service_plan VARCHAR,
    preferred_day VARCHAR,
    preferred_time VARCHAR,
    status VARCHAR,
    property_size VARCHAR,
    acquisition_channel VARCHAR,
    notes VARCHAR
);

-- Create jobs raw table
CREATE TABLE jobs_raw (
    job_id VARCHAR,
    customer_id VARCHAR,
    job_date VARCHAR,
    scheduled_start VARCHAR,
    scheduled_end VARCHAR,
    job_type VARCHAR,
    job_duration_mins VARCHAR,
    travel_time_mins VARCHAR,
    distance_miles VARCHAR,
    price_gbp VARCHAR,
    hourly_rate_gbp VARCHAR,
    payment_method VARCHAR,
    location VARCHAR,
    notes VARCHAR
);

-- Create staging tables
CREATE TABLE customers_stg AS
SELECT * FROM customers_raw;

CREATE TABLE jobs_stg AS
SELECT * FROM jobs_raw;