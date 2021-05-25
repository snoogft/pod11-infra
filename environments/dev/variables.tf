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

variable "machine_type_db" {
  description = "Type of machine for database"
}
variable "account_db_password" {
  description = "User password for account_db"
}

variable "ledger_db_password" {
  description = "User password for ledger_db"
}
variable "root_db_password" {
  default = "User root password"
}