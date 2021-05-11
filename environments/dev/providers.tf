provider "google" {
  project     = var.project
  credentials = file("./pol-pod11-dev-01-60f5d888e1c2.json")
  region      = var.region
  zone        = var.zone
}