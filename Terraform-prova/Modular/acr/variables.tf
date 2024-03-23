variable "acr_name" {
  type = string
  description = "Nome do ACR, lembrando que esse valor sera concatenado com o env do ambiente e so deve ser utilizado letras e numeros"
  default = ""
}
variable "acr_sku" {
  type = string
  description = "SKU para o ACR, Standard ou Premium"
  default = ""
}

variable "resource_group_name" {
  type = string
  description = "Nome do resource group para utilizar no provisionamento"
  default = ""
}

variable "tags" {
  type = map(string)
  description = "Valores para as tags dos recursos"
}
