locals {
  location               = var.location == null ? data.azurerm_resource_group.rg.location : var.location
  storage_container_name = "mlflow-artifacts"
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
