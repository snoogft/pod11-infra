module "asm-primary" {
  source                = "terraform-google-modules/kubernetes-engine/google//modules/asm"
  version               = "15.0.0"
  project_id            = var.project
  cluster_name          = data.terraform_remote_state.workspaces.outputs.gke_cluster_name
  location              = data.terraform_remote_state.workspaces.outputs.gke_location
  enable_cluster_labels = true
  cluster_endpoint      = data.terraform_remote_state.workspaces.outputs.gke_cluster_endpoint
}

module "kubectl" {
  source = "terraform-google-modules/gcloud/google//modules/kubectl-wrapper"

  project_id              = var.project
  cluster_name            = data.terraform_remote_state.workspaces.outputs.gke_cluster_name
  cluster_location        = data.terraform_remote_state.workspaces.outputs.gke_location
  kubectl_create_command  = "kubectl label namespace default istio.io/rev=asm-195-2 --overwrite"
  kubectl_destroy_command = "kubectl label namespaces default istio.io/rev-"
}