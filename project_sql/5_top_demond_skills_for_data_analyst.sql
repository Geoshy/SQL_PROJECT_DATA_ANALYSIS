/*
In this query, we highlight the top five demond skills of Data Analyst job in the market. 
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

-- "skill_id","skill","skill_frequency"
-- 0,"sql","92628"
-- 181,"excel","67031"
-- 1,"python","57326"
-- 182,"tableau","46554"
-- 183,"power bi","39468"

-- OR

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

-- "skill_id","skill","skill_frequency"
-- 0,"sql","92628"
-- 181,"excel","67031"
-- 1,"python","57326"
-- 182,"tableau","46554"
-- 183,"power bi","39468"


