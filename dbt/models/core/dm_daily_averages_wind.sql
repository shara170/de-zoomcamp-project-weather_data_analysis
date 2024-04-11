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

    sum(rainintensity) as average_rainintensity,
    sum(windgust) as average_windgust,
    sum(windspeed) as average_windspeed
    
from weather_data
group by 1,2,3