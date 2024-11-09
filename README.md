# Introduction:
This project explores the data job market, by delving into data analyst positions, examining the most demand and high-paying skills for Data Analysts, and the intersection of high demand and high paying in data analytics.

You can see all SQL queries for the project here: [project_sql folder](/project_sql/)

# Tools I Used:
To thoroughly explore the data analyst job market, I utilized the capabilities of a range of essential tools:
1. **SQL:** allowing me to query the database and explore critical insights.
2. **PostgreSQL:** database management system.
3. **Visual Studio Code:** for database management and executing SQL queries.
4. **Excel:** to create charts of the critical insights that are explored from the analysis.
5. **Git & GitHub:** for sharing my SQL scripts and analysis.

# The Analysis
Here are the queries that I employed to uncover the most crucial insights within the database.

### 1. Top Paying Data Analyst Jobs:
We would highlight the top-paying opportunities for Data Analysts, offering insights into employment.
What are the top-paying data analyst jobs?
Considerations: 
1. Identify the top 10 highest-paying Data Analyst roles that are available remotely.
2. Focuses on job postings with specified salaries (remove nulls).

```sql
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
```
![Top Paying Data Analyst Jobs](/assets/Top%20Paying%20Data%20Analyst.png)
*This 2D-Bar shows the salary of the top 10 salaries of Data Analyst jobs, generated using Microsoft Excel Spreadsheet*

### 2. Top Paying Data Analyst Jobs Skills (General):
We would highlight the skills of the top 10 paying Data Analyst Roles in Our Database.

```sql
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
```
### 3. Skills of The Top 10 Paying Data Analyst Jobs Skills (General):
In this query we would show the skills of The Top 10 Data Analyst Jobs Skills in general.

```sql
WITH skills_cte AS (
    SELECT
    sjd.job_id,
    sd.skill_id,
    sd.skills
    FROM
        skills_job_dim AS sjd INNER JOIN skills_dim AS sd
        ON sjd.skill_id = sd.skill_id
)
SELECT
    skills_cte.skills AS Skill,
    COUNT(skills_cte.job_id) AS Skill_Count
FROM
    skills_cte
WHERE
    skills_cte.job_id IN (
        SELECT
            job_id
        FROM
            job_postings_fact
        WHERE
            job_title_short = 'Data Analyst' AND
            job_work_from_home = true AND
            salary_year_avg IS NOT NULL
        ORDER BY
            salary_year_avg DESC
        LIMIT
            10
    )
GROUP BY
    skills_cte.skills
ORDER BY
    COUNT(skills_cte.job_id) DESC;
```
We Found That the Most Common Five Skills in Top Paying Jobs are:
1. **SQL:** We found that this Skill's Count is 8
2. **Python:** We found that this Skill's Count is 7
3. **Tableau:** We found that this Skill's Count is 6
4. **R:** We found that this Skill's Count is 4
5. **Snowflake:** We found that this Skill's Count is 3	

![Top Paying Jobs Skills](/assets/image001.png)
*This 2D-Bar generated using Microsoft Excel Spreadsheet*

### 4. The Most Top Skills for Data Jobs (General): 
In this query, we highlight the top five skills of data jobs that are in demand in the market. 
We found that the top 5 skills ordering descending are:
1. **SQL**
2. **Python**
3. **AWS**
4. **Azure**
5. **R**

```sql
SELECT
    sjd.skill_id AS Skill_ID,
    sd.skills AS Skill,
    COUNT(jps.job_id) AS Skill_Frequency
FROM
    job_postings_fact AS jps INNER JOIN skills_job_dim AS sjd
    ON jps.job_id = sjd.job_id INNER JOIN skills_dim as sd
    ON sjd.skill_id = sd.skill_id
GROUP BY
    sd.skills, sjd.skill_id
ORDER BY
    COUNT(sjd.job_id)  DESC
LIMIT
    5;
```
![Top Skills for Data Jobs (General)](/assets/image003.png)
*This 2D-Bar generated using Microsoft Excel Spreadsheet*

### 5. Top Demond Skills For Data Analyst Job (General):
In this query, we highlight the top five demond skills of Data Analyst job in the market. 
We found that the top 5 skills ordering descending are:
1. **SQL**
2. **Excel**
3. **Python**
4. **Tableau**
5. **Power BI**

