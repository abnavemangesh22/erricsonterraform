

data "azurerm_resource_group" "rgds" {
  name = azurerm_resource_group.myrg.name
}


output "name_of_rg" {
  value = data.azurerm_resource_group.rgds.name
}

output "location_of_rg" {
  value = data.azurerm_resource_group.rgds.location
}

output "id_of_rg" {
  value = data.azurerm_resource_group.rgds.id
}


data "azurerm_subscription" "current" {
}

output "spending_limit" {
  value = data.azurerm_subscription.current.spending_limit
}

output "subscription_id_current" {
  value = data.azurerm_subscription.current.id
}

