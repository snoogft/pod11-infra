data "template_file" "accounts_init_config_sql" {
  template = file("../../../scripts/0-template-db-init.tpl")
  vars = {
    db_name = data.terraform_remote_state.workspaces.outputs.accounts_db_name
    db_user = data.terraform_remote_state.workspaces.outputs.master_user_name
  }
}

data "template_file" "ledger_init_config_sql" {
  template = file("../../../scripts/0-template-db-init.tpl")
  vars = {
    db_name = data.terraform_remote_state.workspaces.outputs.ledger_db_name
    db_user = data.terraform_remote_state.workspaces.outputs.master_user_name
  }
}

data "template_file" "accounts_schema_config_sql" {
  template = file("../../../scripts/0-template-db-schema.tpl")
  vars = {
    db_user = data.terraform_remote_state.workspaces.outputs.master_user_name
  }
}

data "template_file" "ledger_schema_config_sql" {
  template = file("../../../scripts/0-template-db-schema.tpl")
  vars = {
    db_user = data.terraform_remote_state.workspaces.outputs.master_user_name
  }
}