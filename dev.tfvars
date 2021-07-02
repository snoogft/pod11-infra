members = [
  "user:mzkz@gft.com",
  "user:padk@gft.com",
  "user:jwwz@gft.com",
  "user:kamc@gft.com",
  "user:snoo@gft.com",
  "user:TZKZ@gft.com"
]
region                         = "europe-west4"
region_2                       = "europe-west6"
zone                           = "europe-west4-a"
zone_2                         = "europe-west6-a"
project                        = "pol-pod11-dev-01"
subnet_01_ip                   = "10.10.10.0/24"
subnet_01_secondary_01_ip      = "172.25.0.0/16"
subnet_01_secondary_01_name    = "subnet-01-secondary-01"
subnet_01_services_name        = "subnet-01-services-ip"
subnet_01_services_ip          = "172.16.0.0/12"
compute_engine_service_account = "186160847895-compute@developer.gserviceaccount.com"
machine_type                   = "f1-micro"
machine_type_db                = "db-g1-small"
prefix                         = "dev"
autoscaling                    = true
node_count                     = 4
min_count                      = 4
max_count                      = 6
default_max_pods_per_node      = 55
machine_type_gke               = "e2-standard-4"
subnet_name                    = "subnet"
network_name                   = "vpc-network"