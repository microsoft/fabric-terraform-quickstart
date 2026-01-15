terraform {
  required_version = ">= 1.11, < 2.0"
  required_providers {
    # https://registry.terraform.io/providers/hashicorp/random/latest
    random = {
      source  = "hashicorp/random"
      version = "3.8.0"
    }
  }
}

resource "random_string" "this" {
  keepers = {
    first = timestamp()
  }
  length  = var.length
  special = false
  numeric = false
}

resource "random_uuid" "this" {
  keepers = {
    first = timestamp()
  }
}

resource "random_password" "this" {
  keepers = {
    first = timestamp()
  }
  length           = var.length
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

