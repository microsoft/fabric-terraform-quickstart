variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string
  sensitive   = false
  nullable    = false
}

variable "solution_name" {
  description = "Name of the solution"
  type        = string
  sensitive   = false
  nullable    = false
}

variable "location" {
  description = "Location of the Azure resources"
  type        = string
  sensitive   = false
  nullable    = false
  default     = "WestUS2"
}

variable "fabric_capacity_sku" {
  description = "Fabric Capacity SKU name"
  type        = string
  sensitive   = false
  nullable    = false
  default     = "F2"

  validation {
    condition     = contains(["F2", "F4", "F8", "F16", "F32", "F64", "F128", "F256", "F512", "F1024", "F2048"], var.fabric_capacity_sku)
    error_message = "Please specify a valid Fabric Capacity SKU. Valid values are: [ 'F2', 'F4', 'F8', 'F16', 'F32', 'F64', 'F128', 'F256', 'F512', 'F1024', 'F2048' ]."
  }
}

variable "fabric_capacity_admin_upns" {
  description = "Collection of admin UPNs for the Fabric Capacity."
  type        = set(string)
  sensitive   = false
  nullable    = false
  default     = []
}
