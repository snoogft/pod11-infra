output "endpoint" {
  value       = module.gke.endpoint
  description = "GKE endpoint"
}

output "ca_certificate" {
  value       = module.gke.ca_certificate
  description = "CA certificate"
}