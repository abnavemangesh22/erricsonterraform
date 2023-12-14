

resource "azurerm_resource_group" "myrg" {
  name = "${var.business_unit}-${var.environment}-${var.resource_group_name}"
  location = var.resource_group_location
}


resource "azurerm_virtual_network" "myvnet" {
  name = "${var.business_unit}-${var.environment}-${var.resource_group_name}"
  address_space = [ "192.168.1.0/24" ]
  location = var.resource_group_location
  resource_group_name = var.resource_group_name
  #location = azurerm_resource_group.myrg.location
  #resource_group_name = azurerm_resource_group.myrg.name
}

resource "azurerm_subnet" "mysubnet" {
  name = var.subnet_name
  resource_group_name = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes = [ "192.168.1.0/25" ]
}
