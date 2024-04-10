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
  description = "My BigQuery dataset name"
  default     = "weather_data"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default     = "silicon-mile-412319-weather-in"

}

variable "gcs_bucket_name_city" {
  description = "My Storage Bucket Name"
  default     = "silicon-mile-412319-city-data"

}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"

}