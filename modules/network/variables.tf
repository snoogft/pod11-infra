variable "project_id" {
  description = "Id of the project"
}

variable "env" {
  description = "environment type dev/prod"
}

# variable "subnet_01_name" {
#   description = "Name for a subnet-01"
# }

//variable "subnet_01_vpc_2_name" {
//  description = "Name for a subnet-01 VPC_2"
//}

variable "subnet_01_ip" {
  description = "Ip address for a subnet-01"
}

variable "subnet_01_ip_vpc_2" {
  description = "Ip address for a subnet-01 VPC_2 "
}

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

variable "subnet_01_region" {
  description = "Region for a subnet-01"
}

//variable "subnet_01_vpc_2_region" {
//  description = "Region for a subnet-01 VPC_2"
//}

variable "subnet_01_services_ip" {
  description = "IP for subnet-01"
}

//variable "subnet_01_vpc_2_services_ip" {
//  description = "IP for subnet-01 VPC_2"
//}

variable "subnet_01_services_name" {
  description = "Name for subnet-01"
}

//variable "subnet_01_vpc_2_services_name" {
//  description = "Name for subnet-01 VPC_2"
//}


variable "subnet_name" {
   description = "Name for subnet"
   type = string
}

variable "network_name" {
   description = "Name for network"
   type = string
}