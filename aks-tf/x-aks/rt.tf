resource "azurerm_route_table" "rt_aks" {
  name = "${var.aks}-${var.tags.env}"
  location = var.location
  resource_group_name = var.rg_vnet
  
  dynamic "route" {
    for_each = var.rt_name
    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = route.value.next_hop_in_ip_address
    }
  }
  lifecycle {
    ignore_changes = [route]
  }
}

resource "azurerm_subnet_route_table_association" "rt_subnet" {
  subnet_id = data.azurerm_subnet.snet_aks.id
  route_table_id = azurerm_route_table.rt_aks.id
}
