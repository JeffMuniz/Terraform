terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.96.0"
    }
    local = {
        source = "hashicorp/local"
        version = "2.1.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "local" {
}

terraform {
    backend "azurerm" {
      resource_group_name  = "rg-aks-mac-prod"
      storage_account_name = "saaksmacprod01"
      container_name       = "tfstate"
      key                  = "Infrastructure/aks/aks1.tfstate/"
    }
}


/*
terraform {
  required_providers {
    hashicorp = {
      source = "hashicorp/hashicorp"
      version = "0.15.0"
    }
      azurerm = {
      source = "hashicorp/azurerm"
      version = "3.12.0"
    }
    local = {
        source = "hashicorp/local"
        version = "2.1.0"
    }
    azuread = {
        source = "hashicorp/azuread"
        version = "1.6.0"
    }
    helm = {
        source = "hashicorp/helm"
        version = "1.3.2"
    }
    random = {
        source = "hashicorp/random"
        version = "3.3.2"
    }
  }
}

provider "hashicorp" {
  features {}
}

provider "azurerm" {
  features {}
}

provider "local" {
}

provider "azuread" {
  features {}
}

provider "random" {
  features {}
}
provider "helm" {
}

*/