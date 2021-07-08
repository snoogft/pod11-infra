variable "name" {
  description = "The name for google_cloudbuild_trigger"
  type = string
}

variable "description" {
  description = "The description for google_cloudbuild_trigger"
  type = string
}

variable "disabled" {
  description = "The value allow to turn on and off option"
  type = string
}

variable "filename" {
  description = "Path to cloudbuild yaml file"
  type = string
}

variable "branch" {
  description = "The name for branch_name"
  type = string
}

