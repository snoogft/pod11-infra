terraform {
  backend "gcs" {
    bucket      = "pol-pod11-dev-01-tfstate"
    prefix      = "dev"
    credentials = "./pol-pod11-dev-01-60f5d888e1c2.json"
  }
}
