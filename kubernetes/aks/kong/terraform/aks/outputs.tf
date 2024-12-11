# output "kong_gateway_ip" {
#   value = azurerm_public_ip.kong_public_ip.ip_address
# }

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.kong_aks.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.kong_aks.kube_config_raw

  sensitive = true
}
