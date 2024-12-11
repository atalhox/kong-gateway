# Criar uma Virtual Network (VNet)
resource "azurerm_virtual_network" "vnet" {
  name                = "kong-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

# Criar uma SubNet para o AKS
resource "azurerm_subnet" "aks_subnet" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# resource "azurerm_network_security_group" "nsg" {
#   name                = "kong-nsg"
#   location            = var.location
#   resource_group_name = azurerm_resource_group.rg.name

#   #   security_rule {
#   #     name                       = "Allow-HTTP"
#   #     priority                   = 1000
#   #     direction                  = "Inbound" 
#   #     access                     = "Allow"
#   #     protocol                   = "Tcp"
#   #     source_port_range          = "*"
#   #     destination_port_range     = "80"
#   #     source_address_prefix      = "*"
#   #     destination_address_prefix = "*"
#   #   }

#   security_rule {
#     name                       = "Allow-HTTPS"
#     priority                   = 1001
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "443"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
# }
