mock_provider "fabric" {
  alias  = "fake"
  source = "../../tests/mocks/fabric"
}

run "testunit_101-hello-fabric" {
  providers = {
    fabric = fabric.fake
  }

  variables {
    workspace_name = "ws-test"
  }

  command = apply

  assert {
    condition     = fabric_workspace.example.display_name == "ws-test"
    error_message = "workspace display_name was not assigned correctly"
  }

  assert {
    condition     = length(fabric_workspace.example.id) != 0
    error_message = "workspace id was not assigned correctly"
  }
}
