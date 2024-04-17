import pandas as pd

if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data(*args, **kwargs):
    # Read routes csv data file
    routes_data = pd.read_csv("https://raw.githubusercontent.com/shara170/de-zoomcamp-project-weather_data_analysis/main/data/routes.dat",
                                header=None, names=["iata_code", "airline_id", "source_airport_iata", "source_airport_id",
                        "destination_airport_iata", "destination_airport_id", "codeshare", "stops", "equipment" ])

    return routes_data