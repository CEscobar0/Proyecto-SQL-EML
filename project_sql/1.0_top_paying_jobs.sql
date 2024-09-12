SELECT
    job_id,
    job_title,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name as company_name
FROM job_postings_fact as jp
LEFT JOIN
    company_dim AS cd ON jp.company_id = cd.company_id
WHERE
    jp.job_work_from_home = TRUE AND -- filtro para trabajos remotos
    jp.job_title_short = 'Data Analyst' AND -- filtro adicional para tipo de puesto
    salary_year_avg IS NOT NULL -- filtro para evitar valores vacíos
ORDER BY
    salary_year_avg DESC
LIMIT 10
;