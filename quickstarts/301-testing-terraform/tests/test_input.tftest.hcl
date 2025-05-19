run "valid_workspace_display_name" {
  variables {
    workspace_name = "test_workspace"
    principal = {
      id   = "00000000-0000-0000-0000-000000000000"
      type = "User"
    }
  }

  command = plan

  assert {
    condition     = fabric_workspace.example.display_name == "test_workspace"
    error_message = "workspace display name did not match expected"
  }

}

run "invalid_workspace_role_assignment_principal" {
  variables {
    principal = {
      id   = "test"
      type = "User"
    }
  }

  command = plan

  expect_failures = [var.principal.id]
}

run "valid_default_workspace_role_assignment_principal" {
  variables {
    principal = {
      id   = "00000000-0000-0000-0000-000000000000"
      type = "ServicePrincipal"
    }
  }

  command = plan

  assert {
    condition     = fabric_workspace_role_assignment.example.principal.id == "00000000-0000-0000-0000-000000000000"
    error_message = "invalid workspace role assignment principal_id"
  }
}
