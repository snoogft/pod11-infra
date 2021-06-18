

# A testing VM to allow OS Login + IAP tunneling.
module "instance_template" {
  source               = "terraform-google-modules/vm/google//modules/instance_template"
  version              = "1.1.0"
  project_id           = var.project
  machine_type         = var.machine_type
  subnetwork           = var.subnetwork
  source_image_family  = "debian-10"
  source_image_project = "debian-cloud"
  service_account = {
    email  = var.vm_sa_email
    scopes = ["cloud-platform"]
  }
  metadata = {
    enable-oslogin = "FALSE"
  }
}

data "template_file" "bastion_host_startup_script" {
  template = file("${path.module}/scripts/startup_script_bastion_host.tpl")
  vars = {
    cluster_name = var.cluster_name
    zone         = var.zone
  }
}

resource "google_compute_instance_from_template" "vm" {
  name                    = var.instance
  project                 = var.project
  zone                    = var.zone
  metadata_startup_script = data.template_file.bastion_host_startup_script.rendered
  network_interface {
    subnetwork = var.subnetwork
  }
  source_instance_template = module.instance_template.self_link
}

module "iap_tunneling" {
  source                     = "terraform-google-modules/bastion-host/google//modules/iap-tunneling"
  fw_name_allow_ssh_from_iap = "test-allow-ssh-from-iap-to-tunnel-${var.env}"
  project                    = var.project
  network                    = var.network
  service_accounts           = [var.vm_sa_email]
  instances = [{
    name = google_compute_instance_from_template.vm.name
    zone = var.zone
  }]
  members = var.members
}
