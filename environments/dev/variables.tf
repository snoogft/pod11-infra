variable "project" {
  description = "Id of the project"
}

variable "subnet-01_ip" {
  description = "Ip address for a subnet-01"
}

variable "subnet-01-secondary-01_ip" {
  description = "Ip address for a subnet-01 secondary range"
}

variable "subnet-01-secondary-01_name" {
  description = "Name for a subnet-01 secondary range"
}

variable "subnet-01-services-ip" {
  description = "Ip address for a subnet-01 services"
}

variable "subnet-01-services-name" {
  description = "Name for subnet-01"
}

variable "region" {
  description = "Region for a subnet-01"
}

variable "zone" {
  description = "Zone for a subnet-01"
}

variable "members" {
  description = "Project members"
  type        = list(string)
}

variable "compute_engine_service_account" {
  description = "SA for CKE storage nodes"
  type        = string
}

variable "machine_type" {
  description = "Type of machine"
}

variable "authorized_networks" {
  //  default = [{
  //    name  = "sample-gcp-health-checkers-range"
  //    value = "130.211.0.0/28"
  //  }]
  type        = list(map(string))
  description = "List of mapped public networks authorized to access to the instances. Default - short range of GCP health-checkers IPs"
}