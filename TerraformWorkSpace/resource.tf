

resource "azurerm_resource_group" "myrg" {
  name = "${var.business_unit}-${var.environment}-${var.resource_group_name}"
  location = var.resource_group_location
  tags = {
    env = "prod"
  }
}


resource "azurerm_virtual_network" "myvnet" {
  name = "${var.business_unit}-${var.environment}-${var.resource_group_name}"
  address_space = [ "192.168.1.0/24" ]
  location = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  #location = azurerm_resource_group.myrg.location
  #resource_group_name = azurerm_resource_group.myrg.name
  tags = {
    env = "prod"
  }
}

resource "azurerm_subnet" "mysubnet" {
  name = var.subnet_name
  resource_group_name = azurerm_resource_group.myrg.name
  virtual_network_name = azurerm_virtual_network.myvnet.name
  address_prefixes = [ "192.168.1.0/25" ]
}
