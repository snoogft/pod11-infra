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

variable "subnet_02_ip" {
  description = "Ip address for a subnet-01"
}

variable "subnet_02_secondary_01_ip" {
  description = "Ip address for a subnet-01 secondary range"
}

variable "subnet_02_secondary_01_name" {
  description = "Name for a subnet-01 secondary range"
}

variable "subnet_02_services_ip" {
  description = "Ip address for a subnet-01 services"
}

variable "subnet_02_services_name" {
  description = "Name for subnet-01"
}

variable "region" {
  description = "Region for a subnet-01"
}

variable "zone" {
  description = "Zone for a subnet-01"
}

variable "secondary_region" {
  description = "The secondary region to be used"
}

variable "secondary_zones" {
  description = "The secondary zones to be used"
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

variable "root_db_password" {
  description = "User root password"
}

variable "accounts_db_name" {
  description = "Accounts database name"
  default     = "accountsdb"
}

variable "ledger_db_name" {
  description = "Ledger database name"
  default     = "ledgerdb"
}

variable "jwt_secret" {
  description = "JWT secret for k8s"
}

variable "jwt_pub" {
  description = "JWT pub"
}