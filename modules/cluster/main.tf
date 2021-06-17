module "gke" {
  source                        = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                    = var.project_id
  name                          = "${var.environment}-cluster"
  regional                      = false
  region                        = var.region
  zones                         = var.zones
  network                       = var.network
  subnetwork                    = var.subnetwork
  ip_range_pods                 = var.ip_range_pods_name
  ip_range_services             = var.ip_range_services_name
  create_service_account        = false
  service_account               = var.compute_engine_service_account
  enable_private_endpoint       = true
  enable_private_nodes          = true
  default_max_pods_per_node     = var.default_max_pods_per_node
  master_ipv4_cidr_block        = "172.16.0.0/28"
  deploy_using_private_endpoint = true

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
      node_count  = 4
      min_count   = 4
      max_count   = 6
      machine_type = "e2-standard-4"
    }
  ]
}

module "gke_2" {
  source                        = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                    = var.project_id
  name                          = "${var.environment}-cluster-2"
  regional                      = false
  region                        = var.region
  zones                         = var.zones
  network                       = var.network
  subnetwork                    = var.subnetwork
  ip_range_pods                 = var.ip_range_pods_name
  ip_range_services             = var.ip_range_services_name
  create_service_account        = false
  service_account               = var.compute_engine_service_account
  enable_private_endpoint       = true
  enable_private_nodes          = true
  default_max_pods_per_node     = var.default_max_pods_per_node
  master_ipv4_cidr_block        = "172.16.0.128/28"
  deploy_using_private_endpoint = true

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
      node_count  = 4
      min_count   = 4
      max_count   = 6
      machine_type = "e2-standard-4"

    }
  ]
}