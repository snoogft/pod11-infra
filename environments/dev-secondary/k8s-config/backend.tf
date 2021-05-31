terraform {
  backend "gcs" {
    bucket = "pol-pod11-dev-01-tfstate"
    prefix = "dev-secondary-k8s"
  }
}
