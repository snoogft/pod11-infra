

# A testing VM to allow OS Login + IAP tunneling.
module "instance_template" {
  source  = "terraform-google-modules/vm/google//modules/instance_template"
  version = "1.1.0"
  project_id   = var.project
  machine_type = "f1-micro"
  subnetwork   = var.subnetwork
  service_account = {
    email  = var.vm-sa-email
    scopes = ["cloud-platform"]
  }
  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_compute_instance_from_template" "vm" {
  name    = var.instance
  project = var.project
  zone    = var.zone
  network_interface {
    subnetwork = var.subnetwork
  }
  source_instance_template = module.instance_template.self_link
}

# Additional OS login IAM bindings.
//resource "google_service_account_iam_binding" "sa_user" {
//  service_account_id = var.vm_sa_id
//  role               = "roles/iam.serviceAccountUser"
//  members            = var.members
//}

resource "google_project_iam_member" "os_login_bindings" {
  for_each = toset(var.members)
  project  = var.project
  role     = "roles/compute.osLogin"
  member   = each.key
}

module "iap_tunneling" {
  source                     = "terraform-google-modules/bastion-host/google//modules/iap-tunneling"
  fw_name_allow_ssh_from_iap = "test-allow-ssh-from-iap-to-tunnel"
  project                    = var.project
  network                    = var.network
  service_accounts           = ["terraform-service-account@pol-pod11-dev-01.iam.gserviceaccount.com"]
  instances = [{
    name = google_compute_instance_from_template.vm.name
    zone = var.zone
  }]
  members = var.members
}
