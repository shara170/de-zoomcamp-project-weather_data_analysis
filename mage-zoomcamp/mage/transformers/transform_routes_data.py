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

    data.reset_index(drop=True, inplace=True)

    return data
