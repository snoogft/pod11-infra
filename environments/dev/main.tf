locals {
  env            = "dev"
  subnet-01_name = "subnet-${local.env}-01"
}

module "vpc_network" {
  source                    = "../../modules/network"
  project_id                = var.project
  env                       = local.env
  subnet-01_ip              = var.subnet-01_ip
  subnet-01-secondary-01_ip = var.subnet-01-secondary-01_ip
  subnet-01_region          = var.region
  subnet-01_name            = local.subnet-01_name
  subnet-01-services-ip = var.subnet-01-services-ip
}

module "bastion_host" {
  source     = "../../modules/iap-tunneling"
  members    = var.members
  project    = var.project
  region     = var.region
  zone       = var.zone
  network    = module.vpc_network.network_name
  subnetwork = local.subnet-01_name
  depends_on = [module.vpc_network]
}