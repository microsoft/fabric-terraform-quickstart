mock_provider "azurerm" {
  alias  = "fake"
  source = "../../tests/mocks/azurerm"

  mock_resource "azurerm_role_assignment" {
    defaults = {
      id                   = "subscriptions/00000000-0000-0000-0000-000000000000/providers/Microsoft.Authorization/roleAssignments/00000000-0000-0000-0000-000000000000"
      principal_id         = "00000000-0000-0000-0000-000000000000"
      role_definition_id   = "00000000-0000-0000-0000-000000000000"
      role_definition_name = "Network Contributor"
      scope                = "subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Network/virtualNetworks/vnet-test"
    }
  }
}

mock_provider "azuread" {
  alias  = "fake"
  source = "../../tests/mocks/azuread"
}

mock_provider "fabric" {
  alias  = "fake"
  source = "../../tests/mocks/fabric"
}

run "testunit_202-fabric-vnet-gateway" {
  providers = {
    azurerm = azurerm.fake
    azuread = azuread.fake
    fabric  = fabric.fake
  }

  variables {
    subscription_id                   = "00000000-0000-0000-0000-000000000000"
    solution_name                     = "test"
    location                          = "westus2"
    fabric_capacity_name              = "fctest"
    fabric_vnet_gw_admin              = "sg-test"
    fabric_vnet_gw_connection_creator = "sg-test"
  }

  command = apply

  # Azure Virtual Network
  assert {
    condition     = azurerm_virtual_network.example.name == "vnet-test"
    error_message = "virtual network display_name was not assigned correctly"
  }

  assert {
    condition     = length(azurerm_virtual_network.example.id) != 0
    error_message = "virtual network id was not assigned correctly"
  }

  # Fabric Gateway
  assert {
    condition     = fabric_gateway.example.display_name == "gw-test"
    error_message = "gateway display_name was not assigned correctly"
  }

  assert {
    condition     = length(fabric_gateway.example.id) != 0
    error_message = "gateway id was not assigned correctly"
  }
}
