# de-zoomcamp-project-weather_data_analysis

## Problem Statement


## Tech Stack
- Google Cloud Platform- GCP platform for providing infrastructure for cloud computation, data lake storage and data warehouse solution
  - [Google Data Storage](https://cloud.google.com/storage?hl=en) - GCS for storing our data in Data Lake
  - [Google BigQuery](https://cloud.google.com/bigquery?hl=en) - Google BigQuery as a Data Warehouse solution for analysing our data
- [Mage](https://docs.mage.ai/introduction/overview)  - Data and workflow orchestration
- [Terraform](https://www.terraform.io/) - Infrastructure as a code (IaC) to create and manipulate GCP resources
- [dbt](https://www.getdbt.com/) - Saas application to develop and manage dbt project. Sits on top of Google BigQuery to perform transformations on the underlying data which is then used to build reports for business users
- [Looker Studio](https://lookerstudio.google.com/u/0/navigation/reporting) - For visualizing the data
- [Docker](https://www.docker.com/) - Containerization of applications



## Data Architecture



## Data Flow Overview

Pipelines 
- Two Dynamic pipelines
- Four static pipelines

#### 1. Data Ingestion

Within this project, the orchestration tool at play is Mage. It systematically retrieves data in batches from an API endpoint and gathers static datasets from Kaggle. Following data manipulation, it diligently deposits the processed data into GCS buckets. Subsequently, the data is extracted and meticulously loaded into our designated data warehouse.

Within this project, there are a total of 6 pipelines in operation. Among them, 2 are dynamic, meaning they run periodically. The remaining 4 pipelines are tasked with fetching static data from Kaggle, transferring it into GCS, and then seamlessly integrating it into the data warehouse.

Pipeline description is as below:

- **etl_web_to_gcs_weather**: 
  - In the initial phase, data ingestion occurs from Kaggle, housing a static dataset providing insights of all cities within the state of Florida. For example, city name, lat, long, etc.
  - In the subsequent step, further data ingestion takes place by issuing API calls for each city in Florida to retrieve the upcoming 24-hour weather forecast. Following this, a series of transformations are applied to the ingested data.
  
  - In the final step, the processed data is exported to a GCS bucket, with each day's data neatly organized into its respective folder.
 
  - Additionally, triggers have been configured to automatically execute the aforementioned three steps at a specific time each day, precisely at midnight.
 
- **etl_gcs_to_bigquery_weather**:
  - In the initial step, data extraction from the GCS bucket retrieves information solely for the present day. For instance, if today is April 11, 2024, only data corresponding to that particular day is ingested, excluding any preceding days' data.
  - No transformations are necessary in the transformation block
  - In the final step, every day data is appended to a table in BigQuery
  - The triggers are configured to activate one hour after the completion of the aforementioned pipeline, ensuring timely consumption of the data deposited in the GCS bucket every day.


## Data set Description


## Summary 


## Reproducing the project


## Dashboard
