# output "client_key" {
#     value = azurerm_kubernetes_cluster.k8s.kube_config.0.client_key
# }

# output "client_certificate" {
#     value = azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate
# }

# output "cluster_ca_certificate" {
#     value = azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate
# }

# output "cluster_username" {
#     value = azurerm_kubernetes_cluster.k8s.kube_config.0.username
# }

# output "cluster_password" {
#     value = azurerm_kubernetes_cluster.k8s.kube_config.0.password
# }

output "kube_config" {
    value = azurerm_kubernetes_cluster.aks.kube_config_raw
    sensitive   = true
}

# output "host" {
#     value = azurerm_kubernetes_cluster.k8s.kube_config.0.host
# }

# output "pip-vm-elastic" {
#     value = azurerm_public_ip.pip-elastic.ip_address
# }

output "kube_id" {
    value = azurerm_kubernetes_cluster.aks.kubelet_identity
}

output "kube_identity_name" {
    value = azurerm_user_assigned_identity.id_aks.name
}
output "kube_identity_id" {
    value = azurerm_user_assigned_identity.id_aks.id
}
output "kube_identity_principal_id" {
    value = azurerm_user_assigned_identity.id_aks.principal_id
}
output "kube_identity_new" {
    value = azurerm_user_assigned_identity.id_aks.client_id
  
}