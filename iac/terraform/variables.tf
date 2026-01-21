variable "location" {
  type    = string
  default = "westeurope"
}

variable "resource_group_name" {
  type    = string
  default = "rg-platform"
}

variable "acr_name" {
  type = string
}

variable "aks_name" {
  type = string
}
