# Resource-1: Azure Resource Group
resource "azurerm_resource_group" "myrg" {
  name = local.rg_name
  #name = "${var.business_unit}-${var.environment}-${var.resoure_group_name}"
  location = var.resoure_group_location
  tags     = local.common_tags
}

# Create Virtual Network
resource "azurerm_virtual_network" "myvnet" {
  name = local.net_name
  #name                = "${var.business_unit}-${var.environment}-${var.virtual_network_name}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  tags                = local.common_tags
}