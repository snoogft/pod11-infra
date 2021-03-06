variable "project_id" {
  description = "The project ID to host the cluster in"
}

variable "region" {
  description = "The region to host the cluster in"
}

variable "zones" {
  type        = list(string)
  description = "The zone to host the cluster in (required if is a zonal cluster)"
}

variable "network" {
  description = "The VPC network to host the cluster in"
}

variable "subnetwork" {
  description = "The subnetwork to host the cluster in"
}

variable "ip_cidr_range" {
  description = "Authorized network CIDR block"
  type        = string
}

variable "ip_range_pods_name" {
  description = "The secondary ip range to use for pods"
}

variable "ip_range_services_name" {
  description = "The secondary ip range to use for services"
}

variable "compute_engine_service_account" {
  description = "Service account to associate to the nodes in the cluster"
}

variable "environment" {
  description = "GKE cluster environment"
  type        = string
}

variable "default_max_pods_per_node" {
  description = "Default maximum pods count per node for cluster"
  type        = string
}

variable "autoscaling" {
  description = "Cluster autoscaling option"
  type        = bool
}

variable "node_count" {
  description = "Node count for cluster"
  type        = string
}

variable "min_count" {
  description = "Minimum node count for cluster"
  type        = string
}

variable "max_count" {
  description = "Maximum node count for cluster"
  type        = string
}

variable "machine_type_gke" {
  description = " Machine type for gke node"
}

variable "cluster_number" {
  description = "Number of the cluster"
  type        = string
}

variable "master_ipv4_cidr_block" {
  description = "master_ipv4_cidr_block address"
  type        = string
}
