{{
  config(
    materialized='view'
  )
}}

WITH src_addresses AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'ADDRESSES') }}
    ),

renamed_casted AS (
    SELECT
          ADDRESS_ID
          , ZIPCODE
          , COUNTRY
          , ADDRESS
          , STATE
          , _FIVETRAN_DELETED
          , _FIVETRAN_SYNCED AS date_load
    FROM src_addresses
    )

SELECT * FROM renamed_casted