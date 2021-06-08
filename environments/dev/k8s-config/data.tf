data "template_file" "accounts_init_config_sql" {
  template = file("../../../scripts/0-accountsdb-init.sql.tpl")
  vars = {
    accounts_db_password = data.terraform_remote_state.dev.outputs.accounts_db_password
  }
}

data "template_file" "ledger_init_config_sql" {
  template = file("../../../scripts/0-ledgerdb-init.sql.tpl")
  vars = {
    ledger_db_password = data.terraform_remote_state.dev.outputs.ledger_db_password
  }
}
