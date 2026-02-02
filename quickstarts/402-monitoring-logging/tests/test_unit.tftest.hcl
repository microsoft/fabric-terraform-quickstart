# Copyright (c) Microsoft Corporation
# SPDX-License-Identifier: MPL-2.0

# Unit tests for Fabric Capacity Monitoring and Logging module
run "validate_log_analytics_workspace" {
  command = plan

  # Test that Log Analytics workspace is created with correct configuration
  assert {
    condition     = azurerm_log_analytics_workspace.fabric_logs.name == "law-${var.solution_name}"
    error_message = "Log Analytics workspace name should follow naming convention"
  }

  assert {
    condition     = azurerm_log_analytics_workspace.fabric_logs.retention_in_days >= 30
    error_message = "Log retention should be at least 30 days for compliance"
  }

  assert {
    condition     = azurerm_log_analytics_workspace.fabric_logs.sku == "PerGB2018"
    error_message = "Log Analytics workspace should use PerGB2018 SKU"
  }
}

run "validate_application_insights" {
  command = plan

  # Test Application Insights configuration (uses count, so access with [0])
  assert {
    condition     = azurerm_application_insights.fabric_insights[0].name == "ai-${var.solution_name}"
    error_message = "Application Insights name should follow naming convention"
  }

  assert {
    condition     = azurerm_application_insights.fabric_insights[0].application_type == "web"
    error_message = "Application Insights should be configured for web applications"
  }

  assert {
    condition     = azurerm_application_insights.fabric_insights[0].workspace_id == azurerm_log_analytics_workspace.fabric_logs.id
    error_message = "Application Insights should be linked to Log Analytics workspace"
  }
}

run "validate_action_group" {
  command = plan

  # Test that action group is created for alerts
  assert {
    condition     = azurerm_monitor_action_group.fabric_alerts.name == "ag-${var.solution_name}"
    error_message = "Action group name should follow naming convention"
  }

  assert {
    condition     = length(azurerm_monitor_action_group.fabric_alerts.email_receiver) > 0
    error_message = "Action group should have at least one email receiver"
  }
}

run "validate_metric_alerts" {
  command = plan

  # Test Fabric Capacity CPU alert
  assert {
    condition     = azurerm_monitor_metric_alert.fabric_capacity_cpu.name == "alert-fabric-capacity-cpu-${var.solution_name}"
    error_message = "Fabric Capacity CPU alert name should follow naming convention"
  }

  assert {
    condition     = azurerm_monitor_metric_alert.fabric_capacity_cpu.criteria[0].threshold == 80
    error_message = "CPU alert threshold should be 80%"
  }

  # Test Fabric Capacity Memory alert
  assert {
    condition     = azurerm_monitor_metric_alert.fabric_capacity_memory.criteria[0].threshold == 85
    error_message = "Memory alert threshold should be 85%"
  }
}

run "validate_dashboard" {
  command = plan

  # Test that Azure Dashboard is created (uses count, so access with [0])
  assert {
    condition     = azurerm_dashboard.fabric_monitoring[0].name == "dashboard-${var.solution_name}"
    error_message = "Dashboard name should follow naming convention"
  }

  assert {
    condition     = length(azurerm_dashboard.fabric_monitoring[0].dashboard_properties) > 0
    error_message = "Dashboard should have monitoring widgets configured"
  }
}

run "validate_diagnostic_settings" {
  command = plan

  # Test diagnostic settings for Fabric Capacity
  assert {
    condition     = azurerm_monitor_diagnostic_setting.fabric_capacity_diagnostics.name == "diag-fabric-capacity-${var.solution_name}"
    error_message = "Diagnostic setting name should follow naming convention"
  }

  assert {
    condition     = azurerm_monitor_diagnostic_setting.fabric_capacity_diagnostics.log_analytics_workspace_id == azurerm_log_analytics_workspace.fabric_logs.id
    error_message = "Diagnostic settings should send logs to Log Analytics workspace"
  }
}

run "validate_resource_tags" {
  command = plan

  # Test that all resources have required tags
  assert {
    condition = alltrue([
      for resource in [
        azurerm_log_analytics_workspace.fabric_logs,
        azurerm_application_insights.fabric_insights[0],
        azurerm_monitor_action_group.fabric_alerts
      ] : contains(keys(resource.tags), "Environment")
    ])
    error_message = "All monitoring resources should have Environment tag"
  }

  assert {
    condition = alltrue([
      for resource in [
        azurerm_log_analytics_workspace.fabric_logs,
        azurerm_application_insights.fabric_insights[0],
        azurerm_monitor_action_group.fabric_alerts
      ] : contains(keys(resource.tags), "Purpose")
    ])
    error_message = "All monitoring resources should have Purpose tag"
  }
}
