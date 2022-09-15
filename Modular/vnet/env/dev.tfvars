resource_group_name = "rg-iac-aks-tpl"
location = "eastus"
vnet_core_name = "vnet-core-aks"
vnet_core_range = ["10.175.8.0/21"]
vnet_core_dns = ["10.80.12.4", "10.80.12.5"]
tags = {
  projectname = "network-resources"
  clientname = "platform-team"
  techowner = "platform-team"
  bu = "vertem"
  env = "dev"
}
subnet_config = [
  {
    "name" = "snet-infra"
    "range" = "10.175.8.0/26"
  },
  {
    "name" = "snet-app"
    "range" = "10.175.8.64/26"
  },
  {
    "name" = "snet-sec"
    "range" = "10.175.8.128/26"
  },
  {
    "name" = "snet-jump"
    "range" = "10.175.8.192/26"
  },
  {
    "name" = "snet-private"
    "range" = "10.175.9.0/25"
  },
  {
    "name" = "snet-database"
    "range" = "10.175.9.128/25"
  },
  {
    "name" = "snet-aks"
    "range" = "10.175.10.128/25"
  },
  {
    "name" = "snet-appgw01"
    "range" = "10.175.10.0/27"
  }
]


subnet_config_service = {
  "snet-infra" = ["Microsoft.Storage","Microsoft.Sql"]
  "snet-app" = ["Microsoft.Storage"]
}


nsg_rules_snet-appgw01 = {
    appgw = {
      name                       = "AppGWv2"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      source_address_prefix      = "Internet"
      destination_port_range     = "65200-65535"
      destination_address_prefix = "*"
    },
    sql = {
      name                       = "HttpHttps"
      priority                   = 101
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80,443"
      source_address_prefix      = "201.91.193.190/32,179.157.69.2/32"      
      destination_address_prefix = "*"
    }
}
