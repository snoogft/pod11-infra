provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

data "google_client_config" "default" {

}

data "terraform_remote_state" "workspaces" {
  backend = "gcs"

  config = {
    bucket = "pol-pod11-dev-01-tfstate"
    prefix = "workspaces"
    workspace = var.workspace_env
  }
}

data "google_container_cluster" "my_cluster" {
  name     = var.cluster_name
  location = var.zone
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}