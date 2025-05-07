{{
  config(
    materialized='view'
  )
}}

WITH src_users AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'users') }}
    ),

renamed_casted AS (
    SELECT
           {{ dbt_utils.generate_surrogate_key(['user_id']) }}
         , updated_at
         , {{ dbt_utils.generate_surrogate_key(['address_id']) }}
         , first_name AS nombre
         , last_name AS primer_apellido
         , created_at
         , phone_number 
         , total_orders
         , email
         , _fivetran_deleted
         , _fivetran_synced as date_load
    FROM src_users
    )

SELECT * FROM renamed_casted