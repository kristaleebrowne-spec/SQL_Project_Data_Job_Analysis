/* 
Question: What are the top-paying Data Analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles available in Canada.
- Focus on job postings with specific salaries (remove nulls).
- Why? Highlights the top-paying opportunites for Data Analysts, offering 
insights into employment opportunites
*/

SELECT
    jf.job_id,
    jf.job_title,
    jf.job_title_short,
    cd.name AS company_name,
    jf.job_location,
    jf.job_country,
    jf.salary_year_avg
FROM
    job_postings_fact jf
LEFT JOIN
    company_dim cd USING (company_id)
WHERE
    job_country = 'Canada' 
    AND job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;