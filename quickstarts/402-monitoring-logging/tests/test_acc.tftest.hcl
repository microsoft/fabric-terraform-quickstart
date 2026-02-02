# Copyright (c) Microsoft Corporation
# SPDX-License-Identifier: MPL-2.0

# Acceptance tests for Fabric Capacity Monitoring and Logging module
variables {
  solution_name = "test-monitoring"
  location      = "West US 2"
  environment   = "test"

  # Test alert configuration
  alert_email_addresses = ["admin@contoso.com", "ops@contoso.com"]

  # Test Fabric Capacity configuration
  fabric_capacity_name  = "test-fabric-capacity"
  fabric_workspace_name = "test-fabric-workspace"

  # Test monitoring thresholds
  cpu_threshold     = 80
  memory_threshold  = 85
  storage_threshold = 90
}

# Test complete monitoring infrastructure deployment
run "deploy_monitoring_infrastructure" {
  command = apply

  # Verify Log Analytics workspace is deployed and accessible
  assert {
    condition     = azurerm_log_analytics_workspace.fabric_logs.workspace_id != null
    error_message = "Log Analytics workspace should be successfully deployed"
  }

  assert {
    condition     = azurerm_log_analytics_workspace.fabric_logs.primary_shared_key != null
    error_message = "Log Analytics workspace should have access keys generated"
  }
}

# Test Application Insights integration
run "verify_application_insights_integration" {
  command = apply

  assert {
    condition     = azurerm_application_insights.fabric_insights.instrumentation_key != null
    error_message = "Application Insights should have instrumentation key generated"
  }

  assert {
    condition     = azurerm_application_insights.fabric_insights.connection_string != null
    error_message = "Application Insights should have connection string generated"
  }
}

# Test alert configuration and action group
run "verify_alert_configuration" {
  command = apply

  # Verify action group is properly configured
  assert {
    condition     = length(azurerm_monitor_action_group.fabric_alerts.email_receiver) == length(var.alert_email_addresses)
    error_message = "Action group should have all specified email receivers configured"
  }

  # Verify CPU alert is active
  assert {
    condition     = azurerm_monitor_metric_alert.fabric_capacity_cpu.enabled == true
    error_message = "Fabric Capacity CPU alert should be enabled"
  }

  # Verify Memory alert is active
  assert {
    condition     = azurerm_monitor_metric_alert.fabric_capacity_memory.enabled == true
    error_message = "Fabric Capacity Memory alert should be enabled"
  }
}

# Test diagnostic settings integration
run "verify_diagnostic_settings" {
  command = apply

  # Verify diagnostic settings are properly linked
  assert {
    condition     = azurerm_monitor_diagnostic_setting.fabric_capacity_diagnostics.log_analytics_workspace_id == azurerm_log_analytics_workspace.fabric_logs.id
    error_message = "Diagnostic settings should be linked to Log Analytics workspace"
  }

  # Verify metrics are being collected
  assert {
    condition     = length(azurerm_monitor_diagnostic_setting.fabric_capacity_diagnostics.enabled_log) > 0
    error_message = "Diagnostic settings should have at least one log category enabled"
  }

  assert {
    condition     = length(azurerm_monitor_diagnostic_setting.fabric_capacity_diagnostics.metric) > 0
    error_message = "Diagnostic settings should have metrics collection enabled"
  }
}

# Test dashboard deployment
run "verify_dashboard_deployment" {
  command = apply

  # Verify dashboard is created and accessible
  assert {
    condition     = azurerm_dashboard.fabric_monitoring.id != null
    error_message = "Azure Dashboard should be successfully deployed"
  }

  # Verify dashboard has monitoring widgets
  assert {
    condition     = length(jsondecode(azurerm_dashboard.fabric_monitoring.dashboard_properties).lenses) > 0
    error_message = "Dashboard should contain monitoring widgets"
  }
}

# Test resource tagging compliance
run "verify_resource_tagging" {
  command = apply

  # Verify all resources have required tags
  assert {
    condition = alltrue([
      for resource in [
        azurerm_log_analytics_workspace.fabric_logs,
        azurerm_application_insights.fabric_insights,
        azurerm_monitor_action_group.fabric_alerts,
        azurerm_dashboard.fabric_monitoring
      ] : resource.tags["Environment"] == var.environment
    ])
    error_message = "All resources should have correct Environment tag"
  }

  assert {
    condition = alltrue([
      for resource in [
        azurerm_log_analytics_workspace.fabric_logs,
        azurerm_application_insights.fabric_insights,
        azurerm_monitor_action_group.fabric_alerts,
        azurerm_dashboard.fabric_monitoring
      ] : resource.tags["Purpose"] == "Fabric-Monitoring"
    ])
    error_message = "All resources should have correct Purpose tag"
  }
}

# Test outputs are properly generated
run "verify_outputs" {
  command = apply

  # Verify monitoring outputs
  assert {
    condition     = output.log_analytics_workspace_id != null && output.log_analytics_workspace_id != ""
    error_message = "Log Analytics workspace ID should be available as output"
  }

  assert {
    condition     = output.application_insights_instrumentation_key != null && output.application_insights_instrumentation_key != ""
    error_message = "Application Insights instrumentation key should be available as output"
  }

  assert {
    condition     = output.dashboard_url != null && output.dashboard_url != ""
    error_message = "Dashboard URL should be available as output"
  }
}
