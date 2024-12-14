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

# Create a Fabric Workspace.
# https://registry.terraform.io/providers/microsoft/fabric/latest/docs/resources/workspace
resource "fabric_workspace" "example" {
  capacity_id  = data.fabric_capacity.example.id
  display_name = "ws-${var.solution_name}"
}
