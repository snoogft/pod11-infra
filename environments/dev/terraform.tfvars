members = [
  "user:mzkz@gft.com",
  "user:padk@gft.com",
  "user:jwwz@gft.com",
  "user:kamc@gft.com",
  "user:snoo@gft.com",
  "user:TZKZ@gft.com"
]
region                         = "europe-central2"
zone                           = "europe-central2-a"
secondary_region               = "europe-north1"
secondary_zones                = ["europe-north1-b"]
project                        = "pol-pod11-dev-01"
subnet_01_ip                   = "10.10.10.0/24"
subnet_01_secondary_01_ip      = "172.20.0.0/16"
subnet_01_secondary_01_name    = "subnet-01-secondary-01"
subnet_01_services_name        = "subnet-01-services-ip"
subnet_01_services_ip          = "192.168.128.0/24"
subnet_02_ip                   = "10.10.100.0/24"
subnet_02_secondary_01_ip      = "172.30.0.0/16"
subnet_02_secondary_01_name    = "subnet-01-pods-01"
subnet_02_services_name        = "subnet-01-services-ip"
subnet_02_services_ip          = "192.168.64.0/24"
compute_engine_service_account = "186160847895-compute@developer.gserviceaccount.com"
machine_type                   = "f1-micro"
machine_type_db                = "db-g1-small"