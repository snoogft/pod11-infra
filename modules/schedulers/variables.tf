variable "name" {
  description = "The name for google_cloud_scheduler_job"
  type = string
}

variable "description" {
  description = "The description for google_cloud_scheduler_job"
  type = string
}

variable "schedule" {
  description = "The schedule time value for google_cloud_scheduler_job"
  type = string
}

variable "time_zone" {
  description = "The time_zone for google_cloud_scheduler_job"
  type = string
}

variable "uri" {
  description = "The uri for http_target"
  type = string
}

variable "region" {
  description = "The region"
  type = string
}