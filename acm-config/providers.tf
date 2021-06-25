provider "google" {
  project = var.project
  zone    = var.zone
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}