/*
We Highlight the Skills of the Top Paying Data Analyst Roles 
and the Most Common Skills in all Top Paying Jobs.
*/

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

/*
We Found That the Most Common Five Skills in Top Paying Jobs are:
1. SQL: We found that this Skill's Count is 8.
2. Python: We found that this Skill's Count is 7.
3. Tableau: We found that this Skill's Count is 6.
4. R: We found that this Skill's Count is 4.
5. Snowflake: We found that this Skill's Count is 3.	

[
  {
    "skill": "sql",
    "skill_count": "8"
  },
  {
    "skill": "python",
    "skill_count": "7"
  },
  {
    "skill": "tableau",
    "skill_count": "6"
  },
  {
    "skill": "r",
    "skill_count": "4"
  },
  {
    "skill": "snowflake",
    "skill_count": "3"
  },
  {
    "skill": "pandas",
    "skill_count": "3"
  },
  {
    "skill": "excel",
    "skill_count": "3"
  },
  {
    "skill": "atlassian",
    "skill_count": "2"
  },
  {
    "skill": "jira",
    "skill_count": "2"
  },
  {
    "skill": "aws",
    "skill_count": "2"
  },
  {
    "skill": "azure",
    "skill_count": "2"
  },
  {
    "skill": "bitbucket",
    "skill_count": "2"
  },
  {
    "skill": "confluence",
    "skill_count": "2"
  },
  {
    "skill": "gitlab",
    "skill_count": "2"
  },
  {
    "skill": "go",
    "skill_count": "2"
  },
  {
    "skill": "numpy",
    "skill_count": "2"
  },
  {
    "skill": "oracle",
    "skill_count": "2"
  },
  {
    "skill": "power bi",
    "skill_count": "2"
  },
  {
    "skill": "jenkins",
    "skill_count": "1"
  },
  {
    "skill": "crystal",
    "skill_count": "1"
  },
  {
    "skill": "powerpoint",
    "skill_count": "1"
  },
  {
    "skill": "pyspark",
    "skill_count": "1"
  },
  {
    "skill": "hadoop",
    "skill_count": "1"
  },
  {
    "skill": "git",
    "skill_count": "1"
  },
  {
    "skill": "sap",
    "skill_count": "1"
  },
  {
    "skill": "jupyter",
    "skill_count": "1"
  },
  {
    "skill": "flow",
    "skill_count": "1"
  },
  {
    "skill": "databricks",
    "skill_count": "1"
  }
]
*/