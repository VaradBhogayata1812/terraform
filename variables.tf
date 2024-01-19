variable "gcp_credentials_file" {
  description = "The GCP credentials file"
  type        = string
}

variable "project" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The region for GCP resources"
  type        = string
}

variable "zone" {
  description = "The zone for GCP resources"
  type        = string
}
