resource "google_project_iam_member" "os_admin_login_bindings" {
  for_each = toset(var.members)
  project  = var.project
  role     = "roles/compute.osAdminLogin"
  member   = each.key
}

resource "google_project_iam_member" "iap_tunnel_bindings" {
  for_each = toset(var.members)
  project  = var.project
  role     = "roles/iap.tunnelResourceAccessor"
  member   = each.key
}

resource "google_project_iam_member" "compute_admin" {
  project = var.project
  role    = "roles/compute.admin"
  member  = var.cloud_build_member_name
}

resource "google_project_iam_member" "compute_network_admin" {
  project = var.project
  role    = "roles/compute.networkAdmin"
  member  = var.cloud_build_member_name
}

resource "google_project_iam_member" "container_admin" {
  project = var.project
  role    = "roles/container.admin"
  member  = var.cloud_build_member_name
}

resource "google_project_iam_member" "iam_role_admin" {
  project = var.project
  role    = "roles/iam.roleAdmin"
  member  = var.cloud_build_member_name
}

resource "google_project_iam_member" "iam_security_admin" {
  project = var.project
  role    = "roles/iam.securityAdmin"
  member  = var.cloud_build_member_name
}

resource "google_project_iam_member" "iam_service_account_admin" {
  project = var.project
  role    = "roles/iam.serviceAccountAdmin"
  member  = var.cloud_build_member_name
}

resource "google_project_iam_member" "iam_service_account_user" {
  project = var.project
  role    = "roles/iam.serviceAccountUser"
  member  = var.cloud_build_member_name
}

resource "google_project_iam_member" "resource_manager_project_iam_admin" {
  project = var.project
  role    = "roles/resourcemanager.projectIamAdmin"
  member  = var.cloud_build_member_name
}

resource "google_project_iam_member" "secret_manager_secret_accessor" {
  project = var.project
  role    = "roles/secretmanager.secretAccessor"
  member  = var.cloud_build_member_name
}

resource "google_project_iam_member" "service_managment_admin" {
  project = var.project
  role    = "roles/servicemanagement.admin"
  member  = var.cloud_build_member_name
}

resource "google_project_iam_member" "storage_admin" {
  project = var.project
  role    = "roles/storage.admin"
  member  = var.cloud_build_member_name
}

resource "google_project_iam_member" "cloud_sql_admin" {
  project = var.project
  role    = "roles/cloudsql.admin"
  member  = var.cloud_build_member_name
}
