resource "azurerm_resource_group" "rg-iac-aks-tpl" {
  name      = "rg-iac-aks-tpl"
  location = "eastus"
  tags = {
  projectname = "shared-resources"
  clientname = "platform-team"
  techowner = "Fernando Lima"
  bu = "mac"
  env = "dev"
}
}

#Criando Storage Accounts
resource "azurerm_storage_account" "saiacakstpl" {
  name      = "saiacakstpl"
  location = "eastus"
  resource_group_name      = "rg-iac-aks-tpl"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "develop"
  }
}

resource "azurerm_storage_account" "sanetiacakstpl" {
  name      = "sanetiacakstpl"
  location = "eastus"
  resource_group_name      = "rg-iac-aks-tpl"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "develop"
  }
}

#Criando Containers
resource "azurerm_storage_container" "ct-tfstate" {
  depends_on = [azurerm_storage_account.saiacakstpl]
  name                  = "ct-tfstate"
  storage_account_name  = "saiacakstpl"
  container_access_type = "private"
}


resource "azurerm_storage_container" "ct-tfstate-vnet" {
  depends_on = [azurerm_storage_account.sanetiacakstpl]
  name                  = "ct-tfstate-vnet"
  storage_account_name  = "sanetiacakstpl"
  container_access_type = "private"
}
