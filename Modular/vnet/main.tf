# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

terraform {
    backend "azurerm" {
        resource_group_name  = "rg-iac-aks-tpl"
        storage_account_name = "sanetiacakstpl"
        container_name       = "ct-tfstate-vnet"
        key                  = "dev.vnet.ct-tfstate"
    }
}