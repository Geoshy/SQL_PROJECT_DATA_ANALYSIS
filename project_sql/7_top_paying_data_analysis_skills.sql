/*
This query shows some insights into trends based on the top-paying skills for data analysts, 
and also shows the overlapping between Data Analysts skills with Data Engineers and Data Scientists:
1. Big Data & Machine Learning: Demand for skills like PySpark, Databricks, 
and Scikit-learn reflects a need for expertise in big data processing and machine learning.
2. Cloud & Automation: Proficiency in GCP, Kubernetes, and Jenkins highlights the importance of cloud platforms, 
containerization, and automation in data analysis workflows.
3. Collaboration & Specialized Tools: Skills in Bitbucket, Atlassian, and Microstrategy indicate a focus on collaboration, 
version control, and specialized analytics platforms in high-paying data analyst roles.
These trends showcase the diverse skill sets and technologies that are highly valued in the data analysis field,
reflecting the evolving landscape of data-driven decision-making in various industries.
*/

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

/*
[
  {
    "skill_id": 95,
    "skill": "pyspark",
    "average_salary": "208172"
  },
  {
    "skill_id": 218,
    "skill": "bitbucket",
    "average_salary": "189154"
  },
  {
    "skill_id": 85,
    "skill": "watson",
    "average_salary": "160515"
  },
  {
    "skill_id": 65,
    "skill": "couchbase",
    "average_salary": "160515"
  },
  {
    "skill_id": 206,
    "skill": "datarobot",
    "average_salary": "155485"
  },
  {
    "skill_id": 220,
    "skill": "gitlab",
    "average_salary": "154500"
  },
  {
    "skill_id": 35,
    "skill": "swift",
    "average_salary": "153750"
  },
  {
    "skill_id": 102,
    "skill": "jupyter",
    "average_salary": "152776"
  },
  {
    "skill_id": 93,
    "skill": "pandas",
    "average_salary": "151821"
  },
  {
    "skill_id": 59,
    "skill": "elasticsearch",
    "average_salary": "145000"
  },
  {
    "skill_id": 27,
    "skill": "golang",
    "average_salary": "145000"
  },
  {
    "skill_id": 94,
    "skill": "numpy",
    "average_salary": "143512"
  },
  {
    "skill_id": 75,
    "skill": "databricks",
    "average_salary": "141906"
  },
  {
    "skill_id": 169,
    "skill": "linux",
    "average_salary": "136507"
  },
  {
    "skill_id": 213,
    "skill": "kubernetes",
    "average_salary": "132500"
  },
  {
    "skill_id": 219,
    "skill": "atlassian",
    "average_salary": "131161"
  },
  {
    "skill_id": 250,
    "skill": "twilio",
    "average_salary": "127000"
  },
  {
    "skill_id": 96,
    "skill": "airflow",
    "average_salary": "126103"
  },
  {
    "skill_id": 106,
    "skill": "scikit-learn",
    "average_salary": "125781"
  },
  {
    "skill_id": 211,
    "skill": "jenkins",
    "average_salary": "125436"
  },
  {
    "skill_id": 238,
    "skill": "notion",
    "average_salary": "125000"
  },
  {
    "skill_id": 3,
    "skill": "scala",
    "average_salary": "124903"
  },
  {
    "skill_id": 57,
    "skill": "postgresql",
    "average_salary": "123878"
  },
  {
    "skill_id": 81,
    "skill": "gcp",
    "average_salary": "122500"
  },
  {
    "skill_id": 191,
    "skill": "microstrategy",
    "average_salary": "121619"
  }
]
*/