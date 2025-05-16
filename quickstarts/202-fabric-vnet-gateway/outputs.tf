# Details of the Fabric Capacity
output "fabric_capacity" {
  value       = data.fabric_capacity.example
  description = "The Fabric Capacity object"
}

# Details of the Fabric Gateway
output "fabric_gateway" {
  value       = fabric_gateway.example
  description = "The Fabric Gateway object"
}
