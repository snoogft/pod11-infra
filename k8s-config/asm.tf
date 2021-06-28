module "asm" {
  source                = "terraform-google-modules/kubernetes-engine/google//modules/asm"
  version               = "15.0.0"
  project_id            = var.project
  cluster_name          = data.google_container_cluster.my_cluster.name
  location              = data.google_container_cluster.my_cluster.location
  enable_cluster_labels = true
  cluster_endpoint      = data.google_container_cluster.my_cluster.endpoint
}

module "kubectl" {
  source                  = "terraform-google-modules/gcloud/google//modules/kubectl-wrapper"
  version                 = "3.0.0"
  project_id              = var.project
  cluster_name            = data.google_container_cluster.my_cluster.name
  cluster_location        = data.google_container_cluster.my_cluster.location
  kubectl_create_command  = "kubectl label namespace default istio.io/rev=asm-196-1 --overwrite"
  kubectl_destroy_command = "kubectl label namespaces default istio.io/rev-"
}