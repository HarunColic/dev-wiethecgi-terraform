variable "project_id" {
    description = "Project ID"
    type = string
}

variable "region" {
    description = "GCP Region"
    type = string
    default = "europe-west3" 
}

variable "zone" {
  description = "time-zone"
  type = string
  default = "europe-west3-b"
}

variable "tf_service_account" {
  description = "Service account"
  type = string
}