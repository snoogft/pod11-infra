resource "kubernetes_service_account" "preexisting" {
  metadata {
    name      = var.k8s_sa_name
    namespace = var.namespace
    annotations = {
      "iam.gke.io/gcp-service-account" = module.workload_identity.gcp_service_account_email
    }
  }
}

module "workload_identity" {
  source              = "../modules/workload-identity"
  project_id          = var.project
  name                = "boa-${var.cluster_name}"
  namespace           = var.namespace
  use_existing_k8s_sa = true
  k8s_sa_name         = var.k8s_sa_name
  cluster_name        = var.cluster_name
  location            = var.zone
  roles = [
    "roles/cloudtrace.agent",
    "roles/monitoring.metricWriter",
    "roles/cloudsql.client",
  ]
}

resource "kubernetes_secret" "cloud_sql_admin" {
  metadata {
    name = "cloud-sql-admin"
  }

  data = {
    username       = data.terraform_remote_state.workspaces.outputs.master_user_name
    password       = data.terraform_remote_state.workspaces.outputs.master_user_password
    connectionName = data.terraform_remote_state.workspaces.outputs.master_proxy_connection
  }

  type = "Opaque"
}

resource "kubernetes_config_map" "environment_config" {
  metadata {
    name = "environment-config"
  }

  data = {
    LOCAL_ROUTING_NUM = "883745000"
    PUB_KEY_PATH      = "/root/.ssh/publickey"
  }
}

resource "kubernetes_config_map" "service_api_config" {
  metadata {
    name = "service-api-config"
  }

  data = {
    TRANSACTIONS_API_ADDR = "ledgerwriter:8080"
    BALANCES_API_ADDR     = "balancereader:8080"
    HISTORY_API_ADDR      = "transactionhistory:8080"
    CONTACTS_API_ADDR     = "contacts:8080"
    USERSERVICE_API_ADDR  = "userservice:8080"
  }
}

resource "kubernetes_config_map" "demo_data_config" {
  metadata {
    name = "demo-data-config"
  }

  data = {
    USE_DEMO_DATA       = "True"
    DEMO_LOGIN_USERNAME = "testuser"
    DEMO_LOGIN_PASSWORD = "password"
  }
}

resource "kubernetes_config_map" "accounts_db_config" {
  metadata {
    name = "accounts-db-config"
  }

  data = {
    POSTGRES_DB       = data.terraform_remote_state.workspaces.outputs.accounts_db_name
    POSTGRES_USER     = data.terraform_remote_state.workspaces.outputs.master_user_name
    POSTGRES_PASSWORD = data.terraform_remote_state.workspaces.outputs.master_user_password
    ACCOUNTS_DB_URI   = format("postgresql://%s:%s@127.0.0.1:5432/%s", data.terraform_remote_state.workspaces.outputs.master_user_name, data.terraform_remote_state.workspaces.outputs.master_user_password, data.terraform_remote_state.workspaces.outputs.accounts_db_name)
  }
}

resource "kubernetes_config_map" "ledger_db_config" {
  metadata {
    name = "ledger-db-config"
  }

  data = {
    POSTGRES_DB       = data.terraform_remote_state.workspaces.outputs.ledger_db_name
    POSTGRES_USER     = data.terraform_remote_state.workspaces.outputs.master_user_name
    POSTGRES_PASSWORD = data.terraform_remote_state.workspaces.outputs.master_user_password
    # Updated to use CloudSQL Proxy
    SPRING_DATASOURCE_URL      = format("jdbc:postgresql://127.0.0.1:5432/%s", data.terraform_remote_state.workspaces.outputs.ledger_db_name)
    SPRING_DATASOURCE_USERNAME = data.terraform_remote_state.workspaces.outputs.master_user_name     # should match POSTGRES_USER
    SPRING_DATASOURCE_PASSWORD = data.terraform_remote_state.workspaces.outputs.master_user_password # should match POSTGRES_PASSWORD
  }
}

resource "kubernetes_config_map" "accounts_init_config" {
  metadata {
    name = "accounts-init-config"
  }

  data = {
    "0-accountsdb-init.sql"   = data.template_file.accounts_init_config_sql.rendered
    "0-accountsdb-schema.sql" = data.template_file.accounts_schema_config_sql.rendered
  }
}

resource "kubernetes_config_map" "ledger_init_config" {
  metadata {
    name = "ledger-init-config"
  }

  data = {
    "0-ledgerdb-init.sql"   = data.template_file.ledger_init_config_sql.rendered
    "0-ledgerdb-schema.sql" = data.template_file.ledger_schema_config_sql.rendered
  }
}

