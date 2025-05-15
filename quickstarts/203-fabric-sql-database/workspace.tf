data "fabric_capacity" "capacity" {
  display_name = var.fabric_capacity_name
}

resource "fabric_workspace" "example_workspace" {
  display_name = var.fabric_workspace_name
  description = "Getting started workspace"
  capacity_id = data.fabric_capacity.capacity.id
}
