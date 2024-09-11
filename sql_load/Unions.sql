/* UNION y UNION ALL funcinan como conectores para aquellas tablas cuyas columnas sean exactamente iguales
y que además posean el formato de valores igual, con ALL se traen adicionalmente los duplicados */
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs

/*
- Problema 8
Encuentre trabajos con salarios mayores a 70K publicados en Q1 de 2023
    - Combine las tablas de enero a marzo
    - Obtenga los trabajos con salario promedio anual > 70 mil
*/

SELECT
     job_title_short,
     job_location,
     job_via,
     job_posted_date::date,
     salary_year_avg
FROM (
    SELECT * 
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quarter1_job_post
WHERE
     salary_year_avg > 70000 AND
     job_title_short = 'Data Analyst'
ORDER BY
     salary_year_avg DESC