{{
    config(
        materialized='table'
    )
}}

select * from 
{{ ref("stg_airline_data") }}