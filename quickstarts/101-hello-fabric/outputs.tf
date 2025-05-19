output "workspace" {
  value       = resource.fabric_workspace.example
  description = "The Fabric workspace object"
}

output "workspace_id" {
  value       = resource.fabric_workspace.example.id
  description = "The Fabric workspace ID"
}
