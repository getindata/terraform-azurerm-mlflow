resource "azurerm_log_analytics_workspace" "log_workspace" {
  name                = local.log_analytics_name_from_descriptor
  location            = local.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  count               = var.log_analytics_workspace_id == null ? 1 : 0
}

data "azurerm_log_analytics_workspace" "log_workspace" {
  resource_group_name = data.azurerm_resource_group.rg.name
  name                = var.log_analytics_workspace_id

  count = var.log_analytics_workspace_id != null ? 1 : 0
}

locals {
  log_workspace = var.log_analytics_workspace_id == null ? {
    workspace_id       = one(azurerm_log_analytics_workspace.log_workspace[*]).workspace_id
    primary_shared_key = one(azurerm_log_analytics_workspace.log_workspace[*]).primary_shared_key
    } : {
    workspace_id       = one(data.azurerm_log_analytics_workspace.log_workspace[*]).workspace_id
    primary_shared_key = one(data.azurerm_log_analytics_workspace.log_workspace[*]).primary_shared_key
  }
}

resource "azapi_resource" "managed_environment" {
  name      = local.mlflow_name_from_descriptor
  location  = local.location
  parent_id = data.azurerm_resource_group.rg.id
  type      = "Microsoft.App/managedEnvironments@2022-03-01"

  body = jsonencode({
    properties = {
      appLogsConfiguration = {
        destination = "log-analytics"
        logAnalyticsConfiguration = {
          customerId = local.log_workspace.workspace_id
          sharedKey  = local.log_workspace.primary_shared_key
        }
      }
    }
  })

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

data "azurerm_storage_account" "storage_account" {
  depends_on          = [module.storage_account]
  name                = module.storage_account.storage_account_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azapi_resource" "mlflow_app" {
  name                   = local.mlflow_name_from_descriptor
  location               = local.location
  parent_id              = data.azurerm_resource_group.rg.id
  type                   = "Microsoft.App/containerApps@2022-03-01"
  response_export_values = ["*"]

  body = jsonencode({
    properties = {
      managedEnvironmentId = azapi_resource.managed_environment.id
      configuration = {
        ingress = {
          external   = true
          targetPort = 8080
          transport  = "auto"
        }
        secrets = [{
          name = "sql-connection-string"
          value = join("", ["mssql+pyodbc:///?odbc_connect=", urlencode(
            "Driver={ODBC Driver 18 for SQL Server};Server=tcp:${azurerm_mssql_server.mlflow_db_server.fully_qualified_domain_name},1433;Database=${azurerm_mssql_database.mlflow_db.name};Uid=${var.db_admin_username};Pwd=${random_password.db_password.result};Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;"
          )])
          },
          {
            name  = "storage-connection-string"
            value = data.azurerm_storage_account.storage_account.primary_connection_string
          },
          {
            name  = local.auth_client_secret
            value = var.auth.client_secret
          }
        ]
      }
      template = {
        containers = [{
          image = var.mlflow_docker_image
          name  = "mlflow-app"
          env = [{
            name = "BACKEND_STORE_URI"
            #checkov:skip=CKV_SECRET_6:This is only a secret name
            secretRef = "sql-connection-string"
            },
            {
              name  = "DEFAULT_ARTIFACT_ROOT"
              value = "wasbs://${local.storage_container_name}@${module.storage_account.storage_account_name}.blob.core.windows.net/artifacts"
            },
            {
              name = "AZURE_STORAGE_CONNECTION_STRING"
              #checkov:skip=CKV_SECRET_6:This is only a secret name
              secretRef = "storage-connection-string"
            }
          ]
          resources = {
            cpu    = var.cpu
            memory = var.memory
          }
        }]

        scale = {
          minReplicas = var.min_replicas
          maxReplicas = var.max_replicas
        }
      }
    }
  })

  lifecycle {
    ignore_changes = [
      tags
    ]
  }

  depends_on = [
    azapi_resource.managed_environment,
    azurerm_mssql_database.mlflow_db
  ]
}

resource "azapi_resource" "mlflow_app_auth" {
  name      = "current"
  parent_id = azapi_resource.mlflow_app.id
  type      = "Microsoft.App/containerApps/authConfigs@2022-03-01"

  body = jsonencode({
    properties = {
      platform = {
        enabled = true
      }
      globalValidation = {
        unauthenticatedClientAction = "RedirectToLoginPage"
      }
      identityProviders = {
        (var.auth.type) = lookup(local.identity_providers, var.auth.type, null)
      }
    }
  })
}
