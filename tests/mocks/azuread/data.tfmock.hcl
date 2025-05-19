mock_data "azuread_directory_object" {
  defaults = {
    id        = "/directoryObjects/00000000-0000-0000-0000-000000000000"
    object_id = "00000000-0000-0000-0000-000000000000"
    type      = "User"
  }
}

mock_data "azuread_user" {
  defaults = {
    id                  = "/users/00000000-0000-0000-0000-000000000000"
    object_id           = "00000000-0000-0000-0000-000000000000"
    display_name        = "Test User"
    mail_nickname       = "User"
    user_principal_name = "User@example.onmicrosoft.com"
    user_type           = "Member"
    preferred_language  = "en-US"
    usage_location      = "US"
    account_enabled     = true
  }
}

mock_data "azuread_group" {
  defaults = {
    id               = "/groups/00000000-0000-0000-0000-000000000000"
    description      = ""
    display_name     = "Test Security Group"
    object_id        = "00000000-0000-0000-0000-000000000000"
    mail_nickname    = "sg-test"
    security_enabled = true
    mail_enabled     = false
  }
}
