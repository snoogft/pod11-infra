provider "google" {
  project = var.project
  credentials = file("./pol-pod11-dev-01-a823c7467c9b.json")
  region = var.region
  zone = var.zone
}