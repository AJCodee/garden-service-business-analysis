# Garden Business Analysis (Down To Earth)

## Overview

This project analyses operational and customer data from my gardening business, Down To Earth.

The goal was to clean raw business data and extract insights to improve revenue, customer retention, and operational efficiency.
Key focus areas included identifying high-value service plans, understanding customer value, and uncovering inefficiencies such
as travel time and low-performing locations.

The final stage of this project involves building a Power BI dashboard to visualise these insights.

## Dataset

The dataset consists of two main tables:

- **Customers**: Contains customer details, service plans, and acquisition data
- **Jobs**: Contains job-level data including pricing, duration, and travel time

All data is sourced from the business.

## Data Cleaning

The raw data was cleaned and transformed using SQL, including:

- Removing duplicate records
- Standardising column formats
- Handling missing or inconsistent values
- Creating clean tables for analysis (`customers_clean`, `jobs_clean`)

This ensured the dataset was reliable for analysis and reporting.

## Tools used

- PostgreSQL
- Dbeaver
- VSCode
- Git/Github
- Power BI

## Project Structure

dashboard/

data/

- garden_customers_clean.csv
- garden_customers_raw.csv
- garden_jobs_clean.csv
- garden_jobs_raw.csv

sql/

- 01_create_tables.sql
- 02_clean_customers.sql
- 03_clean_jobs.sql
- 04_remove_duplicates.sql
- analysis/
- 01_service_plan_revenue.sql
- 02_location_efficiency.sql
- 03_travel_time_loss.sql
- 04_high_value_customers.sql

## Key Questions & Insights

### 1. Service Plan Performance

**Question:** What service plan generates the most revenue and job volume?

**Insight:** Weekly service plans generate the highest revenue and job volume,
indicating that recurring services are the primary driver of business income.

### 2. Location Efficiency

**Question:** What location generates the lowest revenue relative to time spent?

**Insight:** Poringland generates the lowest revenue per hour, suggesting lower operational
efficiency likely driven by higher travel time relative to job value.

### 3. Travel Time Cost

**Question:** Which day of the week has the highest travel time and estimated revenue lost?

**Insight:** Wednesdays have the highest travel time and estimated revenue loss,
indicating potential inefficiencies in scheduling or job clustering midweek.

### 4. Customer Value

**Question:** Who are our highest-value customers based on total revenue and job frequency?

**Insight:** A small group of customers contributes a significant share of total revenue,
highlighting the importance of retaining high-frequency, high-value clients.

## Project Status

- Data cleaning: Complete
- SQL analysis: Complete
- Power BI dashboard: In progress
