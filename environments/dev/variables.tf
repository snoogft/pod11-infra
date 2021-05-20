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


variable "pg_ha_external_ip_range" {

}

variable "pg_ha_name" {

}
variable "db_user" {
  description = "name of db user"
  type        = string
}