{{
    config(
        materialized='table'
    )
}}

with routes_data as (
    select * 
    from {{ source('staging', 'routes_lookup') }}
)

select * from routes_data