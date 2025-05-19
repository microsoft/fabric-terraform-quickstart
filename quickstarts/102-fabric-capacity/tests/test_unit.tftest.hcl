mock_provider "azurerm" {
  alias  = "fake"
  source = "../../tests/mocks/azurerm"
}

mock_provider "azuread" {
  alias  = "fake"
  source = "../../tests/mocks/azuread"
}

mock_provider "fabric" {
  alias  = "fake"
  source = "../../tests/mocks/fabric"
}

run "testunit_102-fabric-capacity" {
  providers = {
    azurerm = azurerm.fake
    azuread = azuread.fake
    fabric  = fabric.fake
  }

  variables {
    subscription_id            = "00000000-0000-0000-0000-000000000000"
    solution_name              = "test"
    location                   = "westus2"
    fabric_capacity_sku        = "F4"
    fabric_capacity_admin_upns = ["example@example.onmicrosoft.com"]
  }

  command = apply

  # Fabric Workspace
  assert {
    condition     = fabric_workspace.example.display_name == "ws-test"
    error_message = "workspace display_name was not assigned correctly"
  }

  assert {
    condition     = fabric_workspace.example.capacity_id == data.fabric_capacity.example.id
    error_message = "workspace capacity_id was not assigned correctly"
  }

  assert {
    condition     = length(fabric_workspace.example.id) != 0
    error_message = "workspace id was not assigned correctly"
  }

  # Fabric Capacity
  assert {
    condition     = data.fabric_capacity.example.display_name == "fctest"
    error_message = "capacity display_name was not assigned correctly"
  }

  assert {
    condition     = length(data.fabric_capacity.example.id) != 0
    error_message = "capacity id was not assigned correctly"
  }
}
