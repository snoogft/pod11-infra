# GKE

This module will create Google Kubernetes Engine (GKE) cluster and configuration with Node Pools, Network Policy, etc.

## Usage
```hcl
module "gke" {
  source                  = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id              = var.project_id
  name                    = "${var.environment}-cluster"
  regional                = false
  region                  = var.region
  zones                   = var.zones
  network                 = var.network
  subnetwork              = var.subnetwork
  ip_range_pods           = var.ip_range_pods_name
  ip_range_services       = var.ip_range_services_name
  create_service_account  = false
  service_account         = var.compute_engine_service_account
  enable_private_endpoint = true
  enable_private_nodes    = true
  master_ipv4_cidr_block  = "172.16.0.0/28"

  master_authorized_networks = [
    {
      cidr_block   = var.ip_cidr_range
      display_name = "VPC"
    }
  ]
}
```

## Inputs
| Name | Description | Type |
|------|-------------|:------:|
| project\_id | 	The project ID to host the cluster in (required) | `string` |
| name | 	The name of the cluster (required) | `string` |
| pregional | 	Whether is a regional cluster (zonal cluster if set false. WARNING: changing this after cluster creation is destructive!) | `bool` |
| region | 	The region to host the cluster in (optional if zonal cluster / required if regional) | `string` |
| zones | 	The zones to host the cluster in (optional if regional cluster / required if zonal) | `list(string)` |
| network | 	The VPC network to host the cluster in (required) | `string` |
| subnetwork | 	The subnetwork to host the cluster in (required) | `string` |
| ip\_range\_pods | 	The name of the secondary subnet ip range to use for pods | `string` |
| ip\_range\_services | 	The name of the secondary subnet range to use for services | `string` |
| create\_service\_account | 	Defines if service account specified to run nodes should be created | `bool` |
| service\_account | 	The service account to run nodes as if not overridden in node_pools. The create_service_account variable default value (true) will cause a cluster-specific service account to be created. | `string` |
| enable\_private\_endpoint | 	Tve value indicates that the cluster is managed using the private IP address of the control plane API endpoint | `bool` |
| enable\_privat\_nodes | 	The value indicates that the cluster's nodes do not have external IP addresses | `bool` |
| master_ipv4_cidr_block | 	The value specifies an internal IP address range for the control plane (optional for Autopilot). This setting is permanent for this cluster | `string` |
| master\_authorized\_networks | 	List of master authorized networks. If none are provided, disallow external access (except the cluster node IPs, which GKE automatically whitelists). | `list(object({ cidr_block = string, display_name = string }))` |

## Outputs
No outputs

## Requirements

Compute Engine API - compute.googleapis.com
Kubernetes Engine API - container.googleapis.com

### Installed Software
- [Terraform](https://www.terraform.io/downloads.html) ~> 0.14.11

Source: https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine
