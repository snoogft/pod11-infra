module "postgresql-db" {
  source               = "GoogleCloudPlatform/sql-db/google//modules/postgresql"
  version              = "5.0.1"
  name                 = "db-${var.env}"
  random_instance_name = true
  database_version     = var.postgres_version
  project_id           = var.project_id
  zone                 = var.zone
  region               = var.region
  tier                 = var.machine_type

  deletion_protection = false

  ip_configuration = {
    ipv4_enabled    = true
    private_network = var.private_network
    require_ssl     = true
    authorized_networks = [
      {
        name : var.authorized_networks_name,
        value : var.authorized_networks
      }
    ]
  }

  database_flags = [
    {
      name  = "cloudsql.iam_authentication"
      value = "On"
    },
  ]

  additional_users = [
    {
      name     = "tftest2"
      password = "abcdefg"
      host     = "localhost"
    },
    {
      name     = "tftest3"
      password = "abcdefg"
      host     = "localhost"
    },
  ]

  # Supports creation of both IAM Users and IAM Service Accounts with provided emails
  iam_user_emails = [
    var.cloudsql_pg_sa
  ]
}