/*
Question: What are the most in-demand skills for data analysts
-identify the top 5 in-demand skills for a data analyst
-focus on Canadian job postings
- Why? Retrieves the top 5 skills with the highest demand in the
job market providing insights into the most valuable skills for job 
seekers

-this is a shorter version that uses multiple joins instead
of CTEs
*/

SELECT
   sd.skills,
   COUNT(*) AS demand_count
FROM
    job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_country = 'Canada'
GROUP BY
    sd.skills
ORDER BY
    demand_count DESC
LIMIT 5;