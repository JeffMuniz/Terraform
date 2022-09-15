data "azurerm_resource_group" "rg" {
  name                      = var.resource_group_name
}
resource "azurerm_virtual_network" "vnet" {
  name                      = var.vnet_core_name
  location                  = data.azurerm_resource_group.rg.location
  resource_group_name       = data.azurerm_resource_group.rg.name
  address_space             = var.vnet_core_range
  dns_servers               = var.vnet_core_dns
  tags                      = var.tags
}
resource "azurerm_subnet" "snet" {
  count                     = length(var.subnet_config)
  name                      = lookup(var.subnet_config[count.index], "name")
  resource_group_name       = data.azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet.name
  address_prefixes          = [var.subnet_config[count.index].range]
  service_endpoints         = lookup(var.subnet_config_service, var.subnet_config[count.index].name, null)
    
}
resource "azurerm_network_security_group" "nsg" {
  count                     = length(var.subnet_config)
  name                      = "nsg-${lookup(var.subnet_config[count.index], "name")}"
  location                  = data.azurerm_resource_group.rg.location
  resource_group_name       = data.azurerm_resource_group.rg.name
  tags                      = var.tags
}
