/*
Question: What are the top skills based on salary?
-Identify the average salary associated with each skill for Data Analyst 
positions
-Focus on Canadian locations
-Why? It reveals how different skills impact salary levels for Data Analysts 
and helps identify the most financially rewarding skills to acquire or improve
*/

SELECT
   sd.skills,
   ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM
    job_postings_fact jpf
INNER JOIN skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    AND job_country = 'Canada'
GROUP BY
    sd.skills
ORDER BY
    average_salary DESC
LIMIT 25;


/*
Here's a breakdown for the results of top paying skills:
- Cloud data platforms lead salary rankings, with Snowflake, BigQuery, 
Redshift, AWS, Azure, and Databricks reflecting strong demand for modern 
data infrastructure skills.
- Business Intelligence and programming skills remain highly valued, with Looker, 
Tableau, Python, and R associated with above-average salaries and end-to-end 
analytical capabilities.
- The highest-paying Data Analyst roles extend beyond traditional analytics, 
favoring professionals with a blend of cloud, visualization, programming, and 
big data expertise
*/