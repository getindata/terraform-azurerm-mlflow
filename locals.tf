locals {
  location               = var.location == null ? data.azurerm_resource_group.rg.location : var.location
  storage_container_name = "mlflow-artifacts"
}