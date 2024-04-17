import pandas as pd

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):

    data = data.dropna()

    #fill missing values with zeros - for now - simple cleaning
    data = data.fillna(0)

    # Handle missing data (if available)
    data["country"].isnull().sum() 

    # Drop unwanted values in Country column
    unwanted_values = ['Air S', 'DRAGON', 'ALASKA', 'AVIANCA', 'S.A.', 'French Guiana', 'French Polynesia']
    data = data[~data['country'].isin(unwanted_values)]

    # Keeping only United states airlines for Domestic data analyis
    data = data[data['country'] == 'United States']

    data.drop('alias', axis=1, inplace=True)

    data.set_index('airline_id')
    #data.reset_index(drop=True, inplace=True)

    return data