variable "project" {
  description = "Id of the project"
}

variable "zone" {
  description = "Zone for a k8s cluster"
}

variable "cluster_name" {
  description = "GKE cluster name"
}

variable "workspace_env" {
  description = "Used workspace env"
}

variable "namespace" {
  description = "GKE namespace used by workload identity"
  default     = "default"
}

variable "k8s_sa_name" {
  description = "GKE service account name"
  default     = "boa-ksa"
}