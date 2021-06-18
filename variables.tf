variable "project" {
  description = "Id of the project"
}

variable "subnet_01_ip" {
  description = "Ip address for a subnet-01"
}

# variable "subnet_01_ip_vpc_2" {
#   description = "Ip address for a subnet-01 VPC_2"
# }

variable "subnet_01_secondary_01_ip" {
  description = "Ip address for a subnet-01 secondary range"
}

//variable "subnet_01_vpc_2_secondary_01_ip" {
//  description = "Ip address for a subnet-01 VPC_2 secondary range"
//}

variable "subnet_01_secondary_01_name" {
  description = "Name for a subnet-01 secondary range"
}

//variable "subnet_01_vpc_2_secondary_01_name" {
//  description = "Name for a subnet-01 VPC_2 secondary range"
//}

variable "subnet_01_services_ip" {
  description = "Ip address for a subnet-01 services"
}

//variable "subnet_01_vpc_2_services_ip" {
//  description = "Ip address for a subnet-01 VPC_2 services"
//}

variable "subnet_01_services_name" {
  description = "Name for subnet-01"
}

//variable "subnet_01_vpc_2_services_name" {
//  description = "Name for subnet-01 VPC_2"
//}

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

variable "prefix" {
  description = "This is the environment where your app is deployed."
}

variable "default_max_pods_per_node"{
  description = "Default maximum pods count per node for cluster"
  type = string
}

variable "node_pools_name" {
  description = "Name for node pools value"
  type = string
}

variable "autoscaling" {
  description = "Cluster autoscaling option"
  type = bool
}

variable "node_count" {
  description = "Node count for cluster"
  type = string
}

variable "min_count" {
  description = "Minimum node count for cluster"
  type = string
}

variable "max_count" {
  description = "Maximum node count for cluster"
  type = string
}

variable "machine_type_gke" {
  description = " Machine type for gke node"
}

variable "subnet_name" {
   description = "Name for subnet"
   type = string
}

variable "network_name" {
   description = "Name for network"
   type = string
}