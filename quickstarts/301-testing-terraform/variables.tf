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

variable "principal_id" {
  description = "Workspace role assignment Principal ID"
  type        = string
  default     = "96ce09da-4aab-46b5-b8ac-529f35944c83"
  validation {
    condition     = can(regex("^[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$", var.principal_id))
    error_message = "invalid workspace role assignment principal_id format"
  }
}
