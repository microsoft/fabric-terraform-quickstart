# Access the client configuration of the AzureRM provider.
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config
data "azurerm_client_config" "example" {}

# Gets information about Entra user.
# https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user
data "azuread_user" "example" {
  object_id = data.azurerm_client_config.example.object_id
}

# Create a resource group.
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "example" {
  name     = "rg-${var.name}"
  location = var.location
}

# Create a Fabric Capacity.
# https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/azapi_resource
resource "azapi_resource" "fabric_capacity_example" {
  type                      = "Microsoft.Fabric/capacities@2023-11-01"
  name                      = "fc${var.name}"
  parent_id                 = azurerm_resource_group.example.id
  location                  = var.location
  schema_validation_enabled = false

  body = {
    sku = {
      name = var.fabric_capacity_sku
      tier = "Fabric"
    }
    properties = {
      administration = {
        members = [
          data.azuread_user.example.user_principal_name
        ]
      }
    }
  }
}

# Get the Fabric Capacity details.
# https://registry.terraform.io/providers/microsoft/fabric/latest/docs/data-sources/capacity
data "fabric_capacity" "example" {
  display_name = azapi_resource.fabric_capacity_example.name
}

# Create a Fabric Workspace.
# https://registry.terraform.io/providers/microsoft/fabric/latest/docs/resources/workspace
resource "fabric_workspace" "example" {
  capacity_id  = data.fabric_capacity.example.id
  display_name = "ws-${var.name}"
}
