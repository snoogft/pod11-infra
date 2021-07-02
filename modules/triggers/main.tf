resource "google_cloudbuild_trigger" "build-trigger" {
  name        = var.name
  description = var.description
  disabled    = var.disabled
  filename    = var.filename

  trigger_template {
    branch_name = var.branch_name
    repo_name   = var.repo_name
  }
}
