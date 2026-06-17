/*
Question: find the top 5 skills that are most frequently mention
in job postings for Data Analysts
- this is a longer version using a CTE - NOT USING
*/

-- CTE to find top 5 skills listed for remote data analysts

WITH top_five_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim sjd
    LEFT JOIN
        job_postings_fact USING (job_id)
    WHERE
        job_title_short = 'Data Analyst' AND
        job_country = 'Canada'
    GROUP BY
        skill_id
    ORDER BY
        skill_count DESC
    LIMIT 5
)

-- main query to add skill name

SELECT
    sd.skills AS Skill,
    tfs.skill_count
FROM
    top_five_skills tfs
LEFT JOIN
    skills_dim sd USING (skill_id)
ORDER BY
    skill_count DESC;









