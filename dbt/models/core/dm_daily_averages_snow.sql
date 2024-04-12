{{
    config(
        materialized='table'
    )
}}

with weather_data as (
    select * from {{ ref('fact_weather_data') }}
)

select
    location as location,
    {{ dbt.date_trunc("day", "time_utc") }} as day,  
    source_airport_iata,

    sum(iceaccumulation) as average_iceaccumulation,
    sum(sleetaccumulation) as average_sleetaccumulation,
    sum(sleetintensity) as average_sleetintensity,
    sum(snowaccumulation) as average_snowaccumulation,
    sum(snowdepth) as average_snowdepth,
    sum(snowintensity) as average_snowintensity
    
from weather_data
group by 1,2,3