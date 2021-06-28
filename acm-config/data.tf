data "google_client_config" "default" {
}

data "google_container_cluster" "my_cluster" {
  name     = var.cluster_name
  location = var.zone
}