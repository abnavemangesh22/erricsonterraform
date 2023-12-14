# Resource-1: Azure Resource Group
resource "azurerm_resource_group" "myrg" {
  #name = var.resource_group_name
  name     = "${var.business_unit}-${var.environment}-${var.resoure_group_name}"
  location = var.resoure_group_location
}

# Create Virtual Network
resource "azurerm_virtual_network" "myvnet" {
  name = "${var.business_unit}-${var.environment}-${var.virtual_network_name}"
  address_space      = ["10.0.0.0/16"]
  #address_space       = var.virtual_network_address_space
  #address_space       = [var.virtual_network_address_space[0]]
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
}
