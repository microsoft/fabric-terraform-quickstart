# Copyright (c) Microsoft Corporation
# SPDX-License-Identifier: MPL-2.0

# Resource Group outputs
output "resource_group_name" {
  description = "Name of the monitoring resource group"
  value       = azurerm_resource_group.monitoring.name
}

output "resource_group_id" {
  description = "ID of the monitoring resource group"
  value       = azurerm_resource_group.monitoring.id
}

# Log Analytics Workspace outputs
output "log_analytics_workspace_id" {
  description = "ID of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.fabric_logs.id
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.fabric_logs.name
}

output "log_analytics_workspace_key" {
  description = "Primary shared key for Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.fabric_logs.primary_shared_key
  sensitive   = true
}

output "log_analytics_customer_id" {
  description = "Customer ID (Workspace ID) for Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.fabric_logs.workspace_id
}

# Application Insights outputs
output "application_insights_id" {
  description = "ID of the Application Insights instance"
  value       = var.enable_application_insights ? azurerm_application_insights.fabric_insights[0].id : null
}

output "application_insights_instrumentation_key" {
  description = "Instrumentation key for Application Insights"
  value       = var.enable_application_insights ? azurerm_application_insights.fabric_insights[0].instrumentation_key : null
  sensitive   = true
}

output "application_insights_connection_string" {
  description = "Connection string for Application Insights"
  value       = var.enable_application_insights ? azurerm_application_insights.fabric_insights[0].connection_string : null
  sensitive   = true
}

# Action Group outputs
output "action_group_id" {
  description = "ID of the monitoring action group"
  value       = azurerm_monitor_action_group.fabric_alerts.id
}

output "action_group_name" {
  description = "Name of the monitoring action group"
  value       = azurerm_monitor_action_group.fabric_alerts.name
}

# Alert outputs
output "cpu_alert_id" {
  description = "ID of the CPU utilization alert"
  value       = azurerm_monitor_metric_alert.fabric_capacity_cpu.id
}

output "memory_alert_id" {
  description = "ID of the memory utilization alert"
  value       = azurerm_monitor_metric_alert.fabric_capacity_memory.id
}

output "storage_alert_id" {
  description = "ID of the storage utilization alert"
  value       = azurerm_monitor_metric_alert.fabric_capacity_storage.id
}

# Dashboard outputs
output "dashboard_id" {
  description = "ID of the monitoring dashboard"
  value       = var.enable_dashboard ? azurerm_dashboard.fabric_monitoring[0].id : null
}

output "dashboard_url" {
  description = "URL to access the monitoring dashboard"
  value       = var.enable_dashboard ? "https://portal.azure.com/#@/dashboard/arm${azurerm_dashboard.fabric_monitoring[0].id}" : null
}

# Diagnostic Settings outputs
output "diagnostic_setting_id" {
  description = "ID of the Fabric Capacity diagnostic setting"
  value       = azurerm_monitor_diagnostic_setting.fabric_capacity_diagnostics.id
}

# Monitored Resource outputs
output "monitored_fabric_capacity_id" {
  description = "ID of the monitored Fabric Capacity"
  value       = data.fabric_capacity.monitored_capacity.id
}

output "monitored_fabric_capacity_name" {
  description = "Name of the monitored Fabric Capacity"
  value       = data.fabric_capacity.monitored_capacity.display_name
}

output "monitored_fabric_workspace_id" {
  description = "ID of the monitored Fabric Workspace"
  value       = var.fabric_workspace_name != null ? data.fabric_workspace.monitored_workspace[0].id : null
}

# Summary information
output "monitoring_summary" {
  description = "Summary of monitoring configuration"
  value = {
    solution_name        = var.solution_name
    environment          = var.environment
    monitored_capacity   = var.fabric_capacity_name
    monitored_workspace  = var.fabric_workspace_name
    log_retention_days   = var.log_retention_days
    alert_email_count    = length(var.alert_email_addresses)
    alert_webhook_count  = length(var.alert_webhook_urls)
    cpu_threshold        = var.cpu_threshold
    memory_threshold     = var.memory_threshold
    storage_threshold    = var.storage_threshold
    dashboard_enabled    = var.enable_dashboard
    app_insights_enabled = var.enable_application_insights
  }
}
