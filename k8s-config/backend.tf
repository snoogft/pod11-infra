terraform {
  backend "gcs" {
    bucket = "pol-pod11-dev-01-tfstate"
    prefix = "workspaces-k8s"
  }
}
