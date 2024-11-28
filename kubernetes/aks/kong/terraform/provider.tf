
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
}

provider "azurerm" {
  subscription_id = "7703e08d-9dff-445d-ab6b-6af170a0997e" # AJUSTE
  features {}
}
