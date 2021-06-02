variable "project" {
  description = "Id of the project"
}

variable "subnet_01_ip" {
  description = "Ip address for a subnet-01"
}

variable "subnet_01_secondary_01_ip" {
  description = "Ip address for a subnet-01 secondary range"
}

variable "subnet_01_secondary_01_name" {
  description = "Name for a subnet-01 secondary range"
}

variable "subnet_01_services_ip" {
  description = "Ip address for a subnet-01 services"
}

variable "subnet_01_services_name" {
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