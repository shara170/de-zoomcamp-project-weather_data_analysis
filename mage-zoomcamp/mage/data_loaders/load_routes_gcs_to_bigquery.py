from mage_ai.settings.repo import get_repo_path
from mage_ai.io.config import ConfigFileLoader
from mage_ai.io.google_cloud_storage import GoogleCloudStorage
from os import path
import os

if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_from_google_cloud_storage(*args, **kwargs):
    
    config_path = path.join(get_repo_path(), 'io_config.yaml')
    config_profile = 'default'

    # bucket which holds routes lookup parquet data file
    data_bucket = os.getenv('DATA_BUCKET')
    object_key = 'routes_lookup.parquet'

    return GoogleCloudStorage.with_config(ConfigFileLoader(config_path, config_profile)).load(
        data_bucket,
        object_key,
    )