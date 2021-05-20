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