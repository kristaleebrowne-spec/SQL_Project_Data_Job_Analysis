/* 
write a query to count the number of job postings for each month in 2023
adjust the date to be EST time zone before extracting the month
assume current time zone is UTC
group by and order by month

SELECT
    EXTRACT(MONTH FROM job_posted_date at time zone 'UTC' at time zone 'EST') AS month_posted,
    COUNT(job_id) AS number_of_jobs_posted
FROM
    job_postings_fact
GROUP BY    
    month_posted;


write a query to find companies (include comapny name) that have posted jobs offering health insr
where posted in the 2nd quarter of 2023
use date extraction to filter by quarter
*/

SELECT
    cd.name AS Company,
    EXTRACT(QUARTER FROM jpf.job_posted_date) AS Quarter,
    jpf.job_health_insurance
FROM
    company_dim cd 
LEFT JOIN
    job_postings_fact jpf USING (company_id)
WHERE 
    job_health_insurance = 'true' AND 
    EXTRACT(QUARTER FROM jpf.job_posted_date) = 2;