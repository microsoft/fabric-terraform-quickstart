# Access the client configuration of the AzureRM provider.
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config
data "azurerm_client_config" "example" {}

# Check the directory object type.
# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/directory_object
data "azuread_directory_object" "example" {
  object_id = data.azurerm_client_config.example.object_id
}

# Get information about Entra user.
# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user
data "azuread_user" "example" {
  object_id = data.azurerm_client_config.example.object_id
}

locals {
  # Check if the client is a user or not, if it is a user then use the user principal name otherwise use the object id for service principal.
  fabric_admin = can(data.azuread_directory_object.example.type == "User") ? data.azuread_user.example.user_principal_name : data.azurerm_client_config.example.object_id
}

# Create a resource group.
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "example" {
  name     = "rg-${var.solution_name}"
  location = var.location
}

# Create a Fabric Capacity.
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/fabric_capacity
resource "azurerm_fabric_capacity" "example" {
  name                = "fc${var.solution_name}"
  resource_group_name = azurerm_resource_group.example.name
  location            = var.location

  administration_members = setunion([local.fabric_admin], var.fabric_capacity_admin_upns)

  sku {
    name = var.fabric_capacity_sku
    tier = "Fabric"
  }
}

# Get the Fabric Capacity details.
# https://registry.terraform.io/providers/microsoft/fabric/latest/docs/data-sources/capacity
data "fabric_capacity" "example" {
  display_name = azurerm_fabric_capacity.example.name

  lifecycle {
    postcondition {
      condition     = self.state == "Active"
      error_message = "Fabric Capacity is not in Active state. Please check the Fabric Capacity status."
    }
  }
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

# Assign a role to the Fabric Gateway
# https://registry.terraform.io/providers/microsoft/fabric/latest/docs/resources/gateway_role_assignment
resource "fabric_gateway_role_assignment" "example" {
  gateway_id = fabric_gateway.example.id
  principal = {
    id   = data.azurerm_client_config.example.object_id
    type = data.azuread_directory_object.example.type
  }
  role = "Admin"
}
