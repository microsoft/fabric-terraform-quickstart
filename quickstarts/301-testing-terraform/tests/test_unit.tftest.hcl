mock_provider "fabric" {
  alias = "fake"

  mock_resource "fabric_workspace" {
    defaults = {
      id              = "00000000-0000-0000-0000-000000000000"
      display_name    = "ws-test"
      capacity_id     = "00000000-0000-0000-0000-000000000000"
      capacity_region = "westus2"
      description     = "ws-test-description"
      identity        = null
    }
  }

  mock_resource "fabric_workspace_role_assignment" {
    defaults = {
      id           = "00000000-0000-0000-0000-000000000000"
      workspace_id = "00000000-0000-0000-0000-000000000000"
      principal = {
        id   = "00000000-0000-0000-0000-000000000000"
        type = "User"
      }
      role = "Admin"
    }
  }
}

run "testunit_301-testing-terraform" {
  providers = {
    fabric = fabric.fake
  }

  variables {
    workspace_name        = "ws-test"
    workspace_description = "ws-test-description"
    principal = {
      id   = "00000000-0000-0000-0000-000000000000"
      type = "User"
    }
  }

  command = apply

  assert {
    condition     = fabric_workspace.example.display_name == "ws-test"
    error_message = "workspace display_name was not assigned correctly"
  }

  assert {
    condition     = fabric_workspace.example.description == "ws-test-description"
    error_message = "workspace description was not assigned correctly"
  }

  assert {
    condition     = fabric_workspace_role_assignment.example.workspace_id == fabric_workspace.example.id
    error_message = "workspace role was not assigned correctly"
  }
}
