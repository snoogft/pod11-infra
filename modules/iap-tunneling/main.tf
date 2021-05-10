resource "google_compute_network" "network" {
  project                 = var.project
  name                    = "test-network-iap"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  project                  = var.project
  name                     = "test-subnet-iap"
  region                   = var.region
  ip_cidr_range            = "10.127.0.0/20"
  network                  = google_compute_network.network.self_link
  private_ip_google_access = true
}

# A testing VM to allow OS Login + IAP tunneling.
module "instance_template" {
  source  = "terraform-google-modules/vm/google//modules/instance_template"
  version = "1.1.0"
  project_id   = var.project
  machine_type = var.machine_type
  subnetwork   = google_compute_subnetwork.subnet.self_link
  service_account = {
    email  = var.sa_email
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
    subnetwork = google_compute_subnetwork.subnet.self_link
  }
  source_instance_template = module.instance_template.self_link
}



module "iap_tunneling" {
  source  = "terraform-google-modules/bastion-host/google//examples/iap_tunneling"
  fw_name_allow_ssh_from_iap = "test-allow-ssh-from-iap-to-tunnel"
  project                    = var.project
  network                    = google_compute_network.network.self_link
  service_accounts           = [google_service_account.vm_sa.email]
  instances = [{
    name = google_compute_instance_from_template.vm.name
    zone = var.zone
  }]
  members = var.members
}