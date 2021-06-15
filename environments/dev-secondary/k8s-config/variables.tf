variable "project" {
  description = "Id of the project"
}

variable "region" {
  description = "Region for a subnet-01"
}

variable "zone" {
  description = "Zone for a subnet-01"
}

variable "cluster_name" {
  description = "GKE cluster name"
}

variable "namespace" {
  description = "GKE namespace used by workload identity"
}

variable "k8s_sa_name" {
  description = "GKE service account name"
}