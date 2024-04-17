import pandas as pd
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data(*args, **kwargs):
    # Read the csv file which holds information of few cities of Florida
    
    dataset_cities = "https://raw.githubusercontent.com/shara170/de-zoomcamp-project-weather_data_analysis/main/data/uscities.csv"
    data = pd.read_csv(dataset_cities, on_bad_lines='skip', sep=';')
    df = data[data['state_name']=='Florida']
    df = df.head(5)

    return df