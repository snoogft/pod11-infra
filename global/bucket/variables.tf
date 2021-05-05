variable "credentials" {
  description = "Path to a file containing credentials to GCP Service account with enough permissions to create GCS bucket"
  type        = string
}

variable "project_id" {
  description = "The ID of the project in which to provision resources"
  type        = string
}

variable "name" {
  description = "Name of the bucket for Terraform state"
  type        = string
  default     = "tfstate"
}

variable "location" {
  description = "Name of the bucket for Terraform state"
  type        = string
  default     = "europe-central2"
}

variable "iam_member" {
  description = "IAM member to grant permissions on the bucket"
  type        = string
}

variable "versioning" {
  description = "While set to true, versioning is fully enabled for this bucket"
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "When deleting a bucket, this boolean option will delete all contained objects. If false, Terraform will fail to delete buckets which contain objects"
  type        = bool
  default     = false
}