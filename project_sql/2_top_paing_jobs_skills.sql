/*
We would highlight the skills of the top 10 paing Data Analyst Roles in Our Databas.
*/

WITH top_paying_jobs AS (
    SELECT
    job_id,
    job_title,
    cd.name AS Company,
    salary_year_avg
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
    10
)
SELECT
    top_paying_jobs.*,
    skills_dim.skills AS Skills
FROM
    top_paying_jobs INNER JOIN skills_job_dim
    ON top_paying_jobs.job_id = skills_job_dim.job_id INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    top_paying_jobs.salary_year_avg DESC;




