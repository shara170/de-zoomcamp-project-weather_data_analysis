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

Static pipelines: 
- **airline_to_gcs**:
  - Data is initially sourced from Kaggle, providing comprehensive details about airlines, including their codes and names. Subsequently, the data is uploaded to a GitHub repository, and a link is utilized to ingest the data into the pipeline for subsequent processing
    
  - In the subsequent step, basic transformations are applied to clean the dataset, including actions such as filling missing values and dropping unwanted entries
    
  - In the final stage, the processed data is encapsulated within a Parquet file to compress it effectively. Subsequently, this compressed data is exported to a GCS bucket for storage.
    
  - Since this is a one-time load, there are no triggers set for this pipeline. It needs to be manually executed
 
- **airline_gcs_to_bigquery**:
  - In this pipeline, Parquet airline data is extracted from the bucket where it was deposited by the "airline_to_gcs" pipeline
    
  - No transformations are necessary as they were handled in airline_to_gcs pipeline
    
  - In the last step, the data is exported to the "airline_lookup" table within the "weather_data" dataset in BigQuery
    
  - Since this is a one-time load, no triggers are set for this pipeline. It needs to be manually executed once the data consumption from the "airline_to_gcs" pipeline is finalized
 
- **routes_to_gcs**:
  - Data is initially sourced from Kaggle, providing comprehensive details about airline routes such as origin, destination, airline code, etc. Subsequently, the data is uploaded to a GitHub repository, and a link is utilized to ingest the data into the pipeline for subsequent processing
    
  - In the subsequent step, basic transformations are applied to clean the dataset, including actions such as filling missing values
    
  - In the final stage, the processed data is encapsulated within a Parquet file to compress it effectively. Subsequently, this compressed data is exported to a GCS bucket for storage
    
  - Since this is a one-time load, there are no triggers set for this pipeline. It needs to be manually executed

- **routes_gcs_to_bigquery**:
  - In this pipeline, Parquet airline route data is extracted from the bucket where it was deposited by the "routes_to_gcs" pipeline
    
  - No transformations are necessary as they were handled in routes_to_gcs pipeline
    
  - In the last step, the data is exported to the "routes_lookup" table within the "weather_data" dataset in BigQuery
    
  - Since this is a one-time load, no triggers are set for this pipeline. It needs to be manually executed once the data consumption from the "routes_to_gcs" pipeline is finalized.

Dynamic pipelines:
- **etl_web_to_gcs_weather**: 
  - In the initial phase, data ingestion occurs from Kaggle, housing a static dataset providing insights of all cities within the state of Florida. For example, city name, lat, long, etc.
  - In the subsequent step, further data ingestion takes place by issuing API calls for each city in Florida to retrieve the upcoming 24-hour weather forecast. Following this, a series of transformations are applied to the ingested data
  
  - In the final step, the processed data is exported to a GCS bucket, with each day's data neatly organized into its respective folder
 
  - Additionally, triggers have been configured to automatically execute the aforementioned three steps at a specific time each day, precisely at midnight
 
- **etl_gcs_to_bigquery_weather**:
  - In the initial step, data extraction from the GCS bucket retrieves information solely for the present day. For instance, if today is April 11, 2024, only data corresponding to that particular day is ingested, excluding any preceding days' data
    
  - No transformations are necessary in the transformation block
    
  - In the final step, every day data is appended to a table in BigQuery
    
  - The triggers are configured to activate one hour after the completion of the aforementioned pipeline, ensuring timely consumption of the data deposited in the GCS bucket every day

#### 2. Data Warehouse
- BigQuery is integral to this project, with all data, both one-time loads and ongoing, housed within the "weather_data" dataset
  
- Airline information is stored in the "airline_lookup" table within "weather_data" dataset
  
- Route information is stored in the "routes_lookup" table within "weather_data" dataset
  
- Weather forecast for the next 24 hours for few cities of Florida are stored within "forecast_data" dataset

#### 3. Data Transformations
- Transformation of data in the underlying BigQuery tables are done using dbt cloud

- Weather forecast data is seamlessly integrated with airline and route information. This integration facilitates advanced visualization, enabling deeper insights that aid in making informed decisions regarding whether flights should proceed or be grounded
  
- The job is scheduled for daily execution in the production environment using dbt Cloud. Subsequently, the transformed and integrated production data is deposited into the designated "prod" dataset in BigQuery
  
- Core tables are:
  - dim_airline_lookup
  - dim_airports_lookup
  - dim_routes_lookup
  - fact_weather_data
  - dm_daily_averages_snow
  - dm_daily_averages_wind

  <img width="1124" alt="image" src="https://github.com/shara170/de-zoomcamp-project-weather_data_analysis/assets/128853856/294c5355-c5c3-4ccb-a520-1de007678c1e">



## Data set Description


## Summary 


## Reproducing the project

#### 1. Clone the repository:
```
git clone https://github.com/shara170/de-zoomcamp-project-weather_data_analysis.git
```

#### 2. Setup GCP account:
- Setup up a GCP free account if you do not have one
- Create a new project id
- Setup a service account. Select roles for this account (Bigquery Admin, Compute Admin and storage Admin Roles)
- Create a key and download this file in your computer, it will be a json file. This key will be used to authenticate google services and resources

#### 3. Connect to VM:
- Set up Virtual Machine on GCP (To see instructions on how to create VM instance, follow this [VM instance + SSH key](https://www.youtube.com/watch?v=ae-CV2KfoN0&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb&index=14)


## Dashboard
