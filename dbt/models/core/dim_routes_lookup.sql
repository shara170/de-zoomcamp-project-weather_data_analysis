{{
    config(
        materialized='table'
    )
}}

select * from 
{{ ref("stg_routes_data") }}