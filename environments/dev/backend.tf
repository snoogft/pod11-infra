terraform {
  backend "gcs" {
    bucket      = "pol-pod11-dev-01-tfstate"
    prefix      = "dev"
    credentials = "pol-pod11-dev-01.json"
  }
}
