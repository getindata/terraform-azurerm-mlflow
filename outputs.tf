output "storage_connection_string" {
  value     = data.azurerm_storage_account.storage_account.primary_connection_string
  sensitive = true
}

output "mlflow_tracking_uri" {
  value = "https://${jsondecode(azapi_resource.mlflow_app.output).properties.configuration.ingress.fqdn}"
}