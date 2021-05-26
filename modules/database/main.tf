# ------------------------------------------------------------------------------
# LAUNCH A POSTGRES CLOUD SQL PRIVATE IP INSTANCE
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# CONFIGURE OUR GCP CONNECTION
# ------------------------------------------------------------------------------

provider "google-beta" {
  project = var.project
  region  = var.region
}

terraform {

  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 3.57.0"
    }
  }
}

# ------------------------------------------------------------------------------
# CREATE A RANDOM SUFFIX AND PREPARE RESOURCE NAMES
# ------------------------------------------------------------------------------

//resource "random_id" "name" {
//  byte_length = 2
//}

locals {
  postgress_name=var.private_network_name
}
//
//# ------------------------------------------------------------------------------
//# CREATE COMPUTE NETWORKS
//# ------------------------------------------------------------------------------
//
//# Simple network, auto-creates subnetworks
//resource "google_compute_network" "private_network" {
//  provider = google-beta
//  name     = local.private_network_name
//}
//
# Reserve global internal address range for the peering
resource "google_compute_global_address" "private_ip_address" {
  provider      = google-beta
  name          = local.postgress_name
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.private_network
}
//
//# Establish VPC network peering connection using the reserved address range
resource "google_service_networking_connection" "private_vpc_connection" {
  provider                = google-beta
  network                 = var.private_network
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

# ------------------------------------------------------------------------------
# CREATE DATABASE INSTANCE WITH PRIVATE IP
# ------------------------------------------------------------------------------

module "postgresql-db"{
  source = "github.com/gruntwork-io/terraform-google-sql.git//modules/cloud-sql?ref=v0.5.0"
  project = var.project
  region  = var.region
  db_name = var.db_name
  name    = var.db_name

  engine       = var.postgres_version
  machine_type = var.machine_type

  master_user_password = var.master_user_password

  master_user_name = var.master_user_name
  master_user_host = "%"

  # Pass the private network link to the module
  private_network = var.private_network

  # Wait for the vpc connection to complete
  dependencies = [google_service_networking_connection.private_vpc_connection.network]

  custom_labels = {
    test-id = "postgres-private-ip-example"
  }
}

resource "database_config_map" "plsql" {
  metadata {
    name = "config"
  }

  data = {
    api_host             = "myhost:443"
    db_host              = "dbhost:5432"
    "my_config_file.yml" = "${file("${path.module}/my_config_file.yml")}"
  }

  binary_data = {
    "my_payload.bin" = "${filebase64("${path.module}/my_payload.bin")}"
  }
}

