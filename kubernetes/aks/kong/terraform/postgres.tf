# Gerar senha aleatória
resource "random_password" "postgres_admin_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# Rede Virtual
resource "azurerm_virtual_network" "vnet" {
  name                = "kong-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location # Certifique-se de que o resource group já está definido
  resource_group_name = azurerm_resource_group.rg.name
}

# Sub-rede para PostgreSQL
resource "azurerm_subnet" "kong_postgres_subnet" {
  name                 = "postgres-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  # Delegação de sub-rede para servidor flexível PostgreSQL
  delegation {
    name = "postgres-delegation"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
    }
  }
}

# Zona DNS Privada para resolução de nome interno
resource "azurerm_private_dns_zone" "postgres_dns" {
  name                = "kong-postgres.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.rg.name
}

# Associação da Zona DNS Privada com a Rede Virtual
resource "azurerm_private_dns_zone_virtual_network_link" "postgres_dns_link" {
  name                  = "postgres-dns-link"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.postgres_dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

# Servidor Flexível PostgreSQL
resource "azurerm_postgresql_flexible_server" "postgres" {
  name                = "kong-postgres-server"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  # Credenciais de administrador
  administrator_login    = "pgadmin"
  administrator_password = random_password.postgres_admin_password.result

  # Configurações de rede
  delegated_subnet_id = azurerm_subnet.kong_postgres_subnet.id
  private_dns_zone_id = azurerm_private_dns_zone.postgres_dns.id

  # Configurações de SKU 
  # Ajuste conforme necessidade de performance
  sku_name = "B_Standard_B1ms" # Tier básico, ajuste conforme necessidade

  # Configurações de versão e backup
  version               = "13"
  backup_retention_days = 7

  # Configurações de alta disponibilidade - Não disponível para Burstable
  #   high_availability {
  #     mode = "ZoneRedundant"
  #   }

  # Storage
  storage_mb = 32768 # 32 GB, ajuste conforme necessidade
}

# Banco de dados para Kong
resource "azurerm_postgresql_flexible_server_database" "kong_db" {
  name      = "kongdb"
  server_id = azurerm_postgresql_flexible_server.postgres.id
  charset   = "UTF8"
  collation = "en_US.utf8"
}

# Firewall para acesso de serviços do Azure
resource "azurerm_postgresql_flexible_server_firewall_rule" "azure_services" {
  name             = "allow-azure-services"
  server_id        = azurerm_postgresql_flexible_server.postgres.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

# Outputs
output "kong_db_name" {
  description = "Nome do banco de dados PostgreSQL"
  value       = azurerm_postgresql_flexible_server_database.kong_db.name
}

output "postgres_server_address" {
  description = "Endereço de acesso do servidor PostgreSQL"
  value       = azurerm_postgresql_flexible_server.postgres.fqdn
}

output "postgres_connection_string" {
  description = "URL de conexão do PostgreSQL"
  value       = "postgres://${azurerm_postgresql_flexible_server.postgres.administrator_login}:${random_password.postgres_admin_password.result}@${azurerm_postgresql_flexible_server.postgres.fqdn}/${azurerm_postgresql_flexible_server_database.kong_db.name}?sslmode=require"
  sensitive   = true
}
