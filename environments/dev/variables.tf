variable "project" {
  description = "Id of the project"
}

variable "subnet-01_ip" {
  description = "Ip address for a subnet-01"
}

variable "subnet-01-secondary-01_ip" {
  description = "Ip address for a subnet-01 secondary range"
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