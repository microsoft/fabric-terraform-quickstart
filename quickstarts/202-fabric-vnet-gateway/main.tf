
# Access the client configuration of the AzureRM provider.
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config
data "azurerm_client_config" "example" {}

# Create a resource group.
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "example" {
  name     = "rg-${var.solution_name}"
  location = var.location
}

# Create Azure virtual network
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
resource "azurerm_virtual_network" "example" {
  name                = "vnet-${var.solution_name}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

# Assign Network Contributor role to the Virtual Network
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
resource "azurerm_role_assignment" "example" {
  scope                = azurerm_virtual_network.example.id
  principal_id         = data.azurerm_client_config.example.object_id
  role_definition_name = "Network Contributor"
}

# Create a subnet for the virtual network with service delegation
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
resource "azurerm_subnet" "example" {
  name                 = "snet-default"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.PowerPlatform/vnetaccesslinks"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

# Get the Fabric Capacity details.
# https://registry.terraform.io/providers/microsoft/fabric/latest/docs/data-sources/capacity
data "fabric_capacity" "example" {
  display_name = var.fabric_capacity_name

  lifecycle {
    postcondition {
      condition     = self.state == "Active"
      error_message = "Fabric Capacity is not in Active state. Please check the Fabric Capacity status."
    }
  }
}

# Create a Fabric Gateway
# https://registry.terraform.io/providers/microsoft/fabric/latest/docs/resources/gateway
resource "fabric_gateway" "example" {
  type                            = "VirtualNetwork"
  display_name                    = "gw-${var.solution_name}"
  inactivity_minutes_before_sleep = 30
  number_of_member_gateways       = 1
  virtual_network_azure_resource = {
    resource_group_name  = azurerm_resource_group.example.name
    virtual_network_name = azurerm_virtual_network.example.name
    subnet_name          = azurerm_subnet.example.name
    subscription_id      = var.subscription_id
  }
  capacity_id = data.fabric_capacity.example.id

  depends_on = [
    azurerm_subnet.example,
    azurerm_role_assignment.example
  ]
}

# Get the group details
# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group
data "azuread_group" "example_admin" {
  count = var.fabric_vnet_gw_admin != null ? 1 : 0

  display_name = var.fabric_vnet_gw_admin
}

# Assign roles to the Fabric Gateway
# https://registry.terraform.io/providers/microsoft/fabric/latest/docs/resources/gateway_role_assignment
resource "fabric_gateway_role_assignment" "example_admin" {
  count = var.fabric_vnet_gw_admin != null ? 1 : 0

  gateway_id = fabric_gateway.example.id
  principal = {
    id   = data.azuread_group.example_admin[count.index].object_id
    type = "Group"
  }
  role = "Admin"
}

# Get the group details
# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group
data "azuread_group" "example_connection_creator" {
  count = var.fabric_vnet_gw_connection_creator != null ? 1 : 0

  display_name = var.fabric_vnet_gw_connection_creator
}

# Assign roles to the Fabric Gateway
# https://registry.terraform.io/providers/microsoft/fabric/latest/docs/resources/gateway_role_assignment
resource "fabric_gateway_role_assignment" "example_connection_creator" {
  count = var.fabric_vnet_gw_connection_creator != null ? 1 : 0

  gateway_id = fabric_gateway.example.id
  principal = {
    id   = data.azuread_group.example_connection_creator[count.index].object_id
    type = "Group"
  }
  role = "ConnectionCreator"
}
