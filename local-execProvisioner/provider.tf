provider "azurerm" {
  features {
  }
  subscription_id = "741f607e-5ee2-420c-a1f4-3fc69ee59cba"
}


provider "azurerm" {
  features {
    virtual_machine {
      delete_os_disk_on_deletion = false
    }
  }
  alias = "infrawestus"
}
