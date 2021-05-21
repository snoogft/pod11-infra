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
output "gcp_service_account_email" {
  description = "Email address of GCP service account."
  value       = module.workload_identity.gcp_sa_email
}