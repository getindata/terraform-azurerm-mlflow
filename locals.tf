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

  log_workspace = var.log_analytics_workspace_id == null ? {
    workspace_id       = one(azurerm_log_analytics_workspace.log_workspace[*]).workspace_id
    primary_shared_key = one(azurerm_log_analytics_workspace.log_workspace[*]).primary_shared_key
    } : {
    workspace_id       = one(data.azurerm_log_analytics_workspace.log_workspace[*]).workspace_id
    primary_shared_key = one(data.azurerm_log_analytics_workspace.log_workspace[*]).primary_shared_key
  }

  api_versions = {
    container_apps              = "Microsoft.App/containerApps@2022-03-01"
    container_apps_auth_configs = "Microsoft.App/containerApps/authConfigs@2022-03-01"
    managed_environment         = "Microsoft.App/managedEnvironments@2022-03-01"
  }
}
