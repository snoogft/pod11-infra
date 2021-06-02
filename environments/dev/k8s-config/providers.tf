provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

data "google_client_config" "default" {

}

data "terraform_remote_state" "dev" {
  backend = "gcs"

  config = {
    bucket = "pol-pod11-dev-01-tfstate"
    prefix = "dev"
  }
}

data "google_container_cluster" "my_cluster" {
  name     = var.cluster_name
  location = var.zone
}

provider "kubernetes" {
  host  = "https://${data.google_container_cluster.my_cluster.endpoint}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(
    data.google_container_cluster.my_cluster.master_auth[0].cluster_ca_certificate,
  )
}