terraform {
  backend "gcs" {
    bucket  = "pol-pod11-dev-01-tfstate"
    prefix  = "global"
    credentials = "pol-pod11-dev-01-a823c7467c9b.json"
  }
}
