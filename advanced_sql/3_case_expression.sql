/*
A CASE Expression in SQL is a way to apply conditional logic within your SQL queries.
In MySQL, the CASE statement is a powerful conditional expression that provides if-then-else type logic within SQL queries. It allows you to perform conditional logic within a query and return different values based on specified conditions.
*/

SELECT
    CASE
        WHEN column_name = 'Valuel' THEN 'Description for Valuel' 
        WHEN column_name 'Value2' THEN 'Description for Value2' 
        ELSE 'Other'
    END AS column description
FROM
    table_name;

/*
CASE: begins the expression.
WHEN: specifies the condition(s) to look at.
THEN: what to do when the condition is TRUE.
ELSE: (optional) provides output if none of the WHEN conditions (FALSE) are met.
END: concludes (end) the CASE expression.
The SQL query for case expression works on MySQL and PostgreSQL. 
However, the syntax for CASE statements can vary slightly between different SQL database systems.
In Microsoft SQL Server, the CASE statement is also supported, but the syntax is slightly different compared to MySQL and PostgreSQL.
 In SQL Server, you typically use END instead of AS to close the CASE statement.
*/

SELECT
    job_title_short,
    job_location,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'On-Site'
    END AS location_category
FROM
    job_postings_fact;

SELECT
    COUNT(job_id) AS Number_of_Jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'On-Site'
    END AS Location_Category
FROM
    job_postings_fact
GROUP BY
    Location_Category;

SELECT
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'On-Site'
    END AS Location_Category,
    COUNT(job_id) AS Number_of_Jobs
FROM
    job_postings_fact
GROUP BY
    Location_Category
ORDER BY
    Number_of_Jobs DESC;

-- "location_category","number_of_jobs"
-- "On-Site","709887"
-- "Remote","69606"
-- "Local","8193"

SELECT
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'On-Site'
    END AS Location_Category,
    COUNT(job_id) AS Number_of_Jobs
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    Location_Category
ORDER BY
    Number_of_Jobs DESC;

-- "location_category","number_of_jobs"
-- "On-Site","180224"
-- "Remote","13331"
-- "Local","3038"
