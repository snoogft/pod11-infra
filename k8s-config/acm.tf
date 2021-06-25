resource "null_resource" "previous" {}

resource "time_sleep" "wait_120_seconds" {
  depends_on = [null_resource.previous]

  create_duration = "120s"
}

module "acm" {
  source           = "terraform-google-modules/kubernetes-engine/google//modules/acm"
  version          = "15.0.0"
  project_id       = var.project
  cluster_name     = data.google_container_cluster.my_cluster.name
  location         = data.google_container_cluster.my_cluster.location
  cluster_endpoint = data.google_container_cluster.my_cluster.endpoint
  operator_path    = "config-management-operator/config-management-operator.yaml"
  sync_repo        = "https://github.com/Katmar-creator/boa-management-config"
  sync_branch      = "main"
  depends_on       = [time_sleep.wait_120_seconds]
}