# Details of the Fabric Capacity
output "fabric_capacity" {
  value       = data.fabric_capacity.example
  description = "The Fabric Capacity object"
}

# Details of the Fabric Workspace
output "fabric_workspace" {
  value       = fabric_workspace.example
  description = "The Fabric Workspace object"
}
