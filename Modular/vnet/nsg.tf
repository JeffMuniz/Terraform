# resource "azurerm_network_security_rule" "nsg_rules_snet-appgw01" {
#   for_each                    = local.nsg_rules_snet-appgw01 
#   name                        = each.key
#   direction                   = each.value.direction
#   access                      = each.value.access
#   priority                    = each.value.priority
#   protocol                    = each.value.protocol
#   source_port_range           = each.value.source_port_range
#   destination_port_range      = each.value.destination_port_range
#   source_address_prefix       = each.value.source_address_prefix
#   destination_address_prefix  = each.value.destination_address_prefix
#   resource_group_name         = data.azurerm_resource_group.rg.name
#   network_security_group_name = azurerm_network_security_group.nsg_rules_snet-appgw01.name
# }