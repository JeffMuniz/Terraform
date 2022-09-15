variable "agent_count" {
}

variable "ssh_public_key" {
}

variable "dns_prefix" {
}

variable "cluster_name" {
  type = string
  description = "Nome do cluster"
}

variable "resource_group_name" {
  type = string
  description = "Resource group onde o cluster sera criado"
  default = "eastus"
}

variable "location" {
  type = string
  description = "Localizacao onde o cluste sera criado"
}

variable "acr_name" {  
  type = string
}

variable "acr_resource_group_name" {
  type = string  
}

variable "tags" {
  type = map(string)
}

variable "nsg_aks_name" {
}

variable "vnet_core_name" {
}

variable "vnet_resource_group_name" {
  
}
variable "snet_aks_name" {
}

variable "rt_name" {
  
}

variable nsg_allow {
  type = map(string)
}

variable nsg_allow_https {
  type = map(string)
}

variable "id_aks_name" {
  type = string
  description = "Nome do User Idendity para criacao e utilizacao no cluster"
}

variable "default_node_pool" {
  
}

variable "admin_username" {
  
}

variable "route_table_routes" {
  
}