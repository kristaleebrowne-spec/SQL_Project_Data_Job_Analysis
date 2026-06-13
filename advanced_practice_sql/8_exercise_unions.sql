/*
- get the corresponding skill and skill type for each job posting
- include those without skills too
- look at the skill sand the type for each job in the first quarter 
has a salara > 70,000


- find job posting from the first quarter that have a salary greater
than 70K
-combine job postings from the first quarter of 2023 (Jan - Mar)
- get job postings with an averge salary of > 70,000
*/

SELECT 
    quarter1_job_postings.job_title_short,
    quarter1_job_postings.job_location,
    quarter1_job_postings.job_via,
    quarter1_job_postings.job_posted_date::DATE,
    quarter1_job_postings.salary_year_avg
FROM (
    SELECT *
    FROM jobs_january
    UNION ALL
    SELECT *
    FROM jobs_february
    UNION ALL
    SELECT *
    FROM jobs_march
    ) AS quarter1_job_postings
WHERE
    salary_year_avg > 70000 AND
    job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC;

