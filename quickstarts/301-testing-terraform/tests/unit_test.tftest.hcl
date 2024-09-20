run "test_workspace" {

  variables {
    workspace_name        = "test-workspace"
    workspace_description = "test-workspace-description"
    principal_id          = "96ce09da-4aab-46b5-b8ac-529f35944c83"
  }

  command = apply

  assert {
    condition     = fabric_workspace.example.display_name == "test-workspace"
    error_message = "workspace display_name was not assigned correctly"
  }

  assert {
    condition     = fabric_workspace.example.description == "test-workspace-description"
    error_message = "workspace description was not assigned correctly"
  }

  assert {
    condition     = fabric_workspace_role_assignment.example.workspace_id == fabric_workspace.example.id
    error_message = "workspace role was not assigned correctly"
  }
}
