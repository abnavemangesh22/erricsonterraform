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
    null = {
      source  = "hashicorp/null"
      version = "3.2.2"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.10.0"
    }


  }
}




# version constraint concept is application for provider version as well as client version.
# to avoid the version conflicts.

