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

module "cloud_sql" {
  source                   = "../../modules/database"
  project                  = var.project
  region                   = var.region
  db_name                  = "${local.env}_db"
  private_network          = module.vpc_network.network_self_link
  private_network_name     = module.vpc_network.network_name
  machine_type             = var.machine_type_db
  name_prefix              = "${local.env}-"
  master_user_password     =var.root_db_password
  master_user_name         ="root"
}

