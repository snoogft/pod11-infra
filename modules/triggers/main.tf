resource "google_cloudbuild_trigger" "build-trigger" {
  name        = var.name
  description = var.description
  disabled    = var.disabled
  filename    = var.filename

  github {
    owner = "snoogft"
    push {
      branch = var.branch
    }
  }
}
