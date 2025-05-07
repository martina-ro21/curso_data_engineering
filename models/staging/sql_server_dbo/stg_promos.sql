{{
  config(
    materialized='view'
  )
}}

WITH src_promos AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'promos') }}
    ),

valores_nuevos AS (
    SELECT
     'sin_promo' AS promo_id
    , '0' AS discount
    , 'inactive' AS status
    , null AS _fivetran_deleted
    , '2024-10-25' AS _fivetran_synced
),

unir AS (
    SELECT *
    FROM src_promos
    UNION ALL
    SELECT *
    FROM valores_nuevos
),

renamed_casted AS (
    SELECT
           {{ dbt_utils.generate_surrogate_key(['promo_id']) }} AS promo_id
         , lower(promo_id) AS tipo_descuento
         , discount
         , status
         , _fivetran_deleted
         , _fivetran_synced as date_load
    FROM unir
    )

SELECT * FROM renamed_casted