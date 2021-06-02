module "workload_identity" {
  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  project_id          = var.project
  name                = "iden-${var.cluster_name}"
  namespace           = "default"
  use_existing_k8s_sa = false
  roles = [
    "roles/cloudtrace.agent",
    "roles/monitoring.metricWriter",
    "roles/cloudsql.client",
  ]
}