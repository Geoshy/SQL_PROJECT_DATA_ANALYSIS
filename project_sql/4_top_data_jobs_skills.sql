/*
In this query, we highlight the top five skills of data jobs that are in demand in the market. 
We found that the top 5 skills ordering descending are:
1. SQL.
2. Python.
3. AWS.
4. Azure'.
5. R.
*/

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

-- "skill_id","skill","skill_frequency"
-- 0,"sql","385750"
-- 1,"python","381863"
-- 76,"aws","145718"
-- 74,"azure","132851"
-- 5,"r","131285"
