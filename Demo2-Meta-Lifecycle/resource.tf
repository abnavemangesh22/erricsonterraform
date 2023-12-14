
# resource group
/*
resource "azurerm_resource_group" "mygr" {
for_each = {
  dc1apps = "eastus"
  dc2apps = "westus"
  dc3apps = "eastus2"
}
  location = each.value
  name     = "${each.key}-rg"
  #provider = azurerm.infrawestus

}
*/


resource "azurerm_resource_group" "mygr" {
for_each = toset(["eastus", "eastus2", "westus"])
  location = each.value
  name     = "${each.key}-rg"
}


/*
# network Desired state of infra
resource "azurerm_virtual_network" "mynetwork" {
  name                = "erricson-network-3"
  address_space       = ["192.168.1.0/24"]
  location            = azurerm_resource_group.mygr.location
  resource_group_name = azurerm_resource_group.mygr.name
  tags = {
    envinoment = "prepod"
    project = "crbt"
  }
  }
*/