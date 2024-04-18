# de-zoomcamp-project-weather_data_analysis

## Contents
- [Problem Statment](https://github.com/shara170/de-zoomcamp-project-weather_data_analysis?tab=readme-ov-file#problem-statement)
- [Tech Stack](https://github.com/shara170/de-zoomcamp-project-weather_data_analysis?tab=readme-ov-file#tech-stack)
- [Reproducing the Project](https://github.com/shara170/de-zoomcamp-project-weather_data_analysis?tab=readme-ov-file#reproducing-the-project)
  - [Setup GCP account](https://github.com/shara170/de-zoomcamp-project-weather_data_analysis?tab=readme-ov-file#1-setup-gcp-account)
  - [Install Docker](https://github.com/shara170/de-zoomcamp-project-weather_data_analysis?tab=readme-ov-file#2-install-docker)
  - [Setup Terraform and Fire up Terraform](https://github.com/shara170/de-zoomcamp-project-weather_data_analysis?tab=readme-ov-file#3-setup-terraform-and-fire-up-terraform)
  - [Connect to VM](https://github.com/shara170/de-zoomcamp-project-weather_data_analysis?tab=readme-ov-file#4-connect-to-vm-optional-if-are-using-compute-engine)
  - [Clone the repository](https://github.com/shara170/de-zoomcamp-project-weather_data_analysis?tab=readme-ov-file#5-clone-the-repository-in-case-you-have-missed-this-step-above)
  - [Setup Mage](https://github.com/shara170/de-zoomcamp-project-weather_data_analysis?tab=readme-ov-file#6-setup-mage)
  - [DBT](https://github.com/shara170/de-zoomcamp-project-weather_data_analysis?tab=readme-ov-file#7-dbt)
  - [Visualization](https://github.com/shara170/de-zoomcamp-project-weather_data_analysis?tab=readme-ov-file#8-visualization)
- [Data Architecture](https://github.com/shara170/de-zoomcamp-project-weather_data_analysis?tab=readme-ov-file#data-architecture)
- [Data Flow Overview](https://github.com/shara170/de-zoomcamp-project-weather_data_analysis?tab=readme-ov-file#data-flow-overview)
  - [Data Ingestion](https://github.com/shara170/de-zoomcamp-project-weather_data_analysis?tab=readme-ov-file#1-data-ingestion)
  - [Data Warehouse](https://github.com/shara170/de-zoomcamp-project-weather_data_analysis?tab=readme-ov-file#2-data-warehouse)
  - [Data Transformations](https://github.com/shara170/de-zoomcamp-project-weather_data_analysis?tab=readme-ov-file#3-data-transformations)
- [Data set Description](https://github.com/shara170/de-zoomcamp-project-weather_data_analysis?tab=readme-ov-file#data-set-description)
  - [Weather forecast data](https://github.com/shara170/de-zoomcamp-project-weather_data_analysis?tab=readme-ov-file#1-weather-forecast-data)
  - [Airline data](https://github.com/shara170/de-zoomcamp-project-weather_data_analysis?tab=readme-ov-file#2-airline-data)
- [Dashboard](https://github.com/shara170/de-zoomcamp-project-weather_data_analysis?tab=readme-ov-file#dashboard)

## Problem Statement

In this project, we leverage weather forecast data to anticipate weather conditions in select cities across Florida. Unfortunately, Florida often experiences severe weather events like turbulence and storms, causing significant disruptions to airport operations and flight schedules.

By closely monitoring weather patterns such as visibility, wind speed, and precipitation, airport authorities can effectively manage ground operations. Informed decisions regarding runway usage, aircraft de-icing procedures, and ground handling operations can be made, ensuring smoother and safer journeys for passengers.

Additionally, by analyzing weather forecasts and real-time data, airport authorities can proactively avoid turbulence, storms, and other adverse conditions, thereby enhancing the overall safety and efficiency of flight operations.
Furthermore, weather forecasts play a crucial role in anticipating weather-related disruptions to airport operations, such as snowstorms or fog. This enables airport authorities to implement contingency plans and minimize delays, ensuring continued operational resilience.

We have taken advantage of the forecast data from the API endpoint of [Tomorrow.io](https://app.tomorrow.io/home) which can be simply used by creating an account on their website. This platform is a weather intelligence platform offering hyper-local forecasts and insights for businesses and individuals worldwide.
Other datasets used in this project are derived from [Kaggle](https://www.kaggle.com/datasets/arbazmohammad/world-airports-and-airlines-datasets)
 

## Tech Stack
- Google Cloud Platform- GCP platform for providing infrastructure for cloud computation, data lake storage and data warehouse solution
  - [Google Data Storage](https://cloud.google.com/storage?hl=en) - GCS for storing our data in Data Lake
  - [Google BigQuery](https://cloud.google.com/bigquery?hl=en) - Google BigQuery as a Data Warehouse solution for analysing our data
- [Mage](https://docs.mage.ai/introduction/overview)  - Data and workflow orchestration
- [Terraform](https://www.terraform.io/) - Infrastructure as a code (IaC) to create and manipulate GCP resources
- [dbt](https://www.getdbt.com/) - Saas application to develop and manage dbt project. Sits on top of Google BigQuery to perform transformations on the underlying data which is then used to build reports for business users
- [Looker Studio](https://lookerstudio.google.com/u/0/navigation/reporting) - For visualizing the data
- [Docker](https://www.docker.com/) - Containerization of applications


## Reproducing the project

#### 1. Setup GCP account:
- Setup up a GCP account and create a new project id
- Setup a service account. Select roles for this account (Bigquery Admin, Compute Admin and storage Admin Roles)
- Create a key and download this file in your computer, it will be a json file. This key will be used to authenticate google services and resources


#### 2. Install Docker:
- Follow [Docker install](https://www.youtube.com/watch?v=ae-CV2KfoN0&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb&index=15)


#### 3. Setup Terraform and Fire up Terraform:
- Setup Terraform (Follow [Terraform download](https://www.youtube.com/watch?v=ae-CV2KfoN0&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb&index=16))
- Clone this repo:
  ```
  git clone https://github.com/shara170/de-zoomcamp-project-weather_data_analysis.git
  ```
- Navigate to the project folder ``` cd de-zoomcamp-project-weather_data_analysis ```
- Navigate into the "terraform" directory by executing below command:
  ```
  cd terraform/
  ```
- Edit the variables.tf file to match your resources such as:
  - Project ID (Place the project ID in the default sub-section of project section)
  - Region
  - bq_dataset_name (BigQuery dataset name)
  - gcs_bucket_name (GCS bucket name for storing forecast data produced by the pipeline)
  - gcs_bucket_data (GCS bucket name for storing airline data produced by the pipelines)
    
- Finally, execute the following:
  - ``` terraform init ``` This command is used to initialize terraform and get all the cloud providers
  - ``` terraform plan ``` This command will show the resources that will be created
  - ``` terraform apply ``` This command will create the resources which are defined in the main.tf file (In this case -- resources will be created)
  

#### 4. Connect to VM: (Optional if are using compute engine)
- Set up Virtual Machine on GCP (Follow [VM instance + SSH key](https://www.youtube.com/watch?v=ae-CV2KfoN0&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb&index=14 to see instructions)
- Create a config file to update and manage the External IPs of the VM instance anytime its suspended/restarted [Configure External IP](https://www.youtube.com/watch?v=ae-CV2KfoN0&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb&index=17)
- Remember the compute engine is a virtual machine and a local machine can be used for this project but it does make things easier. 
- Open your terminal and ssh into your remote instance. The remote instance is bare and so install the necessary packages


#### 5. Clone the repository (In case you have missed this step above):
```
git clone https://github.com/shara170/de-zoomcamp-project-weather_data_analysis.git
```


#### 6. Setup Mage:
- Navigate to the project folder ``` cd de-zoomcamp-project-weather_data_analysis ```
- Navigate to the mage folder by running below command:
  ```
  cd mage-zoomcamp
  ```
- Open VS code by executing ``` code . ```
- Setup environment vairables in dev.env files for Mage like below. Change the values as to your liking but make sure that the resources match with terraform variables.tf:
    - ``` API_KEY=<your_api_key> ```
    - ``` PROJECT_ID=silicon-mile-412319 ```
    - ``` WEATHER_BUCKET=silicon-mile-412319-weather ```
    - ``` DATA_BUCKET=silicon-mile-412319-data ```
    - ``` DATASET_NAME=weather_data ```
    - ``` WEATHER_TABLE=forecast_data ```
    - ``` DATA_TABLE_AIRLINE=airline_lookup ```
    - ``` DATA_TABLE_ROUTE=routes_lookup ```

   NOTE: You can get your API_KEY value by simply creating an account [here](https://app.tomorrow.io/home)
-  Execute ``` cp dev.env .env ```
-  **Important: Place your json key file created in step 1 in "mage-zoomcamp" folder which is now the root folder in your VS code**
-  Change the filepath in io_config.yml accordingly. For example: GOOGLE_SERVICE_ACC_KEY_FILEPATH: "/home/src/mage_zoomcamp.json"
-  Ensure that docker is installed properly. Can check by running ``` docker --version ``` in the terminal
-  Run ``` docker compose build ``` to build an image by taking instructions from Docker file as well as Docker-compose file
-  To pull the latest image from the Mage repo, execute below:
   ``` docker pull mageai/mageai:latest ```
-  Once the docker image is created, execute below command in your terminal to fire up the Mage application. Ensure the port has been forwarded to 6789
   ```
   docker-compose up
   ```
-  Navigate to http://localhost:6789/ in your web browser to access Mage application
-  File structure should look like this and you should be able to see all the pipelines in your structure:
  
    <img width="398" alt="image" src="https://github.com/shara170/de-zoomcamp-project-weather_data_analysis/assets/128853856/86e6f23e-b4c0-4276-aabe-f2d7b9afa86e">

    This is how the pipelines looks like:
  
    <img width="1246" alt="image" src="https://github.com/shara170/de-zoomcamp-project-weather_data_analysis/assets/128853856/7485968c-3ae6-4a6c-af12-dc5b4b2c78a6">
    
-  Watch this video if needed to undertsand how the data is extracted from and API call and placed into GCS bucket [ETL:API to GCS Mage](https://www.youtube.com/watch?v=w0XmcASRUnc&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb&index=25)
  
-  **Triggers**:
    - **etl_web_to_gcs_weather**: In this project, this pipeline is being run at a certain interval of time which is daily at 12:00 AM UTC.
      You can just run the pipeline once
      
      <img width="599" alt="image" src="https://github.com/shara170/de-zoomcamp-project-weather_data_analysis/assets/128853856/0717bc64-76fb-4dc0-b23d-3d49b7208367">

      Once the pipeline is completed, you will see a parquet data file created as such:
      
      <img width="795" alt="image" src="https://github.com/shara170/de-zoomcamp-project-weather_data_analysis/assets/128853856/39de906d-5637-4cfd-ad8c-e14b60f7584d">
      
    - **etl_gcs_to_bigquery_weather**: This pipeline will be automatically triggered once the above pipeline completes. Once this pipeline is completed, you will see the data in BigQuery with the schema such as- silicon-mile-412319.weather_data.forecast_data
       
    - **airline_to_gcs**: This pipeline needs to be run once manually as this pipeline will pull static data. Trigger the pipeline once
      
      It will trigger a set of pipelines. The pipelines that it will trigger: airline_gcs_to_bigquery, routes_to_gcs, routes_gcs_to_bigquery
      
      Once the pipeline execution is completed, you should be able to see below mentioned parquet data files in the bucket "silicon-mile-412319-data":
       - airline_lookup.parquet
       - routes_lookup.parquet

      <img width="546" alt="image" src="https://github.com/shara170/de-zoomcamp-project-weather_data_analysis/assets/128853856/04ed1d53-7be2-489d-810d-1128d65f9df6">

      Also, you should be able to see the tables "weather_data.airline_lookup" and "weather_data.routes_lookup" in BigQuery
      
      <img width="252" alt="image" src="https://github.com/shara170/de-zoomcamp-project-weather_data_analysis/assets/128853856/5ed38a1c-b3f8-4121-a6dd-a88df160a770">

   
#### 7. DBT:
- In this project, I have used dbt cloud but it can be used locally as well
- Open a free dbt account [here](https://www.getdbt.com/signup)
- Follow the instructions [here](https://github.com/DataTalksClub/data-engineering-zoomcamp/blob/main/04-analytics-engineering/dbt_cloud_setup.md) to undertsand how to setup BigQuery with dbt cloud
- Create a new file in seeds folder and place the contents of the "airports_lookup.csv" file present in the "dbt" folder of this repo and execute ``` dbt build ``` for that seed
- Replicate the file structue as in the folder "dbt" of this project. This is how it will look like:

  <img width="413" alt="image" src="https://github.com/shara170/de-zoomcamp-project-weather_data_analysis/assets/128853856/ca0211f9-ad97-4c83-a12e-39a18d5f4977">

- DAG will look like this:

  <img width="1124" alt="image" src="https://github.com/shara170/de-zoomcamp-project-weather_data_analysis/assets/128853856/294c5355-c5c3-4ccb-a520-1de007678c1e">

- Build the models using ``` dbt build ```
- Once the models are successfully build, dataset in BigQuery will look like this:

  <img width="366" alt="image" src="https://github.com/shara170/de-zoomcamp-project-weather_data_analysis/assets/128853856/05c4eeca-2532-4fe7-8b40-4ec0960a4d3a">


- Create Environment:
  - Navigate to Deploy > Environments > Create Environment
  - Environment name: Prod
  - Environment type: Deployment
  - Deployment credentials > Dataset: prod
- Create Job:
  - Navigate to the env "Prod" > Create Job > Deploy Job
  - Job Name: Nightly
  - Environment: Production
  - Execution Settings > Commands: dbt build
  - Runs on Schedule:
    - Timing: Specific hours
    - Runs at(UTC): 9
    - Days of the week: Select all days
  - Run the job manually.
  Once the job is completed, this is how the dataset in BigQuery looks like:

  <img width="373" alt="image" src="https://github.com/shara170/de-zoomcamp-project-weather_data_analysis/assets/128853856/c69c9759-b8ab-4173-a0a3-f14c174cefd8">


#### 8. Visualization: 
Looker studio has been used in this project to visualize the data and to draw some insights from the data. Below are the steps to replicate the visualization dashboard:

- Create a blank report on Looker by navigating [here](https://lookerstudio.google.com/u/0/navigation/reporting)
- Select the BigQuery connector and connect to the processed data lying in BigQuery
- Select your project > prod (This is the dataset which we created from dbt cloud) > fact_weather_data (This is the fact table we created using dbt cloud model)
- Start building dashboard

  
## Data Architecture

<img width="864" alt="image" src="https://github.com/shara170/de-zoomcamp-project-weather_data_analysis/assets/128853856/5eb14ee3-ce95-47ee-bc3e-01035d5799e3">


### Data Flow Overview

There are two types of pipelines in this project: ETL and ELT. The first set of ETL pipeline extracts the data from the data sources, performs some transformations and places the transformed data into a data lake(GCS bucket). 
Another set of the ELT pipeline extracts the data from the GCS bucket, loads it into a BigQuery table and then performs transformations on top of it.
Ultimately the data is visualized using Looker Studio


#### 1. Data Ingestion

Within this project, the orchestration tool at play is Mage. It systematically retrieves data in batches from an API endpoint and gathers static datasets from Kaggle. Following data manipulation, it diligently deposits the processed data into GCS buckets. Subsequently, the data is extracted and meticulously loaded into our designated data warehouse.

Within this project, there are a total of 6 pipelines in operation. Among them, 2 are dynamic, meaning they run periodically. The remaining 4 pipelines are tasked with fetching static data from Kaggle, transferring it into GCS, and then seamlessly integrating it into the data warehouse.

Pipeline description is as below:

Static pipelines: 
- **airline_to_gcs**:
  - Data is initially sourced from Kaggle, providing comprehensive details about airlines, including their codes and names. Subsequently, the data is uploaded to a GitHub repository, and a link is utilized to ingest the data into the pipeline for subsequent processing
    
  - In the subsequent step, basic transformations are applied to clean the dataset, including actions such as filling missing values and dropping unwanted entries
    
  - In the final stage, the processed data is encapsulated within a Parquet file to compress it effectively. Subsequently, this compressed data is exported to a GCS bucket for storage.
    
  - Since this is a one-time load, there are no triggers set for this pipeline. It needs to be manually executed once
 
- **airline_gcs_to_bigquery**:
  - In this pipeline, Parquet airline data is extracted from the bucket where it was deposited by the "airline_to_gcs" pipeline
    
  - No transformations are necessary as they were handled in airline_to_gcs pipeline
    
  - In the last step, the data is exported to the "airline_lookup" table within the "weather_data" dataset in BigQuery
    
  - Since this is a one-time load, no triggers are set for this pipeline. It will be automatically executed once the data consumption from the "airline_to_gcs" pipeline is finalized
 
- **routes_to_gcs**:
  - Data is initially sourced from Kaggle, providing comprehensive details about airline routes such as origin, destination, airline code, etc. Subsequently, the data is uploaded to a GitHub repository, and a link is utilized to ingest the data into the pipeline for subsequent processing
    
  - In the subsequent step, basic transformations are applied to clean the dataset, including actions such as filling missing values
    
  - In the final stage, the processed data is encapsulated within a Parquet file to compress it effectively. Subsequently, this compressed data is exported to a GCS bucket for storage
    
  - Since this is a one-time load, there are no triggers set for this pipeline. It will be automatically executed once "airline_gcs_to_bigquery" is completed

- **routes_gcs_to_bigquery**:
  - In this pipeline, Parquet airline route data is extracted from the bucket where it was deposited by the "routes_to_gcs" pipeline
    
  - No transformations are necessary as they were handled in routes_to_gcs pipeline
    
  - In the last step, the data is exported to the "routes_lookup" table within the "weather_data" dataset in BigQuery
    
  - Since this is a one-time load, no triggers are set for this pipeline. It will be automatically executedonce the data consumption from the "routes_to_gcs" pipeline is finalized.

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
    
  - The triggers are configured to activate once the "etl_web_to_gcs_weather" pipeline is completed

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


## Data set Description
Two types of dataset is used in this project: Weather forecast data and airline data

#### 1. Weather forecast data:
- The dataset is fetched through an API call from a website called tomorrow.io. To make the API calls later in the Mage pipeline, please create an account and save API key someplace safe
- This website provides free hourly forecasts for the next 120 hours. In this project, we are only using forecast data for the next 24 hour
- Few of the weather fields that are provided by this website are as below:
  - cloudbase: The lowest altitude of the visible portion of a cloud
  - cloudceiling: The highest altitude of the visible portion of a cloud
  - cloudcover: The fraction of the sky obscured by clouds when observed from a particular location
  - dewpoint: The temperature to which air must be cooled to become saturated with water vapor (at 2m)
  Other fields and their definition can be seen [here](https://docs.tomorrow.io/reference/data-layers-core)

#### 2. Airline data: 
There are three types of airline dataset used in this project which are taken from Kaggle (For the simplicity of this project, I am using static dataset)
Dataset in Kaggle can be found [here](https://www.kaggle.com/datasets/arbazmohammad/world-airports-and-airlines-datasets)

  - Airlines data: This dataset was present with the name "Final_airlines" in Kaggle and I placed this data in the "data" folder of my repo. This dataset contains the information about the airlines such as:
      - airline_name: Name of the airline such as United Airlines, 	Air Midwest, etc
      - iata_code: 2-letter airline code such as UA, ZV, etc
      - icao_code: 3-letter airline code such as LAB, AMW etc
      - country: Country or territory where airline is incorporated
      - active: "Y" if the airline is or has until recently been operational, "N" if it is defunct
  - Routes data: This dataset was present with the name "routes.dat" in Kaggle and is placed in the "data" folder of this repo. This dataset contains the information about the routes of the airlines such as:
      - iata_code: 2-letter code of the airline
      - airline_id: Airline Unique OpenFlights identifier for airline
      - source airport: 3-letter (IATA) or 4-letter (ICAO) code of the source airport
      - source airport ID - Unique OpenFlights identifier for source airport
      - destination airport - 3-letter (IATA) or 4-letter (ICAO) code of the destination airport
      - destination airport ID - Unique OpenFlights identifier for destination airport
      - codeshare - "Y" if this flight is a codeshare (that is, not operated by Airline, but another carrier), empty otherwise
  - Airport data: I was unable to source this dataset from Kaggle and have used multiple sources to combine this data. This dataset is present in the "data" folder of my repo with   
     name "airports_lookup.csv".
     I have used this dataset as the seed in the dbt cloud
     - iata_code: 3-letter code of the airport
     - airport: Name of the airport
     - city: City where the airport resides
     - state: State where the airport resides
     - country: Country where the airport resides
     - latitude: Latitude of the airport
     - longitude: Longitude of the airport
 

## Dashboard

[My Dashboard](https://lookerstudio.google.com/u/0/reporting/451a85de-f43c-434e-a6bb-7b21bcc46431/page/17UwD)

<img width="930" alt="image" src="https://github.com/shara170/de-zoomcamp-project-weather_data_analysis/assets/128853856/4be4961f-ffe1-4b77-b44b-519a51275a3e">



<img width="907" alt="image" src="https://github.com/shara170/de-zoomcamp-project-weather_data_analysis/assets/128853856/a126474f-ff2b-4dbe-aac5-a18c71b419a4">


