# We strongly recommend using the required_providers block to set the Fabric Provider source and version being used
terraform {
  required_version = ">= 1.8, < 2.0"
  required_providers {
    fabric = {
      source  = "microsoft/fabric"
      version = "0.1.0-beta.10"
    }
  }
}

# Configure the Microsoft Fabric Terraform Provider
provider "fabric" {
  # Configuration options
  preview = true                     # Farbic SQL database is in preview state.

  tenant_id                    = var.tenant_id
  client_id                    = var.client_id
  client_certificate_file_path = var.client_certificate_file_path
  client_certificate_password  = var.client_certificate_password
}
