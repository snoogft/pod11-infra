/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

provider "google" {
  version = "~> 3.22"
}

provider "null" {
  version = "~> 2.1"
}

provider "random" {
  version = "~> 2.2"
}
resource "google_secret_manager_secret" "pgsql-root-password" {
  secret_id = "pgsql-root-password"

  replication {
    automatic = true
  }
}


resource "google_secret_manager_generated_password" "pgsql-root-password" {
  secret          = google_secret_manager_secret.pgsql-root-password.id
  logical_version = "v8"


  required {
    count    = 1
    alphabet = "~!@#$%^&*()_+-="
  }

  required {
    count    = 1
    alphabet = "1234567890"
  }

  required {
    count    = 1
    alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  }

  required {
    count    = 2
    alphabet = "abcdefghijklmnopqrstuvwxyz"
  }

  return_secret     = true
  delete_on_destroy = false
  provider          = google-secrets
}

output "secret" {
  value = "${google_secret_manager_generated_password.pgsql-root-password.id} = ${google_secret_manager_generated_password.mysql-root-password.value}"
}

module "pg" {
  source               = "GoogleCloudPlatform/sql-db/google//modules/postgresql"
  name                 = var.pg_ha_name
  random_instance_name = true
  project_id           = var.project_id
  database_version     = "POSTGRES_9_6"
  region               = var.region

  // Master configurations
  tier                            = "db-custom-2-13312"
  zone                            = var.zone
  availability_type               = "REGIONAL"
  maintenance_window_day          = 7
  maintenance_window_hour         = 12
  maintenance_window_update_track = "stable"

  deletion_protection = false

  database_flags = [{ name = "autovacuum", value = "off" }]

  user_labels = {
    foo = "bar"
  }

  ip_configuration = {
    ipv4_enabled    = true
    require_ssl     = true
    private_network = null
    authorized_networks = [
      {
        name  = "${var.project_id}-cidr"
        value = var.pg_ha_external_ip_range
      },
    ]
  }


  db_name      = var.pg_ha_name
  db_charset   = "UTF8"
  db_collation = "en_US.UTF8"
  user_name     = var.db_user
  user_password = google_secret_manager_secret.pgsql-root-password
}
