# Copyright (c) Microsoft Corporation
# SPDX-License-Identifier: MPL-2.0

variable "solution_name" {
  description = "Name of the solution for resource naming"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]{3,24}$", var.solution_name))
    error_message = "Solution name must be 3-24 characters long and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "location" {
  description = "Azure region for resource deployment"
  type        = string
  default     = "West US 2"
}

variable "environment" {
  description = "Environment name (dev, test, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, test, staging, prod."
  }
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "fabric_capacity_name" {
  description = "Name of the existing Fabric Capacity to monitor"
  type        = string
}

variable "fabric_workspace_name" {
  description = "Name of the existing Fabric Workspace to monitor"
  type        = string
  default     = null
}

variable "alert_email_addresses" {
  description = "List of email addresses to receive monitoring alerts"
  type        = list(string)
  default     = []

  validation {
    condition = alltrue([
      for email in var.alert_email_addresses : can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", email))
    ])
    error_message = "All email addresses must be valid email format."
  }
}

variable "alert_webhook_urls" {
  description = "List of webhook URLs for alert notifications (Teams, Slack, etc.)"
  type        = list(string)
  default     = []
}

variable "log_retention_days" {
  description = "Number of days to retain logs in Log Analytics workspace"
  type        = number
  default     = 30

  validation {
    condition     = var.log_retention_days >= 30 && var.log_retention_days <= 730
    error_message = "Log retention must be between 30 and 730 days."
  }
}

# Alert threshold configurations
variable "cpu_threshold" {
  description = "CPU utilization threshold percentage for alerts"
  type        = number
  default     = 80

  validation {
    condition     = var.cpu_threshold > 0 && var.cpu_threshold <= 100
    error_message = "CPU threshold must be between 1 and 100."
  }
}

variable "memory_threshold" {
  description = "Memory utilization threshold percentage for alerts"
  type        = number
  default     = 85

  validation {
    condition     = var.memory_threshold > 0 && var.memory_threshold <= 100
    error_message = "Memory threshold must be between 1 and 100."
  }
}

variable "storage_threshold" {
  description = "Storage utilization threshold percentage for alerts"
  type        = number
  default     = 90

  validation {
    condition     = var.storage_threshold > 0 && var.storage_threshold <= 100
    error_message = "Storage threshold must be between 1 and 100."
  }
}

variable "alert_frequency" {
  description = "How often to evaluate alert conditions (in minutes)"
  type        = number
  default     = 5

  validation {
    condition     = contains([1, 5, 10, 15, 30, 60], var.alert_frequency)
    error_message = "Alert frequency must be one of: 1, 5, 10, 15, 30, 60 minutes."
  }
}

variable "enable_dashboard" {
  description = "Whether to create Azure Dashboard for monitoring"
  type        = bool
  default     = true
}

variable "enable_application_insights" {
  description = "Whether to create Application Insights for advanced monitoring"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}
