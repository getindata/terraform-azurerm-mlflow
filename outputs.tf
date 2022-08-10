output "storage_connection_string" {
  value = data.azurerm_storage_account.storage_account.primary_connection_string
  sensitive = true
}