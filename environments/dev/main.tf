locals {
  env            = "dev"
  subnet-01_name = "subnet-${local.env}-01"
}

module "vpc_network" {
  source                      = "../../modules/network"
  project_id                  = var.project
  env                         = local.env
  subnet-01_ip                = var.subnet-01_ip
  subnet-01-secondary-01_ip   = var.subnet-01-secondary-01_ip
  subnet-01-secondary-01_name = var.subnet-01-secondary-01_name
  subnet-01_region            = var.region
  subnet-01-services-name     = var.subnet-01-services-name
  subnet-01_name              = local.subnet-01_name
  subnet-01-services-ip       = var.subnet-01-services-ip
}

module "bastion_host" {
  source       = "../../modules/bastion-host"
  members      = var.members
  project      = var.project
  region       = var.region
  zone         = var.zone
  network      = module.vpc_network.network_name
  subnetwork   = local.subnet-01_name
  depends_on   = [module.vpc_network]
  instance     = "machine-${local.env}-bastion"
  vm_sa_email  = var.compute_engine_service_account
  machine_type = var.machine_type
  env          = local.env
}

module "gke" {
  source                         = "../../modules/cluster"
  project_id                     = var.project
  region                         = var.region
  zones                          = [var.zone]
  environment                    = local.env
  network                        = module.vpc_network.network_name
  subnetwork                     = local.subnet-01_name
  ip_cidr_range                  = var.subnet-01_ip
  ip_range_pods_name             = var.subnet-01-secondary-01_name
  ip_range_services_name         = var.subnet-01-services-name
  compute_engine_service_account = var.compute_engine_service_account
  depends_on                     = [module.vpc_network]
}

module "cloud_router" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "~> 1.0.0"

  name    = format("%s-router", local.env)
  project = var.project
  region  = var.region
  network = module.vpc_network.network_name

  nats = [{
    name = format("%s-nat", local.env)
  }]
}

module "database"{
  source = "../../modules/database"
  project_id              = var.project
  region                  = var.region
  zone                    = var.zone
  pg_ha_name              =var.pg_ha_name
  pg_ha_external_ip_range = var.pg_ha_external_ip_range
  env                     = local.env
}