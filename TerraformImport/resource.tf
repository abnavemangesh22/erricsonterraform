
# make sure import command should work only with powershell not with bash

resource "azurerm_resource_group" "mygrp01" {
  name = "myimport"
  location = "eastus"
  tags = {
    mydata = "test"
  }
}