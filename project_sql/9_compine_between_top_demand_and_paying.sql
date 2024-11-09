/*
In this query, we will show what are the most optimal skills to learn (aka it’s in high demand and a high-paying skill), 
to know top_demond_skills.Demond_Count DESC, 
Conditions:
1. Identify skills in high demand and associated with high average salaries for Data Analyst roles.
2. Concentrate on remote positions with specified salaries.
*/

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

/*
[
  {
    "id": 8,
    "skill": "go",
    "demond_count": "27",
    "averge_salary": "115319"
  },
  {
    "id": 234,
    "skill": "confluence",
    "demond_count": "11",
    "averge_salary": "114209"
  },
  {
    "id": 97,
    "skill": "hadoop",
    "demond_count": "22",
    "averge_salary": "113192"
  },
  {
    "id": 80,
    "skill": "snowflake",
    "demond_count": "37",
    "averge_salary": "112947"
  },
  {
    "id": 74,
    "skill": "azure",
    "demond_count": "34",
    "averge_salary": "111225"
  },
  {
    "id": 77,
    "skill": "bigquery",
    "demond_count": "13",
    "averge_salary": "109653"
  },
  {
    "id": 76,
    "skill": "aws",
    "demond_count": "32",
    "averge_salary": "108317"
  },
  {
    "id": 4,
    "skill": "java",
    "demond_count": "17",
    "averge_salary": "106906"
  },
  {
    "id": 194,
    "skill": "ssis",
    "demond_count": "12",
    "averge_salary": "106683"
  },
  {
    "id": 233,
    "skill": "jira",
    "demond_count": "20",
    "averge_salary": "104917"
  },
  {
    "id": 79,
    "skill": "oracle",
    "demond_count": "37",
    "averge_salary": "104533"
  },
  {
    "id": 185,
    "skill": "looker",
    "demond_count": "49",
    "averge_salary": "103795"
  },
  {
    "id": 2,
    "skill": "nosql",
    "demond_count": "13",
    "averge_salary": "101413"
  },
  {
    "id": 1,
    "skill": "python",
    "demond_count": "236",
    "averge_salary": "101397"
  },
  {
    "id": 5,
    "skill": "r",
    "demond_count": "148",
    "averge_salary": "100498"
  },
  {
    "id": 78,
    "skill": "redshift",
    "demond_count": "16",
    "averge_salary": "99936"
  },
  {
    "id": 187,
    "skill": "qlik",
    "demond_count": "13",
    "averge_salary": "99630"
  },
  {
    "id": 182,
    "skill": "tableau",
    "demond_count": "230",
    "averge_salary": "99287"
  },
  {
    "id": 197,
    "skill": "ssrs",
    "demond_count": "14",
    "averge_salary": "99171"
  },
  {
    "id": 92,
    "skill": "spark",
    "demond_count": "13",
    "averge_salary": "99076"
  },
  {
    "id": 13,
    "skill": "c++",
    "demond_count": "11",
    "averge_salary": "98958"
  },
  {
    "id": 186,
    "skill": "sas",
    "demond_count": "63",
    "averge_salary": "98902"
  },
  {
    "id": 7,
    "skill": "sas",
    "demond_count": "63",
    "averge_salary": "98902"
  },
  {
    "id": 61,
    "skill": "sql server",
    "demond_count": "35",
    "averge_salary": "97785"
  },
  {
    "id": 9,
    "skill": "javascript",
    "demond_count": "20",
    "averge_salary": "97587"
  }
]
*/



-- Simplify the last query:

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






