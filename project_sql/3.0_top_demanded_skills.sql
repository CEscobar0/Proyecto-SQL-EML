-- Construimos la consulta que muestra las habilidades y genera un recuento de estas en los id de las publicaciones de empleos.
-- Se utilizan INNER JOIN para facilitar y recortar la consulta.
SELECT 
    sd.skills as skill_name, 
    COUNT(sj.skill_id) as skill_count -- se aplica el recuento
FROM
    skills_dim sd
INNER JOIN skills_job_dim sj ON sj.skill_id = sd.skill_id
INNER JOIN job_postings_fact jp ON jp.job_id = sj.job_id
WHERE
    jp.job_work_from_home = TRUE AND -- los trabajos son remotos.
    jp.job_title_short = 'Data Analyst'
GROUP BY sd.skill_id
ORDER BY skill_count DESC
LIMIT 5
;

/*
Los datos presentados nos ofrecen una instantánea de las habilidades más solicitadas en el mercado laboral en el 2023, para el conjunto de datos especificado.

Podemos observar que:

    - SQL domina el panorama: El lenguaje de consulta estructurada (SQL) se posiciona como la habilidad más demandada, con una diferencia significativa respecto a las demás. Esto subraya la importancia de la gestión y análisis de bases de datos en diversos sectores.
    - Excel y Python siguen de cerca: Herramientas como Excel y el lenguaje de programación Python, conocidos por su versatilidad en el análisis de datos y automatización, ocupan el segundo y tercer lugar respectivamente. Esto indica una fuerte demanda de profesionales capaces de manipular y analizar grandes volúmenes de datos.
    - Visualización de datos en auge: Herramientas como Tableau y Power BI, especializadas en la creación de visualizaciones de datos, también tienen una presencia notable. Esto refleja la creciente necesidad de comunicar los hallazgos de los análisis de manera clara y efectiva.
*/

/*
[
  {
    "skill_name": "sql",
    "skill_count": "7291"
  },
  {
    "skill_name": "excel",
    "skill_count": "4611"
  },
  {
    "skill_name": "python",
    "skill_count": "4330"
  },
  {
    "skill_name": "tableau",
    "skill_count": "3745"
  },
  {
    "skill_name": "power bi",
    "skill_count": "2609"
  }
]
*/