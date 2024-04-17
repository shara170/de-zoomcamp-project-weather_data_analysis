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
    
    config_path = path.join(get_repo_path(), 'io_config.yaml')
    config_profile = 'default'

    # bucket which holds routes lookup parquet data file
    data_bucket = os.getenv('DATA_BUCKET')
    object_key = 'routes_lookup.parquet'

    GoogleCloudStorage.with_config(ConfigFileLoader(config_path, config_profile)).export(
        df,
        data_bucket,
        object_key,
    )
