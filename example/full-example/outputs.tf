output "storage_connection_string" {
  description = "Connection string to MLflow's blob storage account"
  value       = module.azure_mlfow.storage_connection_string
  sensitive   = true
}

output "mlflow_tracking_uri" {
  description = "Link to deployed MLflow instance"
  value       = module.azure_mlfow.mlflow_tracking_uri
}
