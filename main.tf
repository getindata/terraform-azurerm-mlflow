# TODO:
# https://techcommunity.microsoft.com/t5/fasttrack-for-azure/can-i-create-an-azure-container-apps-in-terraform-yes-you-can/ba-p/3570694

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

terraform {
  # Optional attributes and the defaults function are
  # both experimental, so we must opt in to the experiment.
  experiments = [module_variable_optional_attrs]
}
