data "azurerm_resource_group" "rg_aks" {
  name                  = var.resource_group_name
}
data "azurerm_resource_group" "rg_vnet" {
  name                  = var.rg_vnet  
}
data "azurerm_subnet" "snet_aks" {
  name                  = var.snet_aks
  virtual_network_name  = var.vnet_core_name
  resource_group_name   = var.rg_vnet
}
data "azurerm_container_registry" "acr_aks" {
  name  = var.acr_name
  resource_group_name = var.acr_resource_group_name
}
resource "azurerm_user_assigned_identity" "id_aks" {
  resource_group_name   = data.azurerm_resource_group.rg_aks.name
  location              = data.azurerm_resource_group.rg_aks.location
  name                  = "${var.id_aks}-${var.tags.env}"
  tags                  = var.tags
}
resource "azurerm_role_assignment" "aks_sp_container_registry" {
  scope                 = data.azurerm_container_registry.acr_aks.id
  role_definition_name  = "AcrPull"
  principal_id          = azurerm_user_assigned_identity.id_aks.principal_id
  timeouts {
    create              = "5m"
    update              = "5m"
  }
}
resource "azurerm_role_assignment" "aks_permissions" {
  scope                 = data.azurerm_resource_group.rg_aks.id
  role_definition_name  = "Contributor"
  principal_id          = azurerm_user_assigned_identity.id_aks.principal_id
  timeouts {
    create              = "5m"
    update              = "5m"
  }
}

# resource "azurerm_role_assignment" "attach_acr" {
#   scope                = data.azurerm_container_registry.acr_aks.id
#   role_definition_name = "AcrPull"
#   principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
# }

resource "azurerm_role_assignment" "aks_permissions_vnet" {
  scope                 = data.azurerm_resource_group.rg_vnet.id
  role_definition_name  = "Contributor"
  principal_id          = azurerm_user_assigned_identity.id_aks.principal_id
  timeouts {
    create              = "5m"
    update              = "5m"
  }
}



resource "azurerm_public_ip" "public_ip" {
  name                = "pub-ip"
  location         = data.azurerm_resource_group.rg_vnet.location
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  allocation_method   = "Static"
}



resource "azurerm_lb" "lb_int" {
  name                = var.lb_int
  location         = data.azurerm_resource_group.rg_vnet.location
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "fend-pub-ip"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}





resource "azurerm_kubernetes_cluster" "aks" {
  name                  = "${var.cluster_name}-${var.tags.env}"
  location              = data.azurerm_resource_group.rg_aks.location
  resource_group_name   = data.azurerm_resource_group.rg_aks.name
  dns_prefix            = "${var.dns_prefix}-${var.tags.env}"
  tags                  = var.tags
  
  lifecycle {
    ignore_changes = [tags]
  }

  depends_on = [
    azurerm_user_assigned_identity.id_aks, azurerm_subnet_route_table_association.rt_subnet, azurerm_role_assignment.aks_permissions_vnet, azurerm_role_assignment.aks_permissions,
  ]

  linux_profile {
    admin_username      = var.admin_username

    ssh_key {
      key_data          = file(var.ssh_public_key)
    }
  }

  default_node_pool {
    name                = "${var.default_node_pool.name}${var.tags.env}"
    node_count          = var.default_node_pool.node_count
    vm_size             = var.default_node_pool.vm_size
    vnet_subnet_id      = data.azurerm_subnet.snet_aks.id
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 3
    availability_zones = [ 1, 2, 3 ]

  }

  identity {
    type = "UserAssigned"
    user_assigned_identity_id = azurerm_user_assigned_identity.id_aks.id
  }

  kubelet_identity {
    client_id = azurerm_user_assigned_identity.id_aks.client_id
    object_id = azurerm_user_assigned_identity.id_aks.principal_id
    user_assigned_identity_id = azurerm_user_assigned_identity.id_aks.id
  }
  network_profile {
    load_balancer_sku   = "Standard"
    network_plugin      = "azure"
    outbound_type       = "userDefinedRouting"
  }
  
}

resource "azurerm_kubernetes_cluster_node_pool" "nodepool1" {
  name                  = "nlab${var.tags.env}"
  availability_zones    = [1, 2, 3]
  enable_auto_scaling   = true
  role_based_access_control = true
  min_count             = 1
  max_count             = 3
  os_disk_size_gb       = 128
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  priority              = "Regular"
  vm_size             = "Standard_B2ms"
  #vm_size               = "Standard_DS2_v2"
  vnet_subnet_id        = data.azurerm_subnet.snet_aks.id
  mode                  = "User"
  node_labels = {
    "nlab" = "nlab"
  }
  /*
  role_based_access_control {
  enabled = true
  }
*/
  tags = var.tags
  lifecycle {
    ignore_changes = [tags]
  }
}



/*
## Create Azure AD Application for Service Principal = ApplicationsClient status 403  Authorization_RequestDenied: Insufficient privileges
resource "azuread_application" "aks" {
# name = "${var.name_prefix}-sp"
  display_name = "${var.name_prefix}-dn"
}
# Create Service Principal
resource "azuread_service_principal" "aks" {
  application_id = azuread_application.aks.id
  use_existing   = true
}
# Create Service Principal password
resource "azuread_service_principal_password" "aks" {
  end_date             = "2299-12-30T23:00:00Z"                        # Forever
  service_principal_id = "${azuread_service_principal.aks.id}"
  #value                = "${random_string.password.result}"
}

# Generate random string to be used for Service Principal Password
resource "random_string" "password" {
  length  = 32
  special = true
}


*/