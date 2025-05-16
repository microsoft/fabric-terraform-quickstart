# The existing capacity name.
data "fabric_capacity" "capacity" {
  display_name = var.fabric_capacity_name
}

# Create fabric workspace.
resource "fabric_workspace" "example_workspace" {
  display_name = var.fabric_workspace_name
  description = "Getting started workspace"
  capacity_id = data.fabric_capacity.capacity.id
}

# Create fabric SQL Database.
resource "fabric_sql_database" "example_sql" {
  workspace_id = fabric_workspace.example_workspace.id
  display_name = var.fabric_sql_database_name
}
