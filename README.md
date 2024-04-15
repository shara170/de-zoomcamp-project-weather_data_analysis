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
This pipeline first consumes a static dataset from Kaggle which gives information of all the cities in the state of Florida. 

## Data set Description


## Summary 


## Reproducing the project


## Dashboard
