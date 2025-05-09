WITH src_addresses AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'addresses') }}
    ),

renamed_casted AS (
    SELECT
         {{ dbt_utils.generate_surrogate_key(['address_id']) }} AS address_id
         , zipcode 
         , country
         , address
         , state
         , _fivetran_deleted
         , _fivetran_synced as date_load
    FROM src_addresses
    )

SELECT * FROM renamed_casted