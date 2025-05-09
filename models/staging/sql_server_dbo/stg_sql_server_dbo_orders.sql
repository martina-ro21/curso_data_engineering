{{
  config(
    materialized='view'
  )
}}

WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'orders') }}
    ),

renamed_casted AS (
    SELECT
          {{ dbt_utils.generate_surrogate_key(['order_id']) }} AS order_id
         , {{rellenyo('shipping_service')}}
         , shipping_cost
         , {{ dbt_utils.generate_surrogate_key(['address_id']) }} AS address_id
         , created_at
         , LOWER({{ rellenyo('promo_id') }}) AS promo_id
         , estimated_delivery_at
         , order_cost
         , {{ dbt_utils.generate_surrogate_key(['user_id']) }} AS user_id
         , order_total
         , delivered_at
         , {{ dbt_utils.generate_surrogate_key(['tracking_id']) }} AS tracking_id
         , status
         , _fivetran_deleted
         , _fivetran_synced as date_load
    FROM src_orders
    )

SELECT * FROM renamed_casted