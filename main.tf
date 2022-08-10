# TODO:
# https://techcommunity.microsoft.com/t5/fasttrack-for-azure/can-i-create-an-azure-container-apps-in-terraform-yes-you-can/ba-p/3570694

data "azurerm_resource_group" "rg" {
  name = var.resource_group
}

resource "random_id" "unique_suffix" {
  byte_length = 4
}
