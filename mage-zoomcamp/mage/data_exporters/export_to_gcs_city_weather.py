from mage_ai.settings.repo import get_repo_path
from mage_ai.io.config import ConfigFileLoader
from mage_ai.io.google_cloud_storage import GoogleCloudStorage
from pandas import DataFrame
from os import path
import os

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter


@data_exporter
def export_data_to_google_cloud_storage(df: DataFrame, **kwargs) -> None:

    # Get the current date to attach to the name of the parquet file
    now = kwargs.get('execution_date')
    now_fpath = now.strftime("%Y/%m/%d")
    file_name = now.strftime("%Y_%m_%d")

    config_path = path.join(get_repo_path(), 'io_config.yaml')
    config_profile = 'default'

    # Bucket name which will hold parquet forecast data files
    weather_bucket = os.getenv('WEATHER_BUCKET')
    object_key = f'weather_daily_in/{now_fpath}/daily-weather_{file_name}.parquet'

    
    GoogleCloudStorage.with_config(ConfigFileLoader(config_path, config_profile)).export(
        df,
        weather_bucket,
        object_key,
    )
