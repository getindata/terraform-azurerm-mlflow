# Example configuration of terraform providers

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.17.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">=3.3.2"
    }

    azapi = {
      source  = "Azure/azapi"
      version = "1.10.0"
    }
  }
}
