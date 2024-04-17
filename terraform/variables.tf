variable "credentials" {
  description = "My credentials"
  default     = "./keys/my-cred.json"

}

variable "project" {
  description = "Project"
  default     = "silicon-mile-412319"
}

variable "region" {
  description = "Region"
  default     = "us-central1"
}

variable "location" {
  description = "Project Location"
  default     = "US"
}

variable "bq_dataset_name" {
  description = "BigQuery dataset name"
  default     = "weather_data"
}

variable "gcs_bucket_name" {
  description = "Storage Bucket Name for storing API data"
  default     = "silicon-mile-412319-weather"

}

variable "gcs_bucket_data" {
  description = "Storage Bucket Name for storing parquet data files"
  default     = "silicon-mile-412319-data"

}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"

}
