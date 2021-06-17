module "asm-primary" {
  source           = "terraform-google-modules/kubernetes-engine/google//modules/asm"
  version          = "15.0.0"
  project_id       = var.project
  cluster_name     = data.terraform_remote_state.workspaces.outputs.gke_cluster_name
  location         = data.terraform_remote_state.workspaces.outputs.gke_location
  cluster_endpoint = data.terraform_remote_state.workspaces.outputs.gke_cluster_endpoint
}