resource "kubernetes_job" "create_accounts_db" {
  wait_for_completion = false
  depends_on          = [kubernetes_config_map.accounts_init_config, kubernetes_secret.cloud_sql_admin, module.workload_identity]
  metadata {
    name = "create-accounts-db"
  }
  spec {
    backoff_limit = 4
    template {
      metadata {}
      spec {
        volume {
          name = "scripts"
          config_map {
            name = "accounts-init-config"
          }
        }
        container {
          name    = "create-accounts-db"
          image   = "eu.gcr.io/pol-pod11-dev-01/postgresql-client:latest"
          command = ["bash", "-c"]
          args    = ["sleep 30 && psql -h 127.0.0.1 -p 5432 -d postgres -f /scripts/0-accountsdb-init.sql && psql -h 127.0.0.1 -p 5432 -d accountsdb -f /scripts/0-accountsdb-schema.sql && sql_proxy_pid=$(/usr/bin/pgrep cloud_sql_proxy) && kill -INT $sql_proxy_pid"]
          env {
            name = "PGUSER"
            value_from {
              secret_key_ref {
                name = "cloud-sql-admin"
                key  = "username"
              }
            }
          }
          env {
            name = "PGPASSWORD"
            value_from {
              secret_key_ref {
                name = "cloud-sql-admin"
                key  = "password"
              }
            }
          }
          volume_mount {
            name       = "scripts"
            read_only  = true
            mount_path = "/scripts"
          }
          security_context {
            capabilities {
              add = ["SYS_PTRACE"]
            }
          }
        }
        container {
          name    = "cloudsql-proxy"
          image   = "gcr.io/cloudsql-docker/gce-proxy:1.19.0-alpine"
          command = ["/cloud_sql_proxy", "-instances=$(CONNECTION_NAME)=tcp:5432"]
          env {
            name = "CONNECTION_NAME"
            value_from {
              secret_key_ref {
                name = "cloud-sql-admin"
                key  = "connectionName"
              }
            }
          }
          resources {
            limits = {
              cpu    = "200m"
              memory = "100Mi"
            }
          }
          security_context {
            run_as_non_root = true
          }
        }
        restart_policy          = "Never"
        service_account_name    = "boa-ksa"
        share_process_namespace = true
      }
    }
  }
}

resource "kubernetes_job" "create_ledger_db" {
  wait_for_completion = false
  depends_on          = [kubernetes_config_map.ledger_init_config, kubernetes_secret.cloud_sql_admin, module.workload_identity]
  metadata {
    name = "create-ledger-db"
  }
  spec {
    backoff_limit = 4
    template {
      metadata {}
      spec {
        volume {
          name = "scripts"
          config_map {
            name = "ledger-init-config"
          }
        }
        container {
          name    = "create-ledger-db"
          image   = "eu.gcr.io/pol-pod11-dev-01/postgresql-client:latest"
          command = ["bash", "-c"]
          args    = ["sleep 30 && psql -h 127.0.0.1 -p 5432 -d postgres -f /scripts/0-ledgerdb-init.sql && psql -h 127.0.0.1 -p 5432 -d ledgerdb -f /scripts/0-ledgerdb-schema.sql && sql_proxy_pid=$(/usr/bin/pgrep cloud_sql_proxy) && kill -INT $sql_proxy_pid"]
          env {
            name = "PGUSER"
            value_from {
              secret_key_ref {
                name = "cloud-sql-admin"
                key  = "username"
              }
            }
          }
          env {
            name = "PGPASSWORD"
            value_from {
              secret_key_ref {
                name = "cloud-sql-admin"
                key  = "password"
              }
            }
          }
          volume_mount {
            name       = "scripts"
            read_only  = true
            mount_path = "/scripts"
          }
          security_context {
            capabilities {
              add = ["SYS_PTRACE"]
            }
          }
        }
        container {
          name    = "cloudsql-proxy"
          image   = "gcr.io/cloudsql-docker/gce-proxy:1.19.0-alpine"
          command = ["/cloud_sql_proxy", "-instances=$(CONNECTION_NAME)=tcp:5432"]
          env {
            name = "CONNECTION_NAME"
            value_from {
              secret_key_ref {
                name = "cloud-sql-admin"
                key  = "connectionName"
              }
            }
          }
          resources {
            limits = {
              cpu    = "200m"
              memory = "100Mi"
            }
          }
          security_context {
            run_as_non_root = true
          }
        }
        restart_policy          = "Never"
        service_account_name    = "boa-ksa"
        share_process_namespace = true
      }
    }
  }
}

module "hub" {
  source                  = "terraform-google-modules/kubernetes-engine/google//modules/hub"
  version                 = "v15.0.0"
  project_id              = var.project
  cluster_name            = data.google_container_cluster.my_cluster.name
  location                = data.google_container_cluster.my_cluster.location
  cluster_endpoint        = data.google_container_cluster.my_cluster.endpoint
  gke_hub_membership_name = "membership-name-${var.cluster_name}"
  gke_hub_sa_name         = "gke-${var.cluster_name}"
}