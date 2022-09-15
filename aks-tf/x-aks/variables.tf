variable "resource_group_name" {
  type = string
  description = "Resource group onde  sera criado"
  default = "eastus"
}
variable "location" {
  type = string
  description = "Localizacao onde sera criado"
}
variable "tags" {
  type = map(string)
}

variable "acr_name" {  
  type = string
}
variable "acr_resource_group_name" {
  type = string  
}
variable "aks" {
}
variable "id_aks" {
  type = string
  description = "Nome do User Idendity para criacao e utilizacao"
}
variable "cluster_name" {
}
variable "admin_username" {
}



variable "agent_count" {
}
variable "ssh_public_key" {
}
variable "default_node_pool" { 
}




variable "vnet_resource_group_name" {
}
variable "vnet_core_name" {
  default = "vnet-core-aks-mac"
}
variable "vnet_core_range" {
  default = "10.111.111.0/24"
}
variable "vnet_core_dns" {
  default = ["10.80.12.4", "10.80.12.5"]
}
variable "dns_prefix" {
}
variable "name_prefix" {
  default = "k8s-cluster"
}
variable "rg_vnet" {
}
variable "nsg_aks_name" {
}
variable "snet_aks" {
}
variable "rt_name" {
}
variable "rt_aks" {
}
variable "public_ip" {
}
variable "lb_int" {
}  
variable nsg_allow {
  type = map(string)
}
variable nsg_allow_https {
  type = map(string)
}



/*
variable "azuread_application" {
  default = "aksapp"
}
variable "application_id" {
  default = "k8sapptest"
}

variable "azuread_application_aks" {
  default = "aksapp_aks"
}
variable "azuread_service_principal" {
  default = "k8s-srv-prince"
}






*/