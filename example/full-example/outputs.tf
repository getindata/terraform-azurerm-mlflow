output "storage_connection_string" {
  value = module.azure_mlfow.storage_connection_string
  sensitive = true
}

output "mlflow_tracking_uri" {
  value = module.azure_mlfow.mlflow_tracking_uri
}