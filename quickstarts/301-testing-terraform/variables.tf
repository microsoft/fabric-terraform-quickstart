variable "workspace_name" {
  description = "Name of the Workspace"
  type        = string
  default     = "test_workspace"
}

variable "workspace_description" {
  description = "Description of the Workspace"
  type        = string
  default     = "test_description"
}

variable "principal" {
  description = "Workspace role assignment Principal ID"
  type = object({
    id   = string
    type = string
  })
  validation {
    condition     = can(regex("^[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$", var.principal.id))
    error_message = "Please specify a valid principal ID."
  }

  validation {
    condition     = contains(["User", "Group", "ServicePrincipal"], var.principal.type)
    error_message = "Please specify a valid principal type."
  }
}
