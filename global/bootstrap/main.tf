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

module "project-services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "10.1.1"

  project_id = var.project_id
  disable_services_on_destroy = var.disable_services_on_destroy
  activate_apis = var.activate_apis
}