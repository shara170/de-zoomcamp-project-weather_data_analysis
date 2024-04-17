import pandas as pd

if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data(*args, **kwargs):
    # Read airline csv data file
    airline_data = pd.read_csv("https://raw.githubusercontent.com/shara170/de-zoomcamp-project-weather_data_analysis/main/data/Final_airlines",
                                header=None, names=["airline_id", "airline_name", "alias", "iata_code", "icao_code", "callsign", "country", "active" ])

    return airline_data