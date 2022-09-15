resource "azurerm_container_registry" "acraksmacprod" {
  name                = "acraksmacprod"
  resource_group_name = "rg-aks-mac-prod"
  location = "eastus"
  sku                 = "Standard"
  admin_enabled       = "true"

  tags = {
  projectname = "project-shared-resources"
  clientname = "platform-team"
  techowner = "secops-team"
  bu = "mac"
  env = "prod"
}
}
