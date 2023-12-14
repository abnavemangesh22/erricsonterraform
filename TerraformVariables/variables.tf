
variable "business_unit" {
  description = "This is Business unit name"
  type = string
  default = "hr"
}

variable "environment" {
  description = "This is the env parameter"
  type = string
  default = "dev"
}


variable "resource_group_name" {
  description = "This is the name of the group"
  type = string
  default = "myrg"
}


variable "resource_group_location" {
  type = string
  default = "East US"
}

variable "virtual_network_name" {
  type = string
  default = "myvent"
}

variable "subnet_name" {
  type = string
  default = "erricson"
}