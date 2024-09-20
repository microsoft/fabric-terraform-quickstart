variable "name" {
  description = "Name of the solution"
  type        = string
}

variable "location" {
  description = "Location of the Azure resources"
  type        = string
  default     = "WestUS3"
}

variable "fabric_capacity_sku" {
  description = "Fabric Capacity SKU name"
  type        = string
  default     = "F2"
}

variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string
}
