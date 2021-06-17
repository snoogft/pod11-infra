locals {
  env            = var.prefix
  subnet_01_name = "subnet-${local.env}-01"
  subnet_01_vpc_2_name = "subnet-${local.env}-01_vpc_2"
}

module "vpc_network" {
  source                      = "./modules/network"
  project_id                  = var.project
  env                         = local.env
  subnet_01_ip                = var.subnet_01_ip
  subnet_01_secondary_01_ip   = var.subnet_01_secondary_01_ip
  subnet_01_secondary_01_name = var.subnet_01_secondary_01_name
  subnet_01_region            = var.region
  subnet_01_services_name     = var.subnet_01_services_name
  subnet_01_name              = local.subnet_01_name
  subnet_01_services_ip       = var.subnet_01_services_ip
}

module "vpc_2_network" {
  source                      = "./modules/network"
  project_id                  = var.project
  env                         = local.env
  subnet_01_ip                = var.subnet_01_ip
  subnet_01_secondary_01_ip   = var.subnet_01_secondary_01_ip
  subnet_01_secondary_01_name = var.subnet_01_secondary_01_name
  subnet_01_region            = var.region
  subnet_01_services_name     = var.subnet_01_services_name
  subnet_01_name              = local.subnet_01_name
  subnet_01_services_ip       = var.subnet_01_services_ip
}

module "bastion_host" {
  source       = "./modules/bastion-host"
  members      = var.members
  project      = var.project
  region       = var.region
  zone         = var.zone
  network      = module.vpc_network.network_name
  subnetwork   = local.subnet_01_name
  depends_on   = [module.vpc_network, module.gke]
  instance     = "machine-${local.env}-bastion"
  vm_sa_email  = var.compute_engine_service_account
  machine_type = var.machine_type
  env          = local.env
  cluster_name = module.gke.cluster_name
}

module "bastion_host_2" {
  source       = "./modules/bastion-host"
  members      = var.members
  project      = var.project
  region       = var.region
  zone         = var.zone
  network      = module.vpc_network.network_2_name
  subnetwork   = local.subnet_01_name
  depends_on   = [module.vpc_network, module.gke_2]
  instance     = "machine-${local.env}-bastion_2"
  vm_sa_email  = var.compute_engine_service_account
  machine_type = var.machine_type
  env          = local.env
  cluster_name = module.gke_2.cluster_name
}

module "gke" {
  source                         = "./modules/cluster"
  project_id                     = var.project
  region                         = var.region
  zones                          = [var.zone]
  environment                    = local.env
  network                        = module.vpc_network.network_name
  subnetwork                     = local.subnet_01_name
  ip_cidr_range                  = var.subnet_01_ip
  ip_range_pods_name             = var.subnet_01_secondary_01_name
  ip_range_services_name         = var.subnet_01_services_name
  compute_engine_service_account = var.compute_engine_service_account
  depends_on                     = [module.vpc_network]
  autoscaling = false
  default_max_pods_per_node = var.default_max_pods_per_node
  machine_type_gke = var.machine_type_gke
  max_count = var.max_count
  min_count = var.min_count
  node_count = var.node_count
  node_pools_name = var.node_pools_name
}

module "gke_2" {
  source                         = "./modules/cluster"
  project_id                     = var.project
  region                         = var.region
  zones                          = [var.zone]
  environment                    = local.env
  network                        = module.vpc_network.network_2_name
  subnetwork                     = local.subnet_01_name
  ip_cidr_range                  = var.subnet_01_ip
  ip_range_pods_name             = var.subnet_01_secondary_01_name
  ip_range_services_name         = var.subnet_01_services_name
  compute_engine_service_account = var.compute_engine_service_account
  depends_on                     = [module.vpc_network]
  autoscaling = false
  default_max_pods_per_node = var.default_max_pods_per_node
  machine_type_gke = var.machine_type_gke
  max_count = var.max_count
  min_count = var.min_count
  node_count = var.node_count
  node_pools_name = var.node_pools_name
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

module "cloud_router_2" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "~> 1.0.0"

  name    = format("%s-router-2", local.env)
  project = var.project
  region  = var.region
  network = module.vpc_network.network_2_name

  nats = [{
    name = format("%s-nat", local.env)
  }]
}

module "cloud_sql" {
  source               = "./modules/database"
  project              = var.project
  region               = var.region
  db_name              = "${local.env}-db"
  private_network      = module.vpc_network.network_self_link
  private_network_name = module.vpc_network.network_name
  machine_type         = var.machine_type_db
  name_prefix          = "${local.env}-"
  master_user_password = var.root_db_password
  master_user_name     = "root"
  deletion_protection  = false
  name                 = "${local.env}-db"
}