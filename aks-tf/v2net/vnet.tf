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

resource "azurerm_public_ip" "public_ip" {
  name                = "ip-lb-aks-mac-ext"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}





resource "azurerm_lb" "lb_aks_mac" {
  name                = "lb-aks-mac-int"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "Standard"/*
resource "azurerm_lb" "lbi-snet-aks" {
  name                = "lbi-snet-aks"
  location            = "eastus"
  resource_group_name = "${data.azurerm_resource_group.rg.name}"
  sku                 = "Standard"
*/
  frontend_ip_configuration {
    name                 = "frontend-pub-ipp-add"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}
/*
  frontend_ip_configuration {
    name                          = "Server"
    subnet_id                     = "${azurerm_subnet.snet-aks.id}"
    private_ip_address_allocation = "Dynamic"
    #private_ip_address            = "${cidrhost(var.subnet_config["azurerm_subnet.snet-aks.id"], 10)}"
  }
}
*/



resource "azurerm_subnet" "snet-aks" {
  name                 = "snet-aks"
  resource_group_name  = "rg-net-aks-mac-dev"
  virtual_network_name = "vnet-core-aks-mac"
  address_prefixes     = ["10.176.9.7/21"]
  service_endpoints    = [ "Microsoft.Storage","Microsoft.Sql" ]
}
resource "azurerm_subnet" "snet-servers" {
  name                 = "snet-servers"
  resource_group_name  = "rg-net-aks-mac-dev"
  virtual_network_name = "vnet-core-aks-mac"
  address_prefixes     = ["10.176.11.128/25"]
}
resource "azurerm_subnet_network_security_group_association" "nsg-servers" {
  count                     = length(var.subnet_config)
  subnet_id                 = azurerm_subnet.snet[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg[count.index].id
  #subnet_id                 = azurerm_subnet.snet-servers.id
  #network_security_group_id = azurerm_network_security_group.snet-servers.id
}

/*
resource "azurerm_subnet_network_security_group_association" "nsg-servers" {
    subnet_id                 = azurerm_subnet.snet-aks.id
    network_security_group_id = "4b9c58b0-0fd3-47fb-9945-af13385f45cb"
}
*/











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
#   resource_group_name         = data.azurerm_resource_group.rg_vnet.name
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
#   resource_group_name         = data.azurerm_resource_group.rg_vnet.name
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
#   resource_group_name         = data.azurerm_resource_group.rg_vnet.name
#   network_security_group_name = azurerm_network_security_group.snet-aks.name
# }