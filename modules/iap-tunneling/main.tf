module "iap_bastion" {
  source       = "terraform-google-modules/bastion-host/google"
  version      = "3.2.0"
  project      = var.project
  zone         = var.zone
  network      = var.network
  subnet       = var.subnetwork
  members      = var.members
  machine_type = "f1-micro"
}
