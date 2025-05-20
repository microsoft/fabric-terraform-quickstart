mock_resource "fabric_workspace" {
  defaults = {
    id              = "00000000-0000-0000-0000-000000000000"
    display_name    = "ws-test"
    capacity_id     = "00000000-0000-0000-0000-000000000000"
    capacity_region = "westus2"
    description     = ""
    identity        = null
  }
}

mock_resource "fabric_gateway" {
  defaults = {
    capacity_id                     = "00000000-0000-0000-0000-000000000000"
    display_name                    = "gw-test"
    id                              = "00000000-0000-0000-0000-000000000000"
    inactivity_minutes_before_sleep = 30
    number_of_member_gateways       = 1
    type                            = "VirtualNetwork"
    virtual_network_azure_resource = {
      resource_group_name  = "rg-test"
      virtual_network_name = "vnet-test"
      subnet_name          = "subnet-test"
      subscription_id      = "00000000-0000-0000-0000-000000000000"
    }
  }
}

mock_resource "fabric_gateway_role_assignment" {
  defaults = {
    id         = "00000000-0000-0000-0000-000000000000"
    gateway_id = "00000000-0000-0000-0000-000000000000"
    principal = {
      id   = "00000000-0000-0000-0000-000000000000"
      type = "Group"
    }
    role = "Admin"
  }
}
