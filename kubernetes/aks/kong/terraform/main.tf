# Grupo de Recursos
resource "azurerm_resource_group" "rg" {
  name     = "kong-postgres-rg"
  location = "East US 2"
}
