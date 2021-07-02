resource "google_cloudbuild_trigger" "build-trigger" {
  name        = var.name
  description = var.description
  disabled    = var.disabled
  filename    = var.filename

  trigger_template {
    branch_name = var.branch_name
    repo_name   = var.repo_name
  }

  github {
    name = var.name
    push {
      branch = var.branch_name
    }
  }

  build {
    step {
      name    = "gcr.io/cloud-builders/gsutil"
      timeout = "120s"
    }
    source {
      storage_source {
        bucket = "pol-pod11-dev-01-tfstate"
        object = "source_code.tar.gz"
      }
    }
    tags      = ["build"]
    queue_ttl = "20s"
  }
}
