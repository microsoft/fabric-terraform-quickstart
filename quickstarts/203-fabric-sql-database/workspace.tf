data "fabric_capacity" "capacity" {
  display_name = var.fabric_capacity_name
}

resource "fabric_workspace" "example_workspace" {
  display_name = var.fabric_workspace_name
  description = "Getting started workspace"
  capacity_id = data.fabric_capacity.capacity.id
}

# by default, the new workspace has only Service Priincile as admin, the user cannot view it on fabric portal
# by adding user as a member, the user can view it on portal
# principal_id is the user account object id
resource "fabric_workspace_role_assignment" "example_workspace_role_assignment" {
  workspace_id = fabric_workspace.example_workspace.id
  principal_id   = var.user_principal_id
  principal_type = "User"
  role           = "Admin"
}
