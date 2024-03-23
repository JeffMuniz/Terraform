id_aks_name = "id-aks"
agent_count = 1
admin_username = "mac"
ssh_public_key = "~/.ssh/id_rsa.pub"
dns_prefix = "aks-macna"
cluster_name = "aks-macna"
resource_group_name = "rg-iac-aks-tpl"
location = "eastus"
acr_name = "acriacakstpldev"
acr_resource_group_name = "rg-iac-aks-tpl"
tags = {
  projectname = "shared-resources"
  clientname = "platform-team"
  techowner = "Fernando Lima"
  bu = "mac"
  env = "dev"
}
nsg_aks_name = "nsg-snet-aks"
vnet_resource_group_name = "rg-iac-aks-tpl"
rt_name = "rt-aks-outbound"
snet_aks_name = "snet-aks"
vnet_core_name = "vnet-core-aks"
nsg_allow = {
	name                       = "SSH"
	priority                   = 1001
	direction                  = "Inbound"
	access                     = "Allow"
	protocol                   = "Tcp"
	source_port_range          = "*"
	destination_port_range     = "22,3389"
	source_address_prefix      = "179.157.79.27/32"
	destination_address_prefix = "*"
}
nsg_allow_https = {
	name                       = "HTTPS"
	priority                   = 100
	direction                  = "Inbound"
	access                     = "Allow"
	protocol                   = "Tcp"
	source_port_range          = "*"
	destination_port_range     = "443"
  	source_address_prefix      = "179.157.79.27/32"
	destination_address_prefix = "*"
}

default_node_pool = {
	name                = "agentpool"
    node_count          = "1"
    vm_size             = "Standard_B2ms"
}

route_table_routes = [
	{
		name = "rt-network-all-outbound"
		address_prefix = "0.0.0.0/0"
		next_hop_type = "VirtualAppliance"
		next_hop_in_ip_address = "10.175.1.36"
	}
]