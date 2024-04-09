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

# Code to create bucket - START
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

resource "google_storage_bucket" "city-bucket" {
  name          = var.gcs_bucket_name_city
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

# Code to create bucket - END

# Code to create a BigQuery dataset - START

resource "google_bigquery_dataset" "weather_dataset" {
  dataset_id = var.bq_dataset_name
  location   = var.location
}
