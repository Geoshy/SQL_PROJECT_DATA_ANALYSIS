/*
In this query, we highlight the top five demand skills of Data Analyst jobs for Remote (Freelancing Data Analyst).
We found that the top 5 skills ordering descending are:
1. SQL.
2. Excel.
3. Python.
4. Tableau'.
5. Power BI.
*/

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

-- "skill_id","skill","skill_frequency"
-- 0,"sql","7291"
-- 181,"excel","4611"
-- 1,"python","4330"
-- 182,"tableau","3745"
-- 183,"power bi","2609"




