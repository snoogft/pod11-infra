variable "members" {
  description = "List of members in the standard GCP form: user:{email}, serviceAccount:{email}, group:{email}"
  type        = list(string)
}

variable "project" {
  description = "Project ID where to set up the instance and IAP tunneling"
}

variable "instance" {
  description = "Name of the example VM instance to create and allow SSH from IAP."
}

variable "region" {
  description = "Region to create the subnet and example VM."
  default     = "us-west1"
}

variable "zone" {
  description = "Zone of the example VM instance to create and allow SSH from IAP."
  default     = "us-west1-a"
}

variable "machine_type" {
  description = "Machine type for "
  default     = "n1-standard-1"
}