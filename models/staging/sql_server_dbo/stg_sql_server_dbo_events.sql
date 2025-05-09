{{ config(materialized="view") }}

with
    src_events as (select * from {{ source("sql_server_dbo", "events") }}),

    renamed_casted as (
        select
            {{ dbt_utils.generate_surrogate_key(["event_id"]) }} as event_id,
            page_url,
            event_type,
            user_id,
            {{rellenyo('product_id')}},
            session_id,
            created_at,
            order_id,
            _fivetran_deleted,
            _fivetran_synced as date_load
        from src_events
    )

select *
from renamed_casted
