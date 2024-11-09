/*
Date Functions in SQL: Used to perform operations on date and time values.
:: Used for casting, which means converting a value from one data type to another • You can use it to convert a host of different data types.
Date Format: YYYY-MM-DD (Example: 2024-02-06).
*/

SELECT 
    '2023-02-19'::DATE,
    '123' ::INT,
    'true' ::BOOLEAN,
    '3.14' ::NUMERIC;

-- :: DATE: Converts to a date format by removing the time portion.

SELECT  
    job_title_short AS Title,
    job_location AS Location,
    job_posted_date::DATE AS Date
FROM
    job_postings_fact;

/*
Timestamp: specify date and time without time zone, (YYYY-MM-DD HH-MI-SS) (2023-06-04 17:27:58).
TIMESTAMP WITH TIME ZONE: A specific date and time with time zone information: 2024-02-06 15:04:05+00:00, like TIMESTAMP, but includes time zone information.
AT TIME ZONE: converts timestamps between different time zones, it can be used on timestamps with or without time zone information,
so it converts the UTC (Coordinated Universal Time (UTC) is the primary time standard globally used to regulate clocks and time. 
It establishes a reference for the current time, forming the basis for civil time and time zones) to the specified time zone correctly.
*/

SELECT  
    job_title_short AS Title,
    job_location AS Location,
    job_posted_date AT TIME ZONE 'UTC' AS Date
FROM
    job_postings_fact
LIMIT
    5;

SELECT  
    job_title_short AS Title,
    job_location AS Location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS Date
FROM
    job_postings_fact
LIMIT
    5;

SELECT  
    job_title_short AS Title,
    job_location AS Location,
    job_posted_date AT TIME ZONE 'EST' AS Date
FROM
    job_postings_fact
LIMIT
    5;

-- EXTRACT: Gets specific date parts (e.g., year, month, day) from a date or time value.
SELECT
    job_posted_date ::DATE,
    EXTRACT(YEAR FROM job_posted_date) AS year_date,
    EXTRACT(MONTH FROM job_posted_date) AS month_date,
    EXTRACT(DAY FROM job_posted_date) AS day_date
FROM
    job_postings_fact
LIMIT;

SELECT
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS job_posted_month
FROM
	job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    job_posted_month
ORDER BY
    job_posted_count DESC;

