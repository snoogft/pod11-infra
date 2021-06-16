output "endpoint" {
  value       = module.gke.endpoint
  description = "GKE endpoint"
  sensitive   = true
}

output "ca_certificate" {
  value       = module.gke.ca_certificate
  description = "CA certificate"
  sensitive   = true
}

output "cluster_name" {
  value       = module.gke.name
  description = "Cluster name"
}

output "cluster_2_name" {
  value       = module.gke_2.name
  description = "Cluster_2 name"
}
