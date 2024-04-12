{{
    config(
        materialized='view'
    )
}}

with airline_data as (
    select * 
    from {{ source('staging', 'airline_lookup') }}
)

select * from airline_data