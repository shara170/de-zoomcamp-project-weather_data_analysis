{{
    config(
        materialized='view'
    )
}}

with weather_data as (

    select *,
    row_number() over(partition by location, time_utc) as rn
    from {{ source('staging', 'forecast_data') }}
    where location is not null 

)



select
    -- identifiers
    {{ dbt_utils.generate_surrogate_key(['location', 'time_utc']) }} as id,
    cast(location as string) as location,

     -- timestamps
    cast(time_utc as timestamp) as time_utc,
    cast(time_utc_local as timestamp) as time_utc_local,

    -- Replace null values with 'Unknown' for latitude and longitude columns
    cast(cloudbase AS NUMERIC) as cloudbase,

    cast(cloudceiling AS NUMERIC) as cloudceiling,
    cast(cloudcover AS NUMERIC) as cloudcover,
    cast(dewpoint AS NUMERIC) as dewpoint,
    cast(evapotranspiration AS NUMERIC) as evapotranspiration,
    cast(freezingrainintensity AS NUMERIC) as freezingrainintensity,
    cast(humidity AS NUMERIC) as humidity,

    cast(iceaccumulation AS NUMERIC) as iceaccumulation,
    cast(iceaccumulationlwe AS NUMERIC) as iceaccumulationlwe,
    cast(precipitationprobability AS NUMERIC) as precipitationprobability,
    cast(pressuresurfacelevel AS NUMERIC) as pressuresurfacelevel,

    cast(rainaccumulation AS NUMERIC) as rainaccumulation,
    cast(rainaccumulationlwe AS NUMERIC) as rainaccumulationlwe,
    cast(rainintensity AS NUMERIC) as rainintensity,
    cast(sleetaccumulation AS NUMERIC) as sleetaccumulation,

    cast(sleetaccumulationlwe AS NUMERIC) as sleetaccumulationlwe,
    cast(sleetintensity AS NUMERIC) as sleetintensity,
    cast(snowaccumulation AS NUMERIC) as snowaccumulation,

    cast(snowaccumulationlwe AS NUMERIC) as snowaccumulationlwe,
    cast(snowdepth AS NUMERIC) as snowdepth,
    cast(snowintensity AS NUMERIC) as snowintensity,

    cast(temperature AS NUMERIC) as temperature,
    cast(temperatureapparent AS NUMERIC) as temperatureapparent,
    cast(uvhealthconcern AS NUMERIC) as uvhealthconcern,

    {{ get_uvHealthConcern_strength(uvhealthconcern) }} as uvHealthConcern_strength,

    cast(uvindex AS NUMERIC) as uvindex,

    {{ get_uvIndex_strength(uvindex) }} as uvindex_strength,

    cast(visibility AS NUMERIC) as visibility,
    cast(weathercode AS NUMERIC) as weathercode,
    cast(winddirection AS NUMERIC) as winddirection,
    cast(windgust AS NUMERIC) as windgust,

    cast(windspeed AS NUMERIC) as windspeed,
    cast(insert_dt as timestamp) as insert_dt
    
from weather_data
where rn = 1