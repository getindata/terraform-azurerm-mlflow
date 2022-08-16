locals {
  mlflow_name_from_descriptor        = replace(lookup(module.this.descriptors, "mlflow", module.this.id), "/--+/", "-")
  database_name_from_descriptor      = replace(lookup(module.this.descriptors, "database", module.this.id), "/--+/", "-")
  log_analytics_name_from_descriptor = replace(lookup(module.this.descriptors, "log-analytics", module.this.id), "/--+/", "-")
  location                           = var.location == null ? data.azurerm_resource_group.rg.location : var.location
  storage_container_name             = "mlflow-artifacts"
  #checkov:skip=CKV_SECRET_6:This is only a secret name
  auth_client_secret = "auth-client-secret"
  identity_providers = {
    google = {
      enabled = true
      registration = {
        clientId                = var.auth.client_id
        clientSecretSettingName = local.auth_client_secret
      }
      validation = {
        allowedAudiences = ["32555940559.apps.googleusercontent.com"]
      }
    }

    azureActiveDirectory = {
      enabled = true
      registration = {
        clientId                = var.auth.client_id
        clientSecretSettingName = local.auth_client_secret
        openIdIssuer            = "https://sts.windows.net/${var.auth.azureActiveDirectory != null ? var.auth.azureActiveDirectory.tenant_id : ""}/v2.0"
      }
    }
  }
}
