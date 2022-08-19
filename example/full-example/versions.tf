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
  }
}
