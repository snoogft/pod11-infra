module "vpc" {
  source  = "terraform-google-modules/network/google//modules/vpc"
  version = "~> 3.2.2"

  project_id   = var.project_id
  network_name = "${var.env}-vpc-network"

  shared_vpc_host = false
}

module "subnets" {
  source = "terraform-google-modules/network/google//modules/subnets"

  project_id   = var.project_id
  network_name = module.vpc.network_name

  subnets = [
    {
      subnet_name               = "subnet-01"
      subnet_ip                 = var.subnet-01_ip
      subnet_region             = var.subnet-01_region
      subnet_private_access     = "true"
      subnet_flow_logs          = "true"
      subnet_flow_logs_interval = "INTERVAL_10_MIN"
      subnet_flow_logs_sampling = 0.7
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
      description               = "subnet-01 for ${var.env}-vpc-network"
    }
  ]

  secondary_ranges = {
    subnet-01 = [
      {
        range_name    = "subnet-01-secondary-01"
        ip_cidr_range = var.subnet-01-secondary-01_ip
      },
    ]
  }
}

module "firewall_rules" {
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  project_id   = var.project_id
  network_name = module.vpc.network_name

  rules = [{
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

# resource "google_compute_network" "vpc_network" {
#   name = "${var.env}-vpc-network"
#   auto_create_subnetworks = false
# }

# resource "google_compute_subnetwork" "vpc_subnetwork-01" {
#   name          = "${var.env}-vpc-subnetwork-01"
#   ip_cidr_range = "10.${var.env == "dev" ? 10 : 20}.10.0/24"
#   region        = "us-central1"
#   network       = google_compute_network.vpc_network.id
#   secondary_ip_range {
#     range_name    = "${var.env}-secondary-range-subnetwork-01"
#     ip_cidr_range = "192.168.${var.env == "dev" ? 10 : 20}.0/24"
#  }
# }

# resource "google_compute_firewall" "firewall-rules" {
#   name = "${google_compute_network.vpc_network.name}-firewall"
#   network = "${google_compute_network.vpc_network.name}"

#   allow {
#     protocol = "icmp"
#   }

#   allow {
#     protocol = "tcp"
#     ports    = ["22", "80", "443", "8080", "1000-2000"]
#   }

#  target_tags = ["allow-http", "allow-https"]
#   priority    = 1000
#   source_tags = ["web"]
# }

