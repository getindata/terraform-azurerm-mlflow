module "storage_account" {
  source                = "getindata/storage-account/azurerm"
  version               = "1.7.1"
  context               = module.this.context
  create_resource_group = false
  location              = local.location
  resource_group_name   = data.azurerm_resource_group.rg.name
  skuname               = var.storage_sku

  # Container lists with access_type to create
  containers_list = [
    {
      name        = local.storage_container_name
      access_type = "private"
    }
  ]

  tags = module.this.context.tags
}
