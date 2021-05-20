provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}
module "gcloud" {
  source  = "terraform-google-modules/gcloud/google"
  version = "~> 0.5"

  platform = "linux"

  create_cmd_entrypoint = "gcloud"
  create_cmd_body       = "container clusters get-credentials ${module.gke.name} --region=${var.zone}"
  module_depends_on     = module.gke
}

provider "kubernetes" {
  # the authorization is handled by running gcloud clusters get-credentials using the gcloud terraform module
}