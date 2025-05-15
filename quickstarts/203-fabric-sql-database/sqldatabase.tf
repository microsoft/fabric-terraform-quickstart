resource "fabric_sql_database" "example_sql" {
  workspace_id = fabric_workspace.example_workspace.id
  display_name = var.fabric_sql_database_name
}
