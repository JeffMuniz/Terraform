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

resource "azurerm_subnet_network_security_group_association" "nsg-servers" {
  count                     = length(var.subnet_config)
  subnet_id                 = azurerm_subnet.snet[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg[count.index].id
}

# resource "azurerm_network_security_rule" "ssh" {
# 	name                       = "SSH"
# 	priority                   = 1001
# 	direction                  = "Inbound"
# 	access                     = "Allow"
# 	protocol                   = "Tcp"
# 	source_port_range          = "*"
# 	destination_port_range     = "22"
# 	source_address_prefixes    = ["179.157.79.27/32","189.44.200.218/32","201.55.109.189/32","179.157.69.2/32"]
# 	destination_address_prefix = "*"
#   resource_group_name         = data.azurerm_resource_group.rg_demo.name
#   network_security_group_name = azurerm_network_security_group.snet-servers.name
# }

# resource "azurerm_network_security_rule" "https" {
# 	name                       = "HTTPS"
# 	priority                   = 100
# 	direction                  = "Inbound"
# 	access                     = "Allow"
# 	protocol                   = "Tcp"
# 	source_port_range          = "*"
# 	destination_port_range     = "443"
#   source_address_prefixes    = ["179.157.79.27/32","189.44.200.218/32","201.55.109.189","179.157.69.2/32"]
# 	destination_address_prefix = "*"
#   resource_group_name         = data.azurerm_resource_group.rg_demo.name
#   network_security_group_name = azurerm_network_security_group.snet-aks.name
# }

# resource "azurerm_network_security_rule" "http" {
# 	name                       = "HTTP"
# 	priority                   = 101
# 	direction                  = "Inbound"
# 	access                     = "Allow"
# 	protocol                   = "Tcp"
# 	source_port_range          = "*"
# 	destination_port_range     = "80"
#   source_address_prefixes    = ["179.157.79.27/32","189.44.200.218/32","201.55.109.189","179.157.69.2/32"]
# 	destination_address_prefix = "*"
#   resource_group_name         = data.azurerm_resource_group.rg_demo.name
#   network_security_group_name = azurerm_network_security_group.snet-aks.name
# }




# resource "azurerm_subnet" "snet-aks" {
#   name                 = var.snet_aks_name
#   resource_group_name  = data.azurerm_resource_group.rg_demo.name
#   virtual_network_name = azurerm_virtual_network.vnet-core.name
#   address_prefixes     = ["10.254.1.0/24"]
#   service_endpoints    = [ "Microsoft.Storage","Microsoft.Sql" ]
# }

# resource "azurerm_subnet" "snet-servers" {
#   name                 = var.snet_servers_name
#   resource_group_name  = data.azurerm_resource_group.rg_demo.name
#   virtual_network_name = azurerm_virtual_network.vnet-core.name
#   address_prefixes     = ["10.254.0.0/24"]
# }

# resource "azurerm_subnet_network_security_group_association" "nsg-servers" {
#     subnet_id                 = azurerm_subnet.snet-servers.id
#     network_security_group_id = azurerm_network_security_group.snet-servers.id
# }

# resource "azurerm_subnet_network_security_group_association" "nsg-aks" {
#     subnet_id                 = azurerm_subnet.snet-aks.id
#     network_security_group_id = azurerm_network_security_group.snet-aks.id
# }