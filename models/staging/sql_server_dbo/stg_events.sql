{{
  config(
    materialized='view'
  )
}}

WITH src_events AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'events') }}
    ),

renamed_casted AS (
    SELECT
          {{dbt_utils.generate_surrogate_key(['event_id'])}} AS event_id
         , page_url
         , event_type
         , user_id
         , {{rellenyo(product_id)}}
         , session_id
         , created_at
         , order_id
         , _fivetran_deleted
         , _fivetran_synced as date_load
    FROM src_events
    )

SELECT * FROM renamed_casted