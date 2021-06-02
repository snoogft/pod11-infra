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

resource "kubernetes_secret" "cloud_sql_admin" {
  metadata {
    name = "cloud-sql-admin"
  }

  data = {
    username = data.terraform_remote_state.dev.outputs.master_user_name
    password = data.terraform_remote_state.dev.outputs.master_user_password
    connectionName = data.terraform_remote_state.dev.outputs.master_proxy_connection
  }  

  type = "Opaque"
}