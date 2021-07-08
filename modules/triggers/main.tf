resource "google_cloudbuild_trigger" "build-trigger" {
  name        = var.name
  description = var.description
  disabled    = var.disabled
  filename    = var.filename

  github {
    push {
      branch = var.branch
    }
  }
}
