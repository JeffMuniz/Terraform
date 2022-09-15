data "azurerm_resource_group" "rg_acr" {
  name                = var.resource_group_name
}

resource "azurerm_container_registry" "acr" {
  name                = "${var.acr_name}${var.tags.env}"
  resource_group_name = data.azurerm_resource_group.rg_acr.name
  location            = data.azurerm_resource_group.rg_acr.location
  sku                 = var.acr_sku
  admin_enabled       = true
  tags                = var.tags
}