# The created Fabric workspace id
output "fabric_workspace_id" {
  value       = fabric_workspace.example_workspace.id
  description = "The created Fabric workspace id"
}

# The created Fabric SQL database  id
output "fabric_sql_database_id" {
  value       = fabric_sql_database.example_sql.id
  description = "The created Fabric SQL database  id"
}
