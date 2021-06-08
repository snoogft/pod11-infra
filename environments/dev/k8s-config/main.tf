module "workload_identity" {
  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  project_id          = var.project
  name                = "iden-${var.cluster_name}"
  namespace           = "default"
  use_existing_k8s_sa = false
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
    username       = data.terraform_remote_state.dev.outputs.master_user_name
    password       = data.terraform_remote_state.dev.outputs.master_user_password
    connectionName = data.terraform_remote_state.dev.outputs.master_proxy_connection
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
    POSTGRES_DB       = data.terraform_remote_state.dev.outputs.accounts_db_name
    POSTGRES_USER     = data.terraform_remote_state.dev.outputs.accounts_db_username
    POSTGRES_PASSWORD = data.terraform_remote_state.dev.outputs.accounts_db_password
    ACCOUNTS_DB_URI   = format("postgresql://%s:%s@127.0.0.1:5432/%s", data.terraform_remote_state.dev.outputs.accounts_db_username, data.terraform_remote_state.dev.outputs.accounts_db_password, data.terraform_remote_state.dev.outputs.accounts_db_name)
  }
}

resource "kubernetes_config_map" "ledger_db_config" {
  metadata {
    name = "ledger-db-config"
  }

  data = {
    POSTGRES_DB       = "postgresdb"
    POSTGRES_USER     = data.terraform_remote_state.dev.outputs.ledger_db_username
    POSTGRES_PASSWORD = "password1"
    # Updated to use CloudSQL Proxy
    SPRING_DATASOURCE_URL      = format("jdbc:postgresql://127.0.0.1:5432/%s", data.terraform_remote_state.dev.outputs.ledger_db_name)
    SPRING_DATASOURCE_USERNAME = data.terraform_remote_state.dev.outputs.ledger_db_username # should match POSTGRES_USER
    SPRING_DATASOURCE_PASSWORD = "password1" # should match POSTGRES_PASSWORD
  }
}

resource "kubernetes_config_map" "accounts_init_config" {
  metadata {
    name = "accounts-init-config"
  }

  data = {
    "0-accountsdb-init.sql" = data.template_file.accounts_init_config_sql.rendered
  }
}

resource "kubernetes_config_map" "ledger_init_config" {
  metadata {
    name = "ledger-init-config"
  }

  data = {
    "0-ledgerdb-init.sql" = data.template_file.ledger_init_config_sql.rendered
  }
}
