output "storage_connection_string" {
  description = "Connection string to MLflow's blob storage account"
  value       = data.azurerm_storage_account.storage_account.primary_connection_string
  sensitive   = true
}

output "mlflow_tracking_uri" {
  description = "Link to deployed MLflow instance"
  value       = "https://${jsondecode(azapi_resource.mlflow_app.output).properties.configuration.ingress.fqdn}"
}
