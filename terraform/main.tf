terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.14.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials)
  project     = var.project
  region      = var.region
}


# Code to create GCS bucket which will hold the weather forecast data which will be pulled from an API call daily
resource "google_storage_bucket" "weather-bucket" {
  name          = var.gcs_bucket_name
  location      = var.location
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

# Code to create GCS bucket which will hold the parquet data files produced as an output of Mage pipelines
resource "google_storage_bucket" "data-bucket" {
  name          = var.gcs_bucket_data
  location      = var.location
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}


# Code to create BigQuery dataset
resource "google_bigquery_dataset" "weather_dataset" {
  dataset_id = var.bq_dataset_name
  location   = var.location
}
