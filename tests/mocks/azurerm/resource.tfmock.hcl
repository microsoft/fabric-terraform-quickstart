mock_resource "azurerm_resource_group" {
  defaults = {
    id         = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test"
    name       = "rg-test"
    location   = "westus2"
    tags       = null
    managed_by = null
  }
}

mock_resource "azurerm_fabric_capacity" {
  defaults = {
    id       = "subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Fabric/capacities/fctest"
    location = "westus2"
    administration_members = [
      "User@example.onmicrosoft.com",
      "example@example.onmicrosoft.com",
    ]
    name                = "fctest"
    resource_group_name = "rg-test"
    sku = [{
      name = "F4"
      tier = "Fabric"
    }]
    tags = null
  }
}

mock_resource "azurerm_virtual_network" {
  defaults = {
    id                             = "subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Network/virtualNetworks/vnet-test"
    location                       = "westus2"
    name                           = "vnet-test"
    resource_group_name            = "rg-test"
    private_endpoint_vnet_policies = "Disabled"
    address_space = [
      "10.0.0.0/16",
    ]
  }
}

mock_resource "azurerm_subnet" {
  defaults = {
    id = "subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Network/virtualNetworks/vnet-test/subnets/snet-default"
    address_prefixes = [
      "10.0.1.0/24",
    ]
    name                                          = "snet-default"
    private_endpoint_network_policies             = "Disabled"
    private_link_service_network_policies_enabled = true
    resource_group_name                           = "rg-test"
    virtual_network_name                          = "vnet-test"
    delegation = [
      {
        name = "delegation"
        service_delegation = [
          {
            actions = [
              "Microsoft.Network/virtualNetworks/subnets/join/action",
            ]
            name = "Microsoft.PowerPlatform/vnetaccesslinks"
          },
        ]
      },
    ]
  }
}

mock_resource "azurerm_network_security_group" {
  defaults = {
    id                  = "subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Network/networkSecurityGroups/nsg-default"
    location            = "westus2"
    name                = "nsg-default"
    resource_group_name = "rg-test"
  }
}

mock_resource "azurerm_subnet_network_security_group_association" {
  defaults = {
    id                        = "subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Network/virtualNetworks/vnet-test/subnets/snet-default/providers/Microsoft.Network/networkSecurityGroups/nsg-default"
    subnet_id                 = "subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Network/virtualNetworks/vnet-test/subnets/snet-default"
    network_security_group_id = "subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Network/networkSecurityGroups/nsg-default"
  }
}
