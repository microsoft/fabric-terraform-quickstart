# Copyright (c) Microsoft Corporation
# SPDX-License-Identifier: MPL-2.0

# Local values for resource naming and tagging
locals {
  # Resource naming convention
  resource_prefix = "fabric-monitoring-${var.solution_name}"

  # Common tags applied to all resources
  common_tags = merge(var.tags, {
    Environment = var.environment
    Purpose     = "Fabric-Monitoring"
    Solution    = var.solution_name
    ManagedBy   = "Terraform"
    CreatedDate = formatdate("YYYY-MM-DD", timestamp())
  })
}

# Data sources to get existing Fabric resources
data "fabric_capacity" "monitored_capacity" {
  display_name = var.fabric_capacity_name
}

data "fabric_workspace" "monitored_workspace" {
  count        = var.fabric_workspace_name != null ? 1 : 0
  display_name = var.fabric_workspace_name
}

# Resource Group for monitoring resources
resource "azurerm_resource_group" "monitoring" {
  name     = "rg-${local.resource_prefix}"
  location = var.location
  tags     = local.common_tags
}

# Log Analytics Workspace for centralized logging
resource "azurerm_log_analytics_workspace" "fabric_logs" {
  name                = "law-${var.solution_name}"
  location            = azurerm_resource_group.monitoring.location
  resource_group_name = azurerm_resource_group.monitoring.name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_retention_days

  tags = local.common_tags
}

# Application Insights for advanced monitoring and analytics
resource "azurerm_application_insights" "fabric_insights" {
  count               = var.enable_application_insights ? 1 : 0
  name                = "ai-${var.solution_name}"
  location            = azurerm_resource_group.monitoring.location
  resource_group_name = azurerm_resource_group.monitoring.name
  workspace_id        = azurerm_log_analytics_workspace.fabric_logs.id
  application_type    = "web"

  tags = local.common_tags
}

# Action Group for alert notifications
resource "azurerm_monitor_action_group" "fabric_alerts" {
  name                = "ag-${var.solution_name}"
  resource_group_name = azurerm_resource_group.monitoring.name
  short_name          = "FabricAlert"

  # Email receivers
  dynamic "email_receiver" {
    for_each = var.alert_email_addresses
    content {
      name          = "email-${email_receiver.key}"
      email_address = email_receiver.value
    }
  }

  # Webhook receivers for Teams, Slack, etc.
  dynamic "webhook_receiver" {
    for_each = var.alert_webhook_urls
    content {
      name        = "webhook-${webhook_receiver.key}"
      service_uri = webhook_receiver.value
    }
  }

  tags = local.common_tags
}

# Diagnostic Settings for Fabric Capacity
resource "azurerm_monitor_diagnostic_setting" "fabric_capacity_diagnostics" {
  name                       = "diag-fabric-capacity-${var.solution_name}"
  target_resource_id         = data.fabric_capacity.monitored_capacity.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.fabric_logs.id

  # Enable all available log categories
  enabled_log {
    category = "Audit"
  }

  enabled_log {
    category = "Security"
  }

  enabled_log {
    category = "ServiceHealth"
  }

  # Enable all available metrics
  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = true
      days    = var.log_retention_days
    }
  }
}

# CPU Utilization Alert for Fabric Capacity
resource "azurerm_monitor_metric_alert" "fabric_capacity_cpu" {
  name                = "alert-fabric-capacity-cpu-${var.solution_name}"
  resource_group_name = azurerm_resource_group.monitoring.name
  scopes              = [data.fabric_capacity.monitored_capacity.id]
  description         = "Alert when Fabric Capacity CPU utilization exceeds ${var.cpu_threshold}%"
  severity            = 2
  frequency           = "PT${var.alert_frequency}M"
  window_size         = "PT${var.alert_frequency * 2}M"
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.Fabric/capacities"
    metric_name      = "CpuUtilization"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.cpu_threshold
  }

  action {
    action_group_id = azurerm_monitor_action_group.fabric_alerts.id
  }

  tags = local.common_tags
}

# Memory Utilization Alert for Fabric Capacity
resource "azurerm_monitor_metric_alert" "fabric_capacity_memory" {
  name                = "alert-fabric-capacity-memory-${var.solution_name}"
  resource_group_name = azurerm_resource_group.monitoring.name
  scopes              = [data.fabric_capacity.monitored_capacity.id]
  description         = "Alert when Fabric Capacity memory utilization exceeds ${var.memory_threshold}%"
  severity            = 2
  frequency           = "PT${var.alert_frequency}M"
  window_size         = "PT${var.alert_frequency * 2}M"
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.Fabric/capacities"
    metric_name      = "MemoryUtilization"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.memory_threshold
  }

  action {
    action_group_id = azurerm_monitor_action_group.fabric_alerts.id
  }

  tags = local.common_tags
}

# Storage Utilization Alert for Fabric Capacity
resource "azurerm_monitor_metric_alert" "fabric_capacity_storage" {
  name                = "alert-fabric-capacity-storage-${var.solution_name}"
  resource_group_name = azurerm_resource_group.monitoring.name
  scopes              = [data.fabric_capacity.monitored_capacity.id]
  description         = "Alert when Fabric Capacity storage utilization exceeds ${var.storage_threshold}%"
  severity            = 1
  frequency           = "PT${var.alert_frequency}M"
  window_size         = "PT${var.alert_frequency * 2}M"
  enabled             = true

  criteria {
    metric_namespace = "Microsoft.Fabric/capacities"
    metric_name      = "StorageUtilization"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.storage_threshold
  }

  action {
    action_group_id = azurerm_monitor_action_group.fabric_alerts.id
  }

  tags = local.common_tags
}
