variable "project_name" {
  type        = string
  description = "the domain to use, for example 'example.com'"
}

variable "region" {
  type        = string
  description = "the GCP region to deploy within"
  default     = "europe-west4"
}

variable "project_id" {
  type        = string
  description = "GCP project ID to deploy to"
}

variable "num_instances" {
  type        = number
  description = "The number of compute instances to create"
  default     = 1
}