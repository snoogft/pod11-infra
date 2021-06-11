output "project" {
  value = data.google_client_config.current.project
}

output "master_proxy_connection" {
  description = "Instance path for connecting with Cloud SQL Proxy. Read more at https://cloud.google.com/sql/docs/mysql/sql-proxy"
  value       = module.cloud_sql.master_proxy_connection
}

output "master_user_name" {
  description = "The username part for the default user credentials, i.e. 'master_user_name'@'master_user_host' IDENTIFIED BY 'master_user_password'. This should typically be set as the environment variable TF_VAR_master_user_name so you don't check it into source control."
  value       = module.cloud_sql.master_user_name
  sensitive   = true
}

output "master_user_password" {
  description = "The password part for the default user credentials, i.e. 'master_user_name'@'master_user_host' IDENTIFIED BY 'master_user_password'. This should typically be set as the environment variable TF_VAR_master_user_password so you don't check it into source control."
  value       = module.cloud_sql.master_user_password
  sensitive   = true
}

output "accounts_db_name" {
  description = "Accounts database name"
  value       = var.accounts_db_name
}

output "ledger_db_name" {
  description = "Ledger database name"
  value       = var.ledger_db_name
}
output "jwt_secret" {
  description = "JWT secret for k8s"
  value       = var.jwt_secret
}
