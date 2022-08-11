data "azurerm_resource_group" "this" {
  name = "my-resource-group"
}

module "azure_mlfow" {
  source  = "../.."
  context = module.this.context

  resource_group = data.azurerm_resource_group.this.name

  #  auth = {
  #    type = "google"
  #    client_secret = ""
  #    client_id = ""
  #  }

  auth = {
    type          = "azureActiveDirectory"
    client_secret = ""
    client_id     = ""
    azureActiveDirectory = {
      tenant_id = ""
    }
  }
}
