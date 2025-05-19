output "fabric_gateway" {
  value       = fabric_gateway.example
  description = "The Fabric Gateway object"
}

output "azurerm_virtual_network" {
  value       = azurerm_virtual_network.example
  description = "The Azure Virtual Network object"
}

output "azurerm_subnet" {
  value       = azurerm_subnet.example
  description = "The Azure VNet Subnet object"
}
