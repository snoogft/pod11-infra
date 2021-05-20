module "gke" {
  source                    = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                = var.project_id
  name                      = "${var.environment}-cluster"
  regional                  = false
  region                    = var.region
  zones                     = var.zones
  network                   = var.network
  subnetwork                = var.subnetwork
  ip_range_pods             = var.ip_range_pods_name
  ip_range_services         = var.ip_range_services_name
  create_service_account    = false
  service_account           = var.compute_engine_service_account
  enable_private_endpoint   = true
  enable_private_nodes      = true
  default_max_pods_per_node = 55
  master_ipv4_cidr_block    = "172.16.0.0/28"

  master_authorized_networks = [
    {
      cidr_block   = var.ip_cidr_range
      display_name = "VPC"
    }
  ]
  node_pools = [
    {
      name        = "default-node-pool"
      autoscaling = true
      node_count  = 3
      min_count   = 3
      max_count   = 10
    }
  ]
}
module "gcloud" {
  source  = "terraform-google-modules/gcloud/google"
  version = "~> 0.5"

  platform = "linux"

  create_cmd_entrypoint = "gcloud"
  create_cmd_body       = "container clusters get-credentials ${module.gke.name} --region=${var.zones[0]}"
  module_depends_on     = module.gke
}

provider "kubernetes" {
  # the authorization is handled by running gcloud clusters get-credentials using the gcloud terraform module
}

module "workload_identity" {
  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  project_id          = var.project_id
  name                = "identity-${module.gke.name}"
  namespace           = "default"
  use_existing_k8s_sa = false
}
