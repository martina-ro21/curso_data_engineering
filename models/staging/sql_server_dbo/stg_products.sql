{{
  config(
    materialized='view'
  )
}}

WITH src_products AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'products') }}
    ),

renamed_casted AS (
    SELECT
           product_id
         , price
         , name
         , inventory
         , _fivetran_deleted
         , _fivetran_synced as date_load
    FROM src_products
    )

SELECT * FROM renamed_casted