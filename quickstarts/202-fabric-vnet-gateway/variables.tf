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

variable "fabric_capacity_name" {
  description = "Existing Fabric Capacity name"
  type        = string
  sensitive   = false
  nullable    = false
}

variable "fabric_vnet_gw_admin" {
  description = "Entra Group name for Fabric VNet Gateway admins"
  type        = string
  sensitive   = false
  default     = null
}

variable "fabric_vnet_gw_connection_creator" {
  description = "Entra Group name for Fabric VNet Gateway connection creators"
  type        = string
  sensitive   = false
  default     = null
}
