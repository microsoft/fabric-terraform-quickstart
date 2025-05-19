run "random" {
  module {
    source = "../../tests/random_generator"
  }
}

provider "fabric" {}

run "testacc_101-hello-fabric" {
  providers = {
    fabric = fabric
  }

  variables {
    workspace_name = "ws-${run.random.string}"
  }

  command = apply

  assert {
    condition     = fabric_workspace.example.display_name == "ws-${run.random.string}"
    error_message = "workspace display_name was not assigned correctly"
  }

  assert {
    condition     = length(fabric_workspace.example.id) != 0
    error_message = "workspace id was not assigned correctly"
  }
}
