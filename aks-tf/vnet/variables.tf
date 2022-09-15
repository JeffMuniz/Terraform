variable "resource_group_name" {
  type = string  
}
variable "location" {
}
variable "tags" {
  type = map(string)
}


variable "vnet_core_name" {
}
variable "vnet_core_range" {
}
variable "vnet_core_dns" {
}
variable "subnet_config" {
}
variable "subnet_config_service" {
}
