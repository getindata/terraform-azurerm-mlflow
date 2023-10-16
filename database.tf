resource "random_password" "db_password" {
  length      = 32
  min_special = 4
  min_numeric = 3
}


resource "azurerm_mssql_server" "mlflow_db_server" {
  #checkov:skip=CKV_AZURE_23:Auditing not required
  #checkov:skip=CKV_AZURE_24:Auditing not required
  #checkov:skip=CKV_AZURE_113:Only internal azure networks are enabled, and we need public endpoint to connect from Container App
  #checkov:skip=CKV2_AZURE_27:Ensure Azure AD authentication is enabled for Azure SQL (MSSQL)

  name                          = local.database_name_from_descriptor
  resource_group_name           = data.azurerm_resource_group.rg.name
  location                      = local.location
  version                       = "12.0"
  administrator_login           = var.db_admin_username
  administrator_login_password  = random_password.db_password.result
  minimum_tls_version           = "1.2"
  public_network_access_enabled = true
  tags                          = module.this.context.tags
}

resource "azurerm_mssql_firewall_rule" "mlflow_db_firewall_allow_internal" {
  # As per https://docs.microsoft.com/en-gb/rest/api/sql/2021-02-01-preview/firewall-rules/create-or-update?tabs=HTTP#request-body
  name             = local.database_name_from_descriptor
  server_id        = azurerm_mssql_server.mlflow_db_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_mssql_database" "mlflow_db" {
  # checkov:skip=CKV_AZURE_224:Ensure that the Ledger feature is enabled on database that requires cryptographic proof and nonrepudiation of data integrity
  name                        = local.database_name_from_descriptor
  server_id                   = azurerm_mssql_server.mlflow_db_server.id
  max_size_gb                 = var.db_max_size_gb
  sku_name                    = "GP_S_Gen5_2"
  storage_account_type        = var.db_backup_type
  auto_pause_delay_in_minutes = 60
  min_capacity                = 0.5
  read_scale                  = false
  zone_redundant              = false
  tags                        = module.this.context.tags
}
