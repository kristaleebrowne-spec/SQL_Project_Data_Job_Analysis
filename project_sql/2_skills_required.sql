/*
Question: What are the skills required for each of these top-paying jobs?
- Use the top 10 highest Data Analyst jobs from the first query
- Add the specific skills required for these rolls
- Why? It privides a detailed look at which high-paying jobs demand certain skills,
helps job seekers understand which skills to develop that align with the top salaries
*/

-- CTE for top-paying jobs

WITH top_paying_jobs AS ( 
        SELECT
            job_id,
            job_title,
            job_title_short,
            name AS company_name,
            job_location,
            job_country,
            salary_year_avg
        FROM
            job_postings_fact
        LEFT JOIN company_dim USING (company_id)
        WHERE
            job_country = 'Canada' 
            AND job_title_short = 'Data Analyst'
            AND salary_year_avg IS NOT NULL
        ORDER BY
            salary_year_avg DESC
        LIMIT 10
)

-- main query

SELECT
    tpj.*,
    sd.skills
FROM
    top_paying_jobs tpj
INNER JOIN skills_job_dim sjd ON tpj.job_id = sjd.job_id
INNER JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
ORDER BY
    tpj.salary_year_avg DESC;
    

/*
Skill Breakdown from GPT 
(from saving query as a CSV file and importing into GPT):

-SQL and Python are the most in-demand skills, appearing in the majority of 
top-paying Data Analyst job postings, reinforcing their importance as core 
technical competencies.
-Cloud and big data technologies are common, with tools like Snowflake, 
BigQuery, Azure, Spark, and Hadoop frequently requested, reflecting the 
shift toward modern data platforms.
-Visualization remains a key requirement, with Tableau leading BI tools, 
highlighting the value employers place on translating data into actionable 
business insights.

-SQL is the most frequently requested skill (6 postings).
-Python follows closely (5 postings), reinforcing its importance for 
high-paying analyst roles.
-Tableau and Spark appear in 3 postings each, while the remaining 
kills are more specialized and appear less frequently.



Results (opened '2_skills_required.sql' as a JSON file)
(Click on file, select 'Open file as' icon in top right corner):

[
  {
    "job_id": 475626,
    "job_title": "Principal Data Analyst",
    "job_title_short": "Data Analyst",
    "company_name": "Realtime Recruitment",
    "job_location": "Anywhere",
    "job_country": "Canada",
    "salary_year_avg": "160000.0",
    "skills": "snowflake"
  },
  {
    "job_id": 475626,
    "job_title": "Principal Data Analyst",
    "job_title_short": "Data Analyst",
    "company_name": "Realtime Recruitment",
    "job_location": "Anywhere",
    "job_country": "Canada",
    "salary_year_avg": "160000.0",
    "skills": "power bi"
  },
  {
    "job_id": 475626,
    "job_title": "Principal Data Analyst",
    "job_title_short": "Data Analyst",
    "company_name": "Realtime Recruitment",
    "job_location": "Anywhere",
    "job_country": "Canada",
    "salary_year_avg": "160000.0",
    "skills": "looker"
  },
  {
    "job_id": 587198,
    "job_title": "Data Architect",
    "job_title_short": "Data Analyst",
    "company_name": "Motion Recruitment",
    "job_location": "Anywhere",
    "job_country": "Canada",
    "salary_year_avg": "120000.0",
    "skills": "sql"
  },
  {
    "job_id": 587198,
    "job_title": "Data Architect",
    "job_title_short": "Data Analyst",
    "company_name": "Motion Recruitment",
    "job_location": "Anywhere",
    "job_country": "Canada",
    "salary_year_avg": "120000.0",
    "skills": "azure"
  },
  {
    "job_id": 587198,
    "job_title": "Data Architect",
    "job_title_short": "Data Analyst",
    "company_name": "Motion Recruitment",
    "job_location": "Anywhere",
    "job_country": "Canada",
    "salary_year_avg": "120000.0",
    "skills": "aws"
  },
  {
    "job_id": 587198,
    "job_title": "Data Architect",
    "job_title_short": "Data Analyst",
    "company_name": "Motion Recruitment",
    "job_location": "Anywhere",
    "job_country": "Canada",
    "salary_year_avg": "120000.0",
    "skills": "bigquery"
  },
  {
    "job_id": 587198,
    "job_title": "Data Architect",
    "job_title_short": "Data Analyst",
    "company_name": "Motion Recruitment",
    "job_location": "Anywhere",
    "job_country": "Canada",
    "salary_year_avg": "120000.0",
    "skills": "redshift"
  },
  {
    "job_id": 587198,
    "job_title": "Data Architect",
    "job_title_short": "Data Analyst",
    "company_name": "Motion Recruitment",
    "job_location": "Anywhere",
    "job_country": "Canada",
    "salary_year_avg": "120000.0",
    "skills": "snowflake"
  },
  {
    "job_id": 587198,
    "job_title": "Data Architect",
    "job_title_short": "Data Analyst",
    "company_name": "Motion Recruitment",
    "job_location": "Anywhere",
    "job_country": "Canada",
    "salary_year_avg": "120000.0",
    "skills": "gcp"
  },
  {
    "job_id": 587198,
    "job_title": "Data Architect",
    "job_title_short": "Data Analyst",
    "company_name": "Motion Recruitment",
    "job_location": "Anywhere",
    "job_country": "Canada",
    "salary_year_avg": "120000.0",
    "skills": "tableau"
  },
  {
    "job_id": 205303,
    "job_title": "Data Analyst, Risk User Experience",
    "job_title_short": "Data Analyst",
    "company_name": "Stripe",
    "job_location": "Canada",
    "job_country": "Canada",
    "salary_year_avg": "111175.0",
    "skills": "sql"
  },
  {
    "job_id": 205303,
    "job_title": "Data Analyst, Risk User Experience",
    "job_title_short": "Data Analyst",
    "company_name": "Stripe",
    "job_location": "Canada",
    "job_country": "Canada",
    "salary_year_avg": "111175.0",
    "skills": "python"
  },
  {
    "job_id": 205303,
    "job_title": "Data Analyst, Risk User Experience",
    "job_title_short": "Data Analyst",
    "company_name": "Stripe",
    "job_location": "Canada",
    "job_country": "Canada",
    "salary_year_avg": "111175.0",
    "skills": "spark"
  },
  {
    "job_id": 205303,
    "job_title": "Data Analyst, Risk User Experience",
    "job_title_short": "Data Analyst",
    "company_name": "Stripe",
    "job_location": "Canada",
    "job_country": "Canada",
    "salary_year_avg": "111175.0",
    "skills": "hadoop"
  },
  {
    "job_id": 1180796,
    "job_title": "Data Analyst, Growth",
    "job_title_short": "Data Analyst",
    "company_name": "Stripe",
    "job_location": "Canada",
    "job_country": "Canada",
    "salary_year_avg": "111175.0",
    "skills": "sql"
  },
  {
    "job_id": 1180796,
    "job_title": "Data Analyst, Growth",
    "job_title_short": "Data Analyst",
    "company_name": "Stripe",
    "job_location": "Canada",
    "job_country": "Canada",
    "salary_year_avg": "111175.0",
    "skills": "python"
  },
  {
    "job_id": 1180796,
    "job_title": "Data Analyst, Growth",
    "job_title_short": "Data Analyst",
    "company_name": "Stripe",
    "job_location": "Canada",
    "job_country": "Canada",
    "salary_year_avg": "111175.0",
    "skills": "spark"
  },
  {
    "job_id": 1180796,
    "job_title": "Data Analyst, Growth",
    "job_title_short": "Data Analyst",
    "company_name": "Stripe",
    "job_location": "Canada",
    "job_country": "Canada",
    "salary_year_avg": "111175.0",
    "skills": "hadoop"
  },
  {
    "job_id": 409209,
    "job_title": "Data Analyst (VBA, Tableau)",
    "job_title_short": "Data Analyst",
    "company_name": "Sun Life",
    "job_location": "Canada",
    "job_country": "Canada",
    "salary_year_avg": "109000.0",
    "skills": "sql"
  },
  {
    "job_id": 409209,
    "job_title": "Data Analyst (VBA, Tableau)",
    "job_title_short": "Data Analyst",
    "company_name": "Sun Life",
    "job_location": "Canada",
    "job_country": "Canada",
    "salary_year_avg": "109000.0",
    "skills": "python"
  },
  {
    "job_id": 409209,
    "job_title": "Data Analyst (VBA, Tableau)",
    "job_title_short": "Data Analyst",
    "company_name": "Sun Life",
    "job_location": "Canada",
    "job_country": "Canada",
    "salary_year_avg": "109000.0",
    "skills": "vba"
  },
  {
    "job_id": 409209,
    "job_title": "Data Analyst (VBA, Tableau)",
    "job_title_short": "Data Analyst",
    "company_name": "Sun Life",
    "job_location": "Canada",
    "job_country": "Canada",
    "salary_year_avg": "109000.0",
    "skills": "excel"
  },
  {
    "job_id": 409209,
    "job_title": "Data Analyst (VBA, Tableau)",
    "job_title_short": "Data Analyst",
    "company_name": "Sun Life",
    "job_location": "Canada",
    "job_country": "Canada",
    "salary_year_avg": "109000.0",
    "skills": "tableau"
  },
  {
    "job_id": 629221,
    "job_title": "Analytics Engineering Lead",
    "job_title_short": "Data Analyst",
    "company_name": "Swiss Re",
    "job_location": "Canada",
    "job_country": "Canada",
    "salary_year_avg": "108415.5",
    "skills": "python"
  },
  {
    "job_id": 629221,
    "job_title": "Analytics Engineering Lead",
    "job_title_short": "Data Analyst",
    "company_name": "Swiss Re",
    "job_location": "Canada",
    "job_country": "Canada",
    "salary_year_avg": "108415.5",
    "skills": "typescript"
  },
  {
    "job_id": 629221,
    "job_title": "Analytics Engineering Lead",
    "job_title_short": "Data Analyst",
    "company_name": "Swiss Re",
    "job_location": "Canada",
    "job_country": "Canada",
    "salary_year_avg": "108415.5",
    "skills": "spark"
  },
  {
    "job_id": 1591043,
    "job_title": "Data Analyst, End to End Banking Operations",
    "job_title_short": "Data Analyst",
    "company_name": "ATB Financial",
    "job_location": "Edmonton, AB, Canada",
    "job_country": "Canada",
    "salary_year_avg": "105000.0",
    "skills": "sql"
  },
  {
    "job_id": 1591043,
    "job_title": "Data Analyst, End to End Banking Operations",
    "job_title_short": "Data Analyst",
    "company_name": "ATB Financial",
    "job_location": "Edmonton, AB, Canada",
    "job_country": "Canada",
    "salary_year_avg": "105000.0",
    "skills": "python"
  },
  {
    "job_id": 1591043,
    "job_title": "Data Analyst, End to End Banking Operations",
    "job_title_short": "Data Analyst",
    "company_name": "ATB Financial",
    "job_location": "Edmonton, AB, Canada",
    "job_country": "Canada",
    "salary_year_avg": "105000.0",
    "skills": "javascript"
  },
  {
    "job_id": 1591043,
    "job_title": "Data Analyst, End to End Banking Operations",
    "job_title_short": "Data Analyst",
    "company_name": "ATB Financial",
    "job_location": "Edmonton, AB, Canada",
    "job_country": "Canada",
    "salary_year_avg": "105000.0",
    "skills": "bigquery"
  },
  {
    "job_id": 1591043,
    "job_title": "Data Analyst, End to End Banking Operations",
    "job_title_short": "Data Analyst",
    "company_name": "ATB Financial",
    "job_location": "Edmonton, AB, Canada",
    "job_country": "Canada",
    "salary_year_avg": "105000.0",
    "skills": "tableau"
  },
  {
    "job_id": 1591043,
    "job_title": "Data Analyst, End to End Banking Operations",
    "job_title_short": "Data Analyst",
    "company_name": "ATB Financial",
    "job_location": "Edmonton, AB, Canada",
    "job_country": "Canada",
    "salary_year_avg": "105000.0",
    "skills": "sheets"
  },
  {
    "job_id": 1232872,
    "job_title": "Analytics Lab Architect",
    "job_title_short": "Data Analyst",
    "company_name": "Swiss Re",
    "job_location": "Canada",
    "job_country": "Canada",
    "salary_year_avg": "101014.0",
    "skills": "azure"
  },
  {
    "job_id": 1232872,
    "job_title": "Analytics Lab Architect",
    "job_title_short": "Data Analyst",
    "company_name": "Swiss Re",
    "job_location": "Canada",
    "job_country": "Canada",
    "salary_year_avg": "101014.0",
    "skills": "databricks"
  },
  {
    "job_id": 995289,
    "job_title": "Operation Data Analyst - Genshin Impact",
    "job_title_short": "Data Analyst",
    "company_name": "HoYoverse",
    "job_location": "Canada",
    "job_country": "Canada",
    "salary_year_avg": "100500.0",
    "skills": "sql"
  },
  {
    "job_id": 995289,
    "job_title": "Operation Data Analyst - Genshin Impact",
    "job_title_short": "Data Analyst",
    "company_name": "HoYoverse",
    "job_location": "Canada",
    "job_country": "Canada",
    "salary_year_avg": "100500.0",
    "skills": "python"
  },
  {
    "job_id": 995289,
    "job_title": "Operation Data Analyst - Genshin Impact",
    "job_title_short": "Data Analyst",
    "company_name": "HoYoverse",
    "job_location": "Canada",
    "job_country": "Canada",
    "salary_year_avg": "100500.0",
    "skills": "sas"
  },
  {
    "job_id": 995289,
    "job_title": "Operation Data Analyst - Genshin Impact",
    "job_title_short": "Data Analyst",
    "company_name": "HoYoverse",
    "job_location": "Canada",
    "job_country": "Canada",
    "salary_year_avg": "100500.0",
    "skills": "excel"
  },
  {
    "job_id": 995289,
    "job_title": "Operation Data Analyst - Genshin Impact",
    "job_title_short": "Data Analyst",
    "company_name": "HoYoverse",
    "job_location": "Canada",
    "job_country": "Canada",
    "salary_year_avg": "100500.0",
    "skills": "sas"
  },
  {
    "job_id": 995289,
    "job_title": "Operation Data Analyst - Genshin Impact",
    "job_title_short": "Data Analyst",
    "company_name": "HoYoverse",
    "job_location": "Canada",
    "job_country": "Canada",
    "salary_year_avg": "100500.0",
    "skills": "spss"
  }
]
*/
