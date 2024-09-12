-- ¿Cúales son las habilidades mejor remuneradas?
SELECT 
    sd.skills as skill_name,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary -- se promedia por habilidad y se redondean los valores.
FROM
    skills_dim sd
INNER JOIN skills_job_dim sj ON sj.skill_id = sd.skill_id
INNER JOIN job_postings_fact jp ON jp.job_id = sj.job_id
WHERE
    jp.job_work_from_home = TRUE AND -- los trabajos son remotos.
    salary_year_avg IS NOT NULL AND -- se eliminan datos vacios para no afectar el promedio.
    jp.job_title_short = 'Data Analyst'
GROUP BY sd.skills
ORDER BY avg_salary DESC
LIMIT 25
;

/*
Habilidades más valoradas: alta demanda en Big Data
    - Pyspark
    - Couchbase
    - Bitbucket
    - otras herramientas relacionadas con ciencia de datos y cloud computing son las más demandadas y mejor remuneradas.
Tendencias del mercado:
    - Existe una creciente demanda de profesionales con habilidades en:
        - Ciencia de datos
        - Ingeniería de datos
        - Cloud computing
Se concluye que las empresas buscan cada vez más aprovechar el potencial de los datos para tomar mejores decisiones
Por lo tanto estas habilidades conducionan de un incremento en los salarios promedio.
*/

/*
[
  {
    "skill_name": "pyspark",
    "avg_salary": "208172"
  },
  {
    "skill_name": "bitbucket",
    "avg_salary": "189155"
  },
  {
    "skill_name": "couchbase",
    "avg_salary": "160515"
  },
  {
    "skill_name": "watson",
    "avg_salary": "160515"
  },
  {
    "skill_name": "datarobot",
    "avg_salary": "155486"
  },
  {
    "skill_name": "gitlab",
    "avg_salary": "154500"
  },
  {
    "skill_name": "swift",
    "avg_salary": "153750"
  },
  {
    "skill_name": "jupyter",
    "avg_salary": "152777"
  },
  {
    "skill_name": "pandas",
    "avg_salary": "151821"
  },
  {
    "skill_name": "elasticsearch",
    "avg_salary": "145000"
  },
  {
    "skill_name": "golang",
    "avg_salary": "145000"
  },
  {
    "skill_name": "numpy",
    "avg_salary": "143513"
  },
  {
    "skill_name": "databricks",
    "avg_salary": "141907"
  },
  {
    "skill_name": "linux",
    "avg_salary": "136508"
  },
  {
    "skill_name": "kubernetes",
    "avg_salary": "132500"
  },
  {
    "skill_name": "atlassian",
    "avg_salary": "131162"
  },
  {
    "skill_name": "twilio",
    "avg_salary": "127000"
  },
  {
    "skill_name": "airflow",
    "avg_salary": "126103"
  },
  {
    "skill_name": "scikit-learn",
    "avg_salary": "125781"
  },
  {
    "skill_name": "jenkins",
    "avg_salary": "125436"
  },
  {
    "skill_name": "notion",
    "avg_salary": "125000"
  },
  {
    "skill_name": "scala",
    "avg_salary": "124903"
  },
  {
    "skill_name": "postgresql",
    "avg_salary": "123879"
  },
  {
    "skill_name": "gcp",
    "avg_salary": "122500"
  },
  {
    "skill_name": "microstrategy",
    "avg_salary": "121619"
  }
]
*/