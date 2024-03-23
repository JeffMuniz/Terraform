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
      resource_group_name  = "rg-iac-aks-tpl"
      storage_account_name  = "saiacakstpl"
      container_name       = "ct-tfstate"
      key                  = "Infrastructure/aks/aks.ct-tfstate/"
    }
}

/*
data "local_file" "workspace_check" {
  count    = var.tags.env == terraform.workspace ? 0 : 1
  filename = "ERROR: Workspace does not match given environment name!"
}
*/

