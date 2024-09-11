-- CTEs y Subconsultas
SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;

WITH january_jobs AS ( -- CTE definition starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) -- CTE definition ends here

SELECT *
FROM
    january_jobs
;

SELECT
    company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = true
    ORDER BY
        company_id
);

---Si quisieramos contar la cantidad de trabajos que publica cada empresa, podemos:
WITH company_job_count AS (
    SELECT
        company_id,
        count(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
)

SELECT
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY
    total_jobs DESC
;

--Si quisieramos ver cuales habilidades son las más solicitadas en los puestos de trabajo que publicados, podemos:
WITH skill_count AS (
    SELECT
        skill_id,
        count(*) AS jobs_skill_required
    FROM
        skills_job_dim
    GROUP BY
        skill_id
)

SELECT
    skills_dim.skills AS skill_name,
    skill_count.jobs_skill_required
FROM skills_dim
LEFT JOIN skill_count ON skill_count.skill_id = skills_dim.skill_id
ORDER BY
    jobs_skill_required DESC
    LIMIT 5
; -- Para este caso se identifican las 5 habilidades más solicitadas.

-- Comprobamos que la habilidad top 1 'sql' tiene efectivamente la cantidad de apariciones arrojadas en la consula anterior.
SELECT
    sd.skills,
    COUNT(sj.skill_id) AS total_skill_count
FROM skills_dim AS sd
JOIN skills_job_dim AS sj ON sd.skill_id = sj.skill_id
WHERE
    sd.skills = 'sql'
GROUP BY
    skills;

/* Para agrupar las empresas en clasificaciones podemos hacer uso de un CTE más
de la forma lograr categorizar las empresas por la cantidad de publicaciones que hacen */
WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS total_jobs -- este es el nombre final de la columna
    FROM
        job_postings_fact
    GROUP BY
        company_id
),
company_size AS (
    SELECT
        company_id,
        total_jobs,
        CASE
            WHEN total_jobs <= 10 THEN 'Pequeña'
            WHEN total_jobs > 10 AND total_jobs <= 50 THEN 'Mediana'
            ELSE 'Grande'
        END AS company_size -- este es el nombre final de la columna
    FROM
        company_job_count
)

SELECT
    company_dim.name AS company_name,
    company_size.total_jobs,
    company_size.company_size
FROM
    company_dim
LEFT JOIN
    company_size ON company_size.company_id = company_dim.company_id
WHERE
    company_size = 'Mediana' OR
    company_size = 'Pequeña'
ORDER BY
    company_size.total_jobs ASC;

/* Si queremos mostrar aquellos que son remotos y entrablar conexones con varias tablas
podemos hacer uso del inner join para facilitar la busqueda de la data */

WITH remote_jobs_skills AS (
/* Construimos el conjuto que muestra los id de las habilidades y cuenta el numero de veces que aparecen
en los id de las publicaciones de empleos */
    SELECT 
        skill_id,
        count(*) AS skill_count
    FROM
        skills_job_dim as skills_needed
    INNER JOIN job_postings_fact as jb ON jb.job_id = skills_needed.job_id
    WHERE
        jb.job_work_from_home = TRUE AND -- el filtro para trabajos remotos
        jb.job_title_short = 'Data Analyst' -- el filtro adicional si se desea espeificar el tipo de puesto
    GROUP BY
        skill_id
) -- agregamos el CTE para realizar la subconsulta con WITH

SELECT
    sd.skill_id, -- muestra el identificador
    skills AS skill_name, -- cambia el nombre de la columna
    skill_count -- invoca el recuento del subquery romete_jobs_skills
FROM remote_jobs_skills
INNER JOIN skills_dim AS sd ON sd.skill_id = remote_jobs_skills.skill_id
ORDER BY
    skill_count DESC
    LIMIT 5