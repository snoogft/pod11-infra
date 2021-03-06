locals {
  subnet_01 = var.subnet_name
}

module "vpc" {
  source  = "terraform-google-modules/network/google//modules/vpc"
  version = "~> 3.2.2"

  project_id   = var.project_id
  network_name = var.network_name

  shared_vpc_host = false
}

module "subnets" {
  source  = "terraform-google-modules/network/google//modules/subnets"
  version = "~> 3.2.2"

  project_id   = var.project_id
  network_name = var.network_name
  depends_on   = [module.vpc]

  subnets = [
    {
      subnet_name           = local.subnet_01
      subnet_ip             = var.subnet_01_ip
      subnet_region         = var.subnet_01_region
      subnet_private_access = "true"
      description           = "subnet-01 for ${var.env}-vpc-network for subnet name ${var.subnet_name}"
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

module "firewall_rules" {
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  version      = "~> 3.2.2"
  project_id   = var.project_id
  network_name = var.network_name
  depends_on   = [module.subnets, module.vpc]

  rules = [
    {
      name                    = "allow-ssh-${var.env}-${var.cluster_number}"
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
      name                    = "allow-http-https-${var.env}-${var.cluster_number}"
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
    },
    {
      name                    = "allow-istio-sidecar-injection-${var.env}-${var.cluster_number}"
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
        ports    = ["10250", "15017"]
      }]
      deny = []
      log_config = {
        metadata = "INCLUDE_ALL_METADATA"
      }
    },
    {
      name                    = "allow-gatekeeper-${var.env}-${var.cluster_number}"
      description             = "https://open-policy-agent.github.io/gatekeeper/website/docs/vendor-specific/#running-on-private-gke-cluster-nodes"
      direction               = "INGRESS"
      priority                = null
      ranges                  = ["0.0.0.0/0"]
      source_tags             = null
      source_service_accounts = null
      target_tags             = null
      target_service_accounts = null
      allow = [{
        protocol = "tcp"
        ports    = ["8443"]
      }]
      deny = []
      log_config = {
        metadata = "INCLUDE_ALL_METADATA"
      }
    }
  ]
}