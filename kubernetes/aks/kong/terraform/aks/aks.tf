resource "azurerm_kubernetes_cluster" "kong_aks" {
  name                = "kong-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "kong-aks"

  default_node_pool {
    name           = "default"
    node_count     = 1
    vm_size        = "Standard_DS2_v2"
    vnet_subnet_id = azurerm_subnet.aks_subnet.id
  }

  identity {
    type = "SystemAssigned"
  }

  node_resource_group = "kong-node-resource-group"

  tags = {
    Environment = "development"
  }
}
