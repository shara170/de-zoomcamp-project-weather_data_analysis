{{
    config(
        materialized='table'
    )
}}

with 
    airline_lookup_data as ( select * from {{ ref("dim_airline_lookup") }} ),

    airport_lookup_data as ( select * from {{ ref("dim_airports_lookup") }} ),

    routes_lookup_data as ( select * from {{ ref("dim_routes_lookup") }} ),

    forecast_data as ( select * from {{ ref("stg_forecast_data") }} ),




airline_route as (
                    select 
                        routes_lookup_data.iata_code as iata_code_airline, 
                        airline_lookup_data.airline_name, 
                        routes_lookup_data.source_airport_iata, 
                        routes_lookup_data.destination_airport_iata
                    from 
                        routes_lookup_data routes_lookup_data
                    left join 
                        airline_lookup_data airline_lookup_data
                    
                    on airline_lookup_data.iata_code = routes_lookup_data.iata_code
),
  
airline_aiport_route as (select 
    airline_route.iata_code_airline as iata_code_airline, 
    airline_route.airline_name as airline_name, 
    airline_route.source_airport_iata as source_airport_iata, 
    airline_route.destination_airport_iata as destination_airport_iata, 
    airport_lookup_data.city as city, 
    airport_lookup_data.state as state
from 
    airline_route airline_route
inner join
    airport_lookup_data airport_lookup_data

on airline_route.source_airport_iata = airport_lookup_data.iata_code
),

combined as(
select 
    forecast_data.id as id,
    forecast_data.location as location,
    forecast_data.time_utc as time_utc,
    extract(date from forecast_data.time_utc) as date,
    extract(year from forecast_data.time_utc) as year,
    extract(month from forecast_data.time_utc) as month,
    extract(day from forecast_data.time_utc) as day,
    extract(hour from forecast_data.time_utc) as hour,
    forecast_data.time_utc_local as time_utc_local,
    airline_aiport_route.iata_code_airline as iata_code_airline,
    airline_aiport_route.airline_name as airline_name,
    airline_aiport_route.source_airport_iata as source_airport_iata,
    airline_aiport_route.destination_airport_iata as destination_airport_iata,
    forecast_data.cloudbase as cloudbase,
    forecast_data.cloudceiling as cloudceiling,
    forecast_data.cloudcover as cloudcover,
    forecast_data.dewpoint as dewpoint,
    forecast_data.evapotranspiration as evapotranspiration,
    forecast_data.freezingrainintensity as freezingrainintensity,
    forecast_data.humidity as humidity,
    forecast_data.iceaccumulation as iceaccumulation,
    forecast_data.iceaccumulationlwe as iceaccumulationlwe,
    forecast_data.precipitationprobability as precipitationprobability,
    forecast_data.pressuresurfacelevel as pressuresurfacelevel,
    forecast_data.rainaccumulation as rainaccumulation,
    forecast_data.rainaccumulationlwe as rainaccumulationlwe,
    forecast_data.rainintensity as rainintensity,
    forecast_data.sleetaccumulation as sleetaccumulation,
    forecast_data.sleetaccumulationlwe as sleetaccumulationlwe,
    forecast_data.sleetintensity as sleetintensity,
    forecast_data.snowaccumulation as snowaccumulation,
    forecast_data.snowaccumulationlwe as snowaccumulationlwe,
    forecast_data.snowdepth as snowdepth,
    forecast_data.snowintensity as snowintensity,
    forecast_data.temperature as temperature,
    forecast_data.temperatureapparent as temperatureapparent,
    forecast_data.uvhealthconcern as uvhealthconcern,
    forecast_data.uvHealthConcern_strength as uvHealthConcern_strength,
    forecast_data.uvindex as uvindex,
    forecast_data.uvindex_strength as uvindex_strength,
    forecast_data.visibility as visibility,
    forecast_data.weathercode as weathercode,
    forecast_data.winddirection as winddirection,
    forecast_data.windgust as windgust,
    forecast_data.windspeed as windspeed,
    CURRENT_TIMESTAMP() as insert_dt_local,
    ROW_NUMBER() OVER (PARTITION BY location, time_utc ORDER BY time_utc) as rn

from forecast_data forecast_data
left join airline_aiport_route airline_aiport_route
on forecast_data.location = airline_aiport_route.city
)

select * from combined where rn = 1