```sql
SELECT
    sjd.skill_id AS Skill_ID,
    sd.skills AS Skill,
    COUNT(sjd.job_id) AS Skill_Frequency
FROM
    skills_job_dim AS sjd INNER JOIN skills_dim as sd
    ON sjd.skill_id = sd.skill_id
WHERE
    sjd.job_id IN (
        SELECT  
            job_id
        FROM
            job_postings_fact
        WHERE
            job_title_short = 'Data Analyst' 
    )
GROUP BY
    sd.skills, sjd.skill_id
ORDER BY
    COUNT(sjd.job_id)  DESC
LIMIT
    5;
```
Or
```sql
SELECT
    sjd.skill_id AS Skill_ID,
    sd.skills AS Skill,
    COUNT(jps.job_id) AS Skill_Frequency
FROM
    job_postings_fact AS jps INNER JOIN skills_job_dim AS sjd
    ON jps.job_id = sjd.job_id INNER JOIN skills_dim as sd
    ON sjd.skill_id = sd.skill_id
WHERE
    jps.job_title_short = 'Data Analyst' 
GROUP BY
    sd.skills, sjd.skill_id
ORDER BY
    COUNT(sjd.job_id)  DESC
LIMIT
    5;
```

![Top Demond Skills For Data Anal](/assets/image005.png)
*This 2D-Bar generated using Microsoft Excel Spreadsheet*

### 6. Top Skills of Remote Data Analyst Jobs:
In this query, we highlight the top five demand skills of Data Analyst jobs for Remote (Freelancing Data Analyst).
We found that the top 5 skills ordering descending are:
1. **SQL**
2. **Excel**
3. **Python**
4. **Tableau**
5. **Power BI**

```sql
SELECT
    sjd.skill_id AS Skill_ID,
    sd.skills AS Skill,
    COUNT(jps.job_id) AS Skill_Frequency
FROM
    job_postings_fact AS jps INNER JOIN skills_job_dim AS sjd
    ON jps.job_id = sjd.job_id INNER JOIN skills_dim as sd
    ON sjd.skill_id = sd.skill_id
WHERE
    jps.job_title_short = 'Data Analyst' AND
    jps.job_work_from_home = true
GROUP BY
    sd.skills, sjd.skill_id
ORDER BY
    COUNT(sjd.job_id)  DESC
LIMIT
    5;
```
![Top Skills of Remote Data Analyst Jobs](/assets/image007.png)
*This 2D-Bar generated using Microsoft Excel Spreadsheet*

### 7. Top Average Salary Skills For Data Analyst:
This query shows some insights into trends based on the top-paying skills for data analysts, 
and also shows the overlapping between Data Analysts skills with Data Engineers and Data Scientists:
1. **Big Data & Machine Learning:** Demand for skills like PySpark, Databricks, 
and Scikit-learn reflects a need for expertise in big data processing and machine learning.
2. **Cloud & Automation:** Proficiency in GCP, Kubernetes, and Jenkins highlights the importance of cloud platforms, 
containerization, and automation in data analysis workflows.
3. **Collaboration & Specialized Tools:** Skills in Bitbucket, Atlassian, and Microstrategy indicate a focus on collaboration, 
version control, and specialized analytics platforms in high-paying data analyst roles.

These trends showcase the diverse skill sets and technologies that are highly valued in the data analysis field, reflecting the evolving landscape of data-driven decision-making in various industries.

```sql
SELECT
    sd.skill_id AS Skill_ID,
    sd.skills AS Skill,
    FLOOR(AVG(jpf.salary_year_avg)) AS Average_Salary
FROM
    job_postings_fact AS jpf INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = true AND
    salary_year_avg IS NOT NULL
GROUP BY
    sd.skills, sd.skill_id 
ORDER BY
    AVG(jpf.salary_year_avg) DESC
LIMIT
    25;
```

This next query shows that the skill pyspark appears twice according to our conditions:
1. The job title is Data Analyst.
2. Work from home is true.
3. Average year salary is not null.
From this query we can calculate the average salary for all Data Analyst jobs using this this skill: 160515.0 + 255829.5 = 208172
Which is the result in the first row in the last query of the file.

```sql
SELECT
    sd.skills,
    jpf.salary_year_avg
FROM
    job_postings_fact AS jpf INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Analyst' AND
    jpf.job_work_from_home = true AND
    jpf.salary_year_avg IS NOT NULL AND
    sd.skills = 'pyspark';

```

