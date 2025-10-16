terraform {
  required_version = ">= 1.8, < 2.0"
  required_providers {
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.49.0"
    }
    # https://registry.terraform.io/providers/hashicorp/azuread/latest
    azuread = {
      source  = "hashicorp/azuread"
      version = "3.6.0"
    }
    # https://registry.terraform.io/providers/microsoft/fabric/latest
    fabric = {
      source  = "microsoft/fabric"
      version = "1.6.0"
    }
  }
}

provider "azurerm" {
  features {}
  # Configuration options
  subscription_id = var.subscription_id
}

provider "fabric" {
  # Configuration options
  preview = true
}
