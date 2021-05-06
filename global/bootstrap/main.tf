module "gcs_buckets" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "~> 1.7"

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