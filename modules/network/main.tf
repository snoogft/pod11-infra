locals {
  subnet_01 = var.subnet-01_name
}

module "vpc" {
  source  = "terraform-google-modules/network/google//modules/vpc"
  version = "~> 3.2.2"

  project_id   = var.project_id
  network_name = "${var.env}-vpc-network"

  shared_vpc_host = false
}

module "subnets" {
  source  = "terraform-google-modules/network/google//modules/subnets"
  version = "~> 3.2.2"

  project_id   = var.project_id
  network_name = module.vpc.network_name

  subnets = [
    {
      subnet_name           = "${local.subnet_01}"
      subnet_ip             = var.subnet-01_ip
      subnet_region         = var.subnet-01_region
      subnet_private_access = "true"
      description           = "subnet-01 for ${var.env}-vpc-network"
    }
  ]

  secondary_ranges = {
    "${local.subnet_01}" = [
      {
        range_name    = var.subnet-01-secondary-01_name
        ip_cidr_range = var.subnet-01-secondary-01_ip
      },
      {
        range_name    = var.subnet-01-services-name
        ip_cidr_range = var.subnet-01-services-ip
      }
    ]
  }
}

module "firewall_rules" {
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  version      = "~> 3.2.2"
  project_id   = var.project_id
  network_name = module.vpc.network_name

  rules = [
    {
      name                    = "allow-ssh"
      description             = null
      direction               = "INGRESS"
      priority                = null
      ranges                  = ["0.0.0.0/0"]
      source_tags             = null
      source_service_accounts = null
      target_tags             = null
      target_service_accounts = null
      allow = [{
        protocol = "tcp"
        ports    = ["22"]
      }]
      deny = []
      log_config = {
        metadata = "INCLUDE_ALL_METADATA"
      }
    },
    {
      name                    = "allow-http-https"
      description             = null
      direction               = "INGRESS"
      priority                = null
      ranges                  = ["0.0.0.0/0"]
      source_tags             = null
      source_service_accounts = null
      target_tags             = null
      target_service_accounts = null
      allow = [{
        protocol = "tcp"
        ports    = ["80", "443"]
      }]
      deny = []
      log_config = {
        metadata = "INCLUDE_ALL_METADATA"
      }
    }
  ]
}
