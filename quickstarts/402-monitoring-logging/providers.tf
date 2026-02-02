# Copyright (c) Microsoft Corporation
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_version = ">= 1.8, < 2.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.58.0"
    }
    fabric = {
      source  = "microsoft/fabric"
      version = "1.7.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    log_analytics_workspace {
      permanently_delete_on_destroy = true
    }
    application_insights {
      disable_generated_rule = false
    }
  }
}

provider "fabric" {
  # Configuration will be provided via environment variables or Azure CLI
}
