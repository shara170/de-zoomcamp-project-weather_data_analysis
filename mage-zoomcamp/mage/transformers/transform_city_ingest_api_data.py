import pandas as pd
import requests
import time
from datetime import datetime, timedelta
import pytz
import os

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


BASE_URL_FORECAST = "https://api.tomorrow.io/v4/weather/forecast?location="
HEADERS = {"accept": "application/json"}
API_KEY = os.getenv('API_KEY')
UNITS = "imperial"
TIMESTEPS = "1h"

@transformer
def transform(data, *args, **kwargs):
    # Function to fetch just the city names from the dataframe and appending to a city list
    def fetch_city_data(df):
        cities = []
        for index, row in df.iterrows():
            cities.append(row['city'])
    
        return cities

    # Function to fetch weather information of the cities by making API calls
    def fetch_weather_data(city):
        response = requests.get(f'{BASE_URL_FORECAST}{city}&timesteps={TIMESTEPS}&units={UNITS}&apikey={API_KEY}')
        # Returning the hourly forecast data
        return response.json()['timelines']['hourly']

    # Function to return the local time by converting 
    def get_local_time(utc_time_str):
        time_local = []
        for i in utc_time_str:
            utc_datetime = datetime.strptime(i, '%Y-%m-%dT%H:%M:%SZ')
            utc_timezone = pytz.utc
            local_datetime = utc_timezone.localize(utc_datetime).astimezone()
            local_datetime = local_datetime.strftime('%Y-%m-%d %H:%M:%S')

            time_local.append(str(local_datetime))

        return pd.Series(time_local)

    def transform_data(cities):
        # Empty dataframe
        dataframe_list = []

        for city in cities:
            # Calling function to fetch weather data of all the cities
            hourly_data = fetch_weather_data(city)
            # Exploing the json values
            data = pd.json_normalize(hourly_data)

            # Section to read only the next 24 hour forecast data
            value_24hour = pd.to_datetime(data['time'].iloc[0]) + timedelta(hours=24)
            value_24hour = value_24hour.strftime('%Y-%m-%dT%H:%M:%SZ')

            data = data[data['time'] <= value_24hour]

            # Inserting the name of the city at the beginning of the dataframe
            data.insert(0, 'location', city)

            # Calling function to convert the time in UTC to local time
            time_local = get_local_time(data['time'])

            # Inserting the local time at the 2nd position of the dataframe
            data.insert(2, 'time_local', time_local)
            
            data['time_local'] = pd.to_datetime(data['time_local'])

            data['time'] = pd.to_datetime(data['time']).dt.tz_localize(None)
            data['insert_dt'] = pd.to_datetime(datetime.now().replace(microsecond=0))

            dataframe_list.append(data)
            time.sleep(1)

        # Concatenating the dataframes with all the cities
        return pd.concat(dataframe_list, ignore_index=True)


    #Function to set the datatypes of all the fields
    def set_datatypes(df):
        # Renaming columns
        df.columns = (df.columns
                            .str.replace('values.', '')
                            .str.replace('time', 'time_UTC')
                            .str.lower()
                        )

        data_types = {
                        'location': str,
                        'cloudbase': float,
                        'cloudceiling': float,
                        'cloudcover': float,
                        'dewpoint': float,
                        'evapotranspiration': float,
                        'freezingrainintensity': float,
                        'humidity': float,
                        'iceaccumulation': float,
                        'iceaccumulationlwe': float,
                        'precipitationprobability': float,
                        'pressuresurfacelevel': float,
                        'rainaccumulation': float,
                        'rainaccumulationlwe': float,
                        'rainintensity': float,
                        'sleetaccumulation': float,
                        'sleetaccumulationlwe': float,
                        'sleetintensity': float,
                        'snowaccumulation': float,
                        'snowaccumulationlwe': float,
                        'snowdepth': float,
                        'snowintensity': float,
                        'temperature': float,
                        'temperatureapparent': float,
                        'uvhealthconcern': float,
                        'uvindex': float,
                        'visibility': float,
                        'weathercode': pd.Int64Dtype(),
                        'winddirection': float,
                        'windgust': float,
                        'windspeed': float
        }
        return df.astype(data_types)



    def start_transform(df):
        cities = fetch_city_data(df)
        transformed_df = transform_data(cities)
        transformed_df = set_datatypes(transformed_df)
        return transformed_df

        
    result_df = start_transform(data)

    return result_df