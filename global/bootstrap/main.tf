module "gcs_buckets" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "~> 2.0.0"

  project_id = var.project_id
  name       = format("%s-%s", var.project_id, var.name)
  location   = var.location

  iam_members = [{
    role   = "roles/storage.objectAdmin"
    member = format("serviceAccount:%s", var.iam_member)
  }]

  versioning    = var.versioning
  force_destroy = var.force_destroy
  labels = ({
    project = var.project_id
    purpose = "tfstate"
  })
}

resource "google_container_registry" "registry" {
  project  = var.project_id
  location = "EU"
}

module "gcs_buckets_cloudbuild" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "~> 2.0.0"

  project_id = var.project_id
  name       = format("%s_cloudbuild", var.project_id)
  location   = var.location

  iam_members = [{
    role   = "roles/storage.objectAdmin"
    member = format("serviceAccount:%s", var.iam_member)
  }]

  lifecycle_rules = [{
    action = {
      type = "Delete"
    }
    condition = {
      age        = 7
      with_state = "ANY"
    }
  }]
  versioning    = false
  force_destroy = true
  labels = ({
    project = var.project_id
    purpose = "cloudbuild"
  })
}