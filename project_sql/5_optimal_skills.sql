
Question: What are the most optimal skills to learn? 
-Optimal = High demand AND High paying
-We can combine what we have found in query 3 and 4 which is:
(3)skills in high demand and (4)skills associated with high average salaries 
for data analysts
- bc we are combining, remove the LIMIT
-Why? Offering strategic insights for career development in data analysis


-- create 2 CTEs for high demand skills and high salary skills

WITH high_demand_skills AS (
    SELECT
        sd.skill_id,
        sd.skills,
        COUNT(*) AS demand_count
    FROM
        job_postings_fact jpf
    INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        -- AND job_country = 'Canada'
        AND job_work_from_home = TRUE
    GROUP BY
        sd.skills,
        sd.skill_id
),

    high_salary_skills AS (
    SELECT
        sjd.skill_id,
        sd.skills,
        ROUND(AVG(salary_year_avg), 0) AS average_salary
    FROM
        job_postings_fact jpf
    INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        -- AND job_country = 'Canada'
        AND job_work_from_home = TRUE
    GROUP BY
        sjd.skill_id,
        sd.skills
)


-- main query to connect both

SELECT
    hds.skill_id,
    hds.skills,
    hds.demand_count,
    hss.average_salary
FROM
    high_demand_skills hds
INNER JOIN -- bc we only care about what exists in these 2 tables
    high_salary_skills hss ON hds.skill_id = hss.skill_id 
WHERE -- bc we want the highest denand count from the average salary order by
    hds.demand_count >= 10
ORDER BY -- will run first listed
    hss.average_salary DESC,
    hds.demand_count DESC
LIMIT 25;
    


-- there are a lot of NULLS in the average yearly salary data, which limits the number of postings



-- same query, re-written more concisely

SELECT
    sd.skill_id,
    sd.skills,
    COUNT(sjd.skill_id) AS demand_count,
    ROUND(AVG(jpf.salary_year_avg), 0) AS average_salary
FROM
    job_postings_fact jpf 
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_country = 'Canada'
    AND salary_year_avg IS NOT NULL
GROUP BY
    sd.skill_id
HAVING
    COUNT(sjd.skill_id) >= 5
ORDER BY -- will run first listed
    demand_count DESC,
    average_salary DESC;












