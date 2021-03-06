variable "members" {
  description = "List of members in the standard GCP form: user:{email}, serviceAccount:{email}, group:{email}"
  type        = list(string)
}

variable "project" {
  description = "Project ID where to set up the instance and IAP tunneling"
}

variable "region" {
  description = "Region to create the subnet and example VM."
}

variable "zone" {
  description = "Zone of the example VM instance to create and allow SSH from IAP."
}

variable "network" {
  type = string
}
variable "subnetwork" {
  type = string
}

variable "instance" {
  description = "Name of the example VM instance to create and allow SSH from IAP."
}

variable "vm_sa_email" {
  description = "Service account email for VM"
}

variable "vm_sa_id" {
  default = "Service account id for VM"
}

variable "machine_type" {
  default = "Type of machine"
}

variable "env" {
  description = "environment type dev/prod"
}

variable "cluster_name" {
  description = "GKE cluster name"
}

variable "cluster_number" {
  description = "GKE cluster number"
}

variable "fw_name_allow_ssh_from_iap" {
  description = "fw_name_allow_ssh_from_iap value"
}