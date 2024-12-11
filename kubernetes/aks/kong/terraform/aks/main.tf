provider "azurerm" {
  subscription_id = var.subscription_id
  features {
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "kong-resource-group"
  location = var.location
}
