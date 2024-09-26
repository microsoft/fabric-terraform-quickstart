terraform {
  required_version = ">= 1.8, < 2.0"
  required_providers {
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.3.0"
    }
    # https://registry.terraform.io/providers/Azure/azapi/latest
    azapi = {
      source  = "Azure/azapi"
      version = "1.15.0"
    }
    # https://registry.terraform.io/providers/hashicorp/azuread/latest
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.53.1"
    }
    # https://registry.terraform.io/providers/microsoft/fabric/latest
    fabric = {
      source  = "microsoft/fabric"
      version = "0.1.0-beta.3"
    }
  }
}

provider "azurerm" {
  features {}
  # Configuration options

  subscription_id = var.subscription_id
}

provider "azapi" {
  # Configuration options

  subscription_id = var.subscription_id
}

provider "azuread" {
  # Configuration options
}

provider "fabric" {
  # Configuration options
}
