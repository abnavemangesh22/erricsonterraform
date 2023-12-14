# Input Variables
# 6. Azure MySQL DB Name (Variable Type: String)
variable "db_name" {
  description = "Azure MySQL Database DB Name"
  type        = string
}

# 7. Azure MySQL DB Username (Variable Type: Sensitive String)
variable "db_username" {
  description = "Azure MySQL Database Administrator Username"
  type        = string
  sensitive   = true
}

# 8. Azure MySQL DB Password (Variable Type: Sensitive String)
variable "db_password" {
  description = "Azure MySQL Database Administrator Password"
  type        = string
  sensitive   = true
}

# 9. Azure MySQL DB Storage in MB (Variable Type: Number)
variable "db_storage_mb" {
  description = "Azure MySQL Database Storage in MB"
  type = number
}

# 10. Azure MYSQL DB auto_grow_enabled (Variable Type: Boolean)
variable "db_auto_grow_enabled" {
  description = "Azure MySQL Database - Enable or Disable Auto Grow Feature"
  type = bool
}

# 1. Business Unit Name
variable "business_unit" {
  description = "Business Unit Name"
  type = string 
  default = "hr"
}
# 2. Environment Name
variable "environment" {
  description = "Environment Name"
  type = string
  default = "dev"
}
# 3. Resource Group Name
variable "resource_group_name" {
  description = "Resource Group Name"
  type = string
  default = "myrg"
}
# 4. Resource Group Location
variable "resource_group_location" {
  description = "Resource Group Location"
  type = string
  default = "East US"
}
# 5. Virtual Network Name
variable "virtual_network_name" {
  description = "Virtual Network Name"
  type = string
  default = "myvnet"
}

variable "subnet_name" {
  description = "Virtual Network Subnet Name"
  type = string
  default = "mysubu"
}


# YOU CAN ADD LIKE THIS MANY MORE argument values from each resource
# 6. Subnet Name
# 7. Public IP Name
# 8. Network Interface Name
# 9. Virtual Machine Name
# 10. VM OS Disk Name
# 11. .....
# 12. ....


variable "public_ip_sku" {
  description = "Azure Public IP Address SKU"
  type = map(string)
  default = {
    "eastus" = "Basic",
    "eastus2" = "Standard"
  }
}

# 9. Common Tags
variable "common_tags" {
  description = "Common Tags for Azure Resources"
  type = map(string)
  default = {
    "CLITool" = "Terraform",
    "Tag1" = "Azure"
  }
}