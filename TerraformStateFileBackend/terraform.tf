terraform {
  required_version = "1.6.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.84.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "mystatfile-grp"
    storage_account_name = "terraformstate2021"
    container_name = "tfstatefiles"
    key = "terraform.tfstate"
  }
}




# version constraint concept is application for provider version as well as client version.
# to avoid the version conflicts.

