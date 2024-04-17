from mage_ai.settings.repo import get_repo_path
from mage_ai.io.bigquery import BigQuery
from mage_ai.io.config import ConfigFileLoader
from pandas import DataFrame
from os import path
import os

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter


@data_exporter
def export_data_to_big_query(df: DataFrame, **kwargs) -> None:
    
    project_id = os.getenv('PROJECT_ID')
    dataset_name = os.getenv('DATASET_NAME')
    routes_data_table = os.getenv('DATA_TABLE_ROUTE')
    
    # Path of the routes lookup data table in BigQuery
    table_id = f'{project_id}.{dataset_name}.{routes_data_table}'
    
    config_path = path.join(get_repo_path(), 'io_config.yaml')
    config_profile = 'default'

    BigQuery.with_config(ConfigFileLoader(config_path, config_profile)).export(
        df,
        table_id,
        if_exists='replace',  # Specify resolution policy if table name already exists
    )
