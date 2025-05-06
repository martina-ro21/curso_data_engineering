{{
  config(
    materialized='view'
  )
}}

WITH src_addresses AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'addresses') }}
    ),

renamed_casted AS (
    SELECT
          address_id
         , zipcode
         , country
         , address
         , state
         , _fivetran_deleted
         , _fivetran_synced as date_load
    FROM src_addresses
    )

SELECT * FROM renamed_casted