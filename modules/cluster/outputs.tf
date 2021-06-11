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

output "location" {
  description = "Cluster location (region if regional cluster, zone if zonal cluster)"
  value       = module.gke.location
}