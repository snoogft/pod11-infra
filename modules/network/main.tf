locals {
  subnet_01 = var.subnet_01_name
  subnet_01_vpc_2 = "subnet-dev-01-vpc-2"
}

module "vpc" {
  source  = "terraform-google-modules/network/google//modules/vpc"
  version = "~> 3.2.2"

  project_id   = var.project_id
  network_name = "${var.env}-vpc-network"

  shared_vpc_host = false
}

module "vpc_2" {
  source  = "terraform-google-modules/network/google//modules/vpc"
  version = "~> 3.2.2"

  project_id   = var.project_id
  network_name = "${var.env}-vpc-network-2"

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
      subnet_ip             = var.subnet_01_ip
      subnet_region         = var.subnet_01_region
      subnet_private_access = "true"
      description           = "subnet-01 for ${var.env}-vpc-network"
    }
  ]

  secondary_ranges = {
    "${local.subnet_01}" = [
      {
        range_name    = var.subnet_01_secondary_01_name
        ip_cidr_range = var.subnet_01_secondary_01_ip
      },
      {
        range_name    = var.subnet_01_services_name
        ip_cidr_range = var.subnet_01_services_ip
      }
    ]
  }
}

module "subnets_vpc_2" {
  source  = "terraform-google-modules/network/google//modules/subnets"
  version = "~> 3.2.2"

  project_id   = var.project_id
  network_name = module.vpc_2.network_name

  subnets = [
    {
      subnet_name           = "${local.subnet_01_vpc_2}"
      subnet_ip             = var.subnet_01_ip
      subnet_region         = var.subnet_01_region
      subnet_private_access = "true"
      description           = "subnet-01 for ${var.env}-vpc-2-network"
    }
  ]

  secondary_ranges = {
    "${local.subnet_01_vpc_2}" = [
      {
        range_name    = var.subnet_01_secondary_01_name
        ip_cidr_range = var.subnet_01_secondary_01_ip
      },
      {
        range_name    = var.subnet_01_services_name
        ip_cidr_range = var.subnet_01_services_ip
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
      name                    = "allow-ssh-${var.env}"
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
      name                    = "allow-http-https-${var.env}"
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

module "firewall_rules_vpc_2" {
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  version      = "~> 3.2.2"
  project_id   = var.project_id
  network_name = module.vpc_2.network_name

  rules = [
    {
      name                    = "allow-ssh-${var.env}-vpc-2"
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
      name                    = "allow-http-https-${var.env}-vpc-2"
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