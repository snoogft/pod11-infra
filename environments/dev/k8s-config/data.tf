data "template_file" "accounts_init_config_sql" {
  template = file("../../../scripts/0-template-db-init.tpl")
  vars = {
    db_name     = "accountsdb"
    db_user     = "accounts"
    db_password = data.terraform_remote_state.dev.outputs.accounts_db_password
  }
}

data "template_file" "ledger_init_config_sql" {
  template = file("../../../scripts/0-template-db-init.tpl")
  vars = {
    db_name     = "ledgerdb"
    db_user     = "ledger"
    db_password = data.terraform_remote_state.dev.outputs.ledger_db_password
  }
}

data "template_file" "accounts_schema_config_sql" {
  template = file("../../../scripts/0-template-db-schema.tpl")
  vars = {
    db_user     = "accounts"
  }
}

data "template_file" "ledger_schema_config_sql" {
  template = file("../../../scripts/0-template-db-schema.tpl")
  vars = {
    db_user     = "ledger"
  }
}