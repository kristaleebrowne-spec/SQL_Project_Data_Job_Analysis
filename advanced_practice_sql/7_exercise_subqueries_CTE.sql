/*
- identify the top 5 skills that are most frequently mentioned in job postings
- use a subquery to find the skill IDs with the highest counts in the skills_job_dim 
table and then join this result with the skills_dim table to get the skills names

-- with. subquery

SELECT
    sd.skills,
    top_skills.skill_id,
    top_skills.skill_count
FROM
    (SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM 
        skills_job_dim
    GROUP BY 
        skill_id
    ORDER BY skill_count DESC
    LIMIT 5
    ) AS top_skills

LEFT JOIN
    skills_dim sd USING (skill_id)
ORDER BY 
       top_skills.skill_count DESC;



-- without a subquery

SELECT
    sd.skills,
    COUNT(sjd.*) AS Number_of_Skills
FROM
    skills_job_dim sjd
LEFT JOIN
    skills_dim sd USING(skill_id)
GROUP BY
    sd.skills
ORDER BY 
    Number_of_Skills DESC
LIMIT 5;  


- Determine the size category (sm, med, lrg) for each company by first identifying
the number of job postings they have using a subquery to calculate the total number
of jobs per company
- small < 10
- med 10- 50
- large > 50
make the subquery first and then classify them based on size


SELECT
    Company_Job_Count.company_id,
    cd.name,
    CASE
        WHEN total_job_count < 10 THEN 'Small'
        WHEN total_job_count BETWEEN 10 AND 50 THEN 'Medium'
        WHEN total_job_count > 50 THEN 'Large'
    END AS rank_size
FROM 
      (SELECT
          company_id,
          COUNT(*) AS total_job_count
       FROM
           job_postings_fact
       GROUP BY
           company_id
       ) AS Company_Job_Count
LEFT JOIN
    company_dim cd USING (company_id);
 
 
 find the count of the number of remote job postings per skill
 - display the top 5 skills by their demand in remote jobs
 - include skill id, name, and count of potings requiring the skill

-- build a CTE to show the number of job postings per skill

WITH number_jobs_per_skill AS (
        SELECT 
        sjd.skill_id,
        COUNT(jpf.job_id) AS number_jobs_listings,
        jpf.job_location
        FROM
            skills_job_dim sjd
        LEFT JOIN 
            job_postings_fact jpf USING (job_id)
        WHERE
            job_location = 'Anywhere'
        GROUP BY
            skill_id,
            jpf.job_location
        ORDER BY 
            number_jobs_listings DESC
        )
    
SELECT
    jps.skill_id,
    sd.skills,
    jps.number_jobs_listings,
    jps.job_location
FROM
    number_jobs_per_skill jps 
INNER JOIN
    skills_dim sd USING(skill_id)
ORDER BY
    jps.number_jobs_listings DESC
LIMIT 5;
 
 
Find the count of the number of remote job postings per skill
 - display the top 5 skills by their demand in remote jobs
 - include skill id, name, and count of potings requiring the skill


- create a cte table that shows all skills and the number of job
postings that have the skill listed
- filter these results for 'work from home' to indicate remote posts

- build a main query that joins the cte to the skills dim table to 
display the name of the skill
- limit for the top 5 skills that are mentioned the most in the job posts
 */

WITH number_jobs_per_skill AS (
        SELECT
            sd.skill_id AS skill_id,
            COUNT(jf.job_id) AS jobs_per_skill
        FROM  
            skills_job_dim sd 
        LEFT JOIN 
            job_postings_fact jf USING (job_id)
        WHERE
            job_work_from_home = TRUE AND job_title_short = 'Data Analyst'
        GROUP BY
            sd.skill_id,
            jf.job_work_from_home
        ORDER BY
            jobs_per_skill DESC
        )

SELECT
    njs.skill_id,
    sd.skills,
    njs.jobs_per_skill
FROM
    number_jobs_per_skill njs 
LEFT JOIN
    skills_dim sd USING (skill_id)
ORDER BY
    njs.jobs_per_skill DESC
LIMIT 5;