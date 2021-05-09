locals {
  env = "dev"
}

terraform {
  required_version = "~> 0.14.11"
}

provider "google" {
  project = var.project
}

module "vpc_network" {
  source                    = "../../modules/vpc"
  project_id                = var.project
  env                       = local.env
  subnet-01_ip              = var.subnet-01_ip
  subnet-01-secondary-01_ip = var.subnet-01-secondary-01_ip
  subnet-01_region          = var.subnet-01_region
}