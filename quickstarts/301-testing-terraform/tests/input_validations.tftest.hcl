run "valid_workspace_display_name" {

  command = plan

  variables {
    workspace_name = "test_workspace"
  }

  assert {
    condition     = fabric_workspace.example.display_name == "test_workspace"
    error_message = "workspace display name did not match expected"
  }

}

run "invalid_workspace_role_assignment_principal" {

  variables {
    principal_id = "test_workspace"
  }

  command         = plan
  expect_failures = [var.principal_id]
}

run "valid_default_workspace_role_assignment_principal" {

  command = plan

  assert {
    condition     = fabric_workspace_role_assignment.example.principal_id == "96ce09da-4aab-46b5-b8ac-529f35944c83"
    error_message = "invalid workspace role assignment principal_id"
  }
}
