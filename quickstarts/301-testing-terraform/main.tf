resource "fabric_workspace" "example" {
  display_name = var.workspace_name
  description  = var.workspace_description
}

resource "fabric_workspace_role_assignment" "example" {
  workspace_id = fabric_workspace.example.id
  principal    = var.principal
  role         = "Admin"
}