### 8. Combine Between Top Demand Skills Top Paying Skills:
In this query, we will show what the most optimal skills to learn (aka it’s in high demand and a high-paying skill), 
to know top_demond_skills.Demond_Count DESC, 
Conditions:
1. Identify skills in high demand and associated with high average salaries for Data Analyst roles.
2. Concentrate on remote positions with specified salaries.
Note that jpf.salary_year_avg IS NOT NULL.

```sql
WITH top_demand_skills AS (
    SELECT
        sjd.skill_id AS ID,
        sd.skills AS Skill,
        COUNT(jpf.job_id) AS Demand_Count
    FROM
        job_postings_fact AS jpf INNER JOIN skills_job_dim AS sjd
        ON jpf.job_id = sjd.job_id INNER JOIN skills_dim AS sd
        ON sjd.skill_id = sd.skill_id
    WHERE
        jpf.job_title_short = 'Data Analyst' AND
        jpf.job_work_from_home = true AND
        jpf.salary_year_avg IS NOT NULL
    GROUP BY
        sjd.skill_id, sd.skills
),
top_paying_skills AS (
    SELECT
        sjd.skill_id AS ID,
        sd.skills AS Skill,
        FLOOR(AVG(salary_year_avg)) AS Averge_Salary    
    FROM
        job_postings_fact AS jpf INNER JOIN skills_job_dim AS sjd
        ON jpf.job_id = sjd.job_id INNER JOIN skills_dim AS sd
        ON sjd.skill_id = sd.skill_id
    WHERE
        jpf.job_title_short = 'Data Analyst' AND
        jpf.job_work_from_home = true AND
        jpf.salary_year_avg IS NOT NULL
    GROUP BY
        sjd.skill_id, sd.skills
)
SELECT
    top_demand_skills.ID,
    top_paying_skills.Skill,
    top_demand_skills.Demand_Count,
    top_paying_skills.Averge_Salary
FROM
   top_demand_skills INNER JOIN top_paying_skills
   ON top_demand_skills.ID = top_paying_skills.ID
WHERE
    top_demand_skills.Demand_Count > 10
ORDER BY
    top_paying_skills.Averge_Salary DESC,
    top_demand_skills.Demand_Count DESC
LIMIT
    25;
```
Or simplify the last query:

```sql
SELECT
    sjd.skill_id AS Skill_Id,
    sd.skills AS Skill,
    COUNT(jpf.job_id) AS Job_Demand,
    FLOOR(AVG(jpf.salary_year_avg)) AS Average_Salary
FROM
    job_postings_fact AS jpf INNER JOIN skills_job_dim AS sjd 
    ON jpf.job_id = sjd.job_id INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Analyst' AND
    jpf.job_work_from_home = true AND
    jpf.salary_year_avg IS NOT NULL
GROUP BY
    sjd.skill_id, sd.skills
HAVING
    COUNT(jpf.job_id) > 10
ORDER BY
    Average_Salary DESC,
    Job_Demand DESC
LIMIT
    25;
```

![Top Demand Skills For Data Analysis](/assets/image009.png)
*This 2D-Bar generated using Microsoft Excel Spreadsheet*

![Top Average Salary Paying Skills](/assets/image011.png)
*This 2D-Line generated using Microsoft Excel Spreadsheet*

# Conclusion
Based on the insights gathered from the queries created, here are the key conclusions drawn regarding the data analyst job market:

- I identified and focused on the top 10 highest-paying remote Data Analyst roles with specified salaries, excluding nulls.
- I highlight the skills required for the top 10 highest-paying Data Analyst roles in the database.
- The most common skills in the top-paying jobs include SQL, Python, Tableau, R, and Snowflake.
- The top five skills in demand for data jobs are SQL, Python, AWS, Azure, and R.
- The top five demanded skills for Data Analyst roles are SQL, Excel, Python, Tableau, and Power BI.
- I focused on the top five in-demand skills for Remote Data Analyst positions, with SQL, Excel, Python, Tableau, and Power BI being prominent.
- Trends indicate a need for skills in Big Data & Machine Learning, Cloud & Automation, and Collaboration & Specialized Tools for high-paying Data Analyst roles, reflecting the evolving data landscape.
- I combined Top Demand Skills with Top Paying Skills, by identifying skills that are both in high demand and offer high average salaries for Data Analyst roles, specifically focusing on remote positions with specified salaries.

These insights collectively provide a comprehensive overview of the skills, roles, and market dynamics within the data analyst domain, offering valuable guidance for individuals looking to excel in this field.