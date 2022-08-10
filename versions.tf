# Example configuration of terraform providers

terraform {
  required_version = ">= 0.13.0"

  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.1.1"
    }

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
      version = "0.4.0"
    }
  }
}
