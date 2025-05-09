-- Pregunta 1

SELECT count(DISTINCT user_id) 
FROM {{ref('stg_sql_server_dbo_users')}}

-- Me salen que son 130

-- Pregunta 2

WITH promedio_horas AS (
    SELECT order_id, DATEDIFF(hour,min(created_at) ,max(delivered_at) ) AS diff
    FROM {{ref('stg_sql_server_dbo_orders')}}
    GROUP BY order_id
)

SELECT AVG(diff)
FROM promedio_horas

-- Pregunta 3

with num_compras as (
    SELECT 
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY order_id ASC) compras,
        user_id
    FROM {{ref('stg_sql_server_dbo_orders')}}
),
maximo_compras_por_usuario as (
    select max(compras) as compras,user_id
    from num_compras
    group by user_id
)
select 
    COUNT(CASE WHEN compras = 1 THEN 1 END) AS compra_1,
    COUNT(CASE WHEN compras = 2 THEN 1 END) AS compra_2,
    COUNT(CASE WHEN compras > 2 THEN 1 END) AS compra_3_mas
from maximo_compras_por_usuario

-- Pregunta 4

with tiempo as ( 
    select DISTINCT session_id as sesiones,
     hour(created_at) as horas 
    from {{ref('stg_sql_server_dbo_events')}}
),
conteo_sesiones as (
    SELECT 
        ROW_NUMBER() OVER (PARTITION BY horas ORDER BY sesiones) as conteo_ses,
        horas
    FROM tiempo
),
maximo_sesiones as (
    select max(conteo_ses) as maximo_conteo_ses, horas
    from conteo_sesiones
    group by horas
) 
select AVG(maximo_conteo_ses) as promedio_sesiones,horas
from maximo_sesiones
group by horas 
