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

variable "branch_name" {
  description = "The name for branch_name"
  type = string
}

variable "repo_name" {
  description = "The name for repo_name"
  type = string
}

variable "filename" {
  description = "Path to cloudbuild yaml file"
  type = string
}