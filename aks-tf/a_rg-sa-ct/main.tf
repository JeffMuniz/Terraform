resource "azurerm_resource_group" "rg-aks-mac-prod" {
  name      = "rg-aks-mac-prod"
  location = "eastus"
  tags = {
  projectname = "project-shared-resources"
  clientname = "platform-team"
  techowner = "secops-team"
  bu = "mac"
  env = "prod"
}
}

#Criando Storage Accounts
resource "azurerm_storage_account" "saaksmacprod01" {
  depends_on = [azurerm_resource_group.rg-aks-mac-prod]
  name      = "saaksmacprod01"
  location = "eastus"
  resource_group_name      = "rg-aks-mac-prod"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    environment = "prod"
}
}
#Criando Containers
resource "azurerm_storage_container" "tfstate" {
  depends_on = [azurerm_storage_account.saaksmacprod01]
  name                  = "tfstate"
  storage_account_name  = "saaksmacprod01"
  container_access_type = "private"
}

resource "azurerm_resource_group" "rg-net-aks-mac-prod" {
#  depends_on = [azurerm_resource_group.rg-aks-mac-prod]
  name      = "rg-net-aks-mac-prod"
  location = "eastus"
  tags = {
  projectname = "project-shared-resources"
  clientname = "platform-team"
  techowner = "secops-team"
  bu = "mac"
  env = "prod"
}
}
#Criando Storage Accounts
resource "azurerm_storage_account" "sanetaksmacprod01" {
  depends_on = [azurerm_resource_group.rg-net-aks-mac-prod]
  name      = "sanetaksmacprod01"
  location = "eastus"
  resource_group_name      = "rg-net-aks-mac-prod"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    environment = "prod"
}
}
resource "azurerm_storage_container" "tfstate-vnet" {
  depends_on = [azurerm_storage_account.sanetaksmacprod01]
  name                  = "tfstate-vnet"
  storage_account_name  = "sanetaksmacprod01"
  container_access_type = "private"
}