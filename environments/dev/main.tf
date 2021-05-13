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
  source     = "../../modules/bastion-host"
  members    = var.members
  project    = var.project
  region     = var.region
  zone       = var.zone
  network    = module.vpc_network.network_name
  subnetwork = local.subnet-01_name
  depends_on = [module.vpc_network]
  instance   = "machine-${local.env}-bastion"
  vm-sa-email= "terraform-service-account@pol-pod11-dev-01.iam.gserviceaccount.com"
//  vm_sa_id   = "terraformserviceaccount"
}

# module "gke" {
#   source                         = "../../modules/cluster"
#   project_id                     = var.project
#   region                         = var.region
#   zones                          = [var.zone]
#   environment                    = local.env
#   network                        = module.vpc_network.network_name
#   subnetwork                     = local.subnet-01_name
#   ip_cidr_range                  = var.subnet-01_ip
#   ip_range_pods_name             = var.subnet-01-secondary-01_name
#   ip_range_services_name         = var.subnet-01-services-name
#   compute_engine_service_account = var.compute_engine_service_account
#   depends_on                     = [module.vpc_network]
# }