/*
We would highlight the top-paying opportunities for Data Analysts, offering insights into employment.
What are the top-paying data analyst jobs?
Considerations: 
1. Identify the top 10 highest-paying Data Analyst roles that are available remotely.
2. Focuses on job postings with specified salaries (remove nulls).
*/

SELECT
    job_id AS ID,
    job_title AS Title,
    job_location AS Location,
    cd.name AS Company,
    job_posted_date AS Poated_Date,
    salary_year_avg AS Salary
FROM
    job_postings_fact AS jpf LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = true AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT
    10;


