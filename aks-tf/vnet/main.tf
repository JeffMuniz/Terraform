terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

provider "azurerm" {
  features {}
}

terraform {
    backend "azurerm" {
        resource_group_name  = "rg-net-aks-mac-prod"
        storage_account_name = "sanetaksmacprod01"
        container_name       = "tfstate-vnet"
       # key                  = "prod.vnet.tfstate"
        key                  = "prod.vnet.tfstate"
    }
}