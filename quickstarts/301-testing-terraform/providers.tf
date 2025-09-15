terraform {
  required_version = ">= 1.8, < 2.0"
  required_providers {
    fabric = {
      source  = "microsoft/fabric"
      version = "1.6.0"
    }
  }
}

provider "fabric" {}
