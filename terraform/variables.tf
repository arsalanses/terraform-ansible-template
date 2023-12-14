# Provider
variable "ApiKey" {
  type      = string
  sensitive = true
}

# Arvan_iaas_abrak
variable "abrak_name" {
  type    = string
  default = "terraform-abrak-example"
}

# Region
variable "region" {
  type    = string
  default = "ir-thr-c2"
}

# Flavor
variable "flavor" {
  type    = string
  default = "sb1-1-1-0"
}
