<!-- BEGIN_TF_DOCS -->
# Fabric Capacity Monitoring and Logging (400 level)

Implements a comprehensive monitoring and logging solution focused on Microsoft Fabric Capacity. This example leverages Azure Monitor, Log Analytics, and Application Insights to provide real-time monitoring of Fabric Capacity performance and health.

## Key Features

### Monitoring Components

- **Log Analytics Workspace**: Centralized log collection and analysis
- **Application Insights**: Advanced application performance monitoring
- **Azure Dashboard**: Real-time metrics visualization
- **Metric Alerts**: CPU, memory, and storage utilization threshold alerts
- **Diagnostic Settings**: Fabric resource log and metric collection

### Alerting System

- **Email Notifications**: Automatic alerts to administrators and operations teams
- **Webhook Integration**: Integration with Teams, Slack, and other collaboration tools
- **Multi-level Severity**: Alert prioritization based on thresholds

### Monitoring Metrics

- **CPU Utilization**: Fabric Capacity CPU performance tracking
- **Memory Utilization**: Memory resource monitoring
- **Storage Utilization**: Data storage capacity management
- **Active Connections**: Concurrent user and connection monitoring

## Architecture

```text
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│  Fabric         │    │  Azure Monitor   │    │  Alert          │
│  Capacity       │───▶│  & Log Analytics │───▶│  Notifications  │
│                 │    │                  │    │                 │
└─────────────────┘    └──────────────────┘    └─────────────────┘
                                │
                                ▼
                       ┌──────────────────┐
                       │  Azure Dashboard │
                       │  & App Insights  │
                       └──────────────────┘
```

---

## Requirements

| Name      | Version       |
|-----------|---------------|
| terraform | >= 1.8, < 2.0 |
| azurerm   | 4.59.0        |
| fabric    | 1.7.0         |

## Providers

| Name    | Version |
|---------|---------|
| azurerm | 4.59.0  |
| fabric  | 1.7.0   |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                         | Type        |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [azurerm_application_insights.fabric_insights](https://registry.terraform.io/providers/hashicorp/azurerm/4.59.0/docs/resources/application_insights)                         | resource    |
| [azurerm_log_analytics_workspace.fabric_logs](https://registry.terraform.io/providers/hashicorp/azurerm/4.59.0/docs/resources/log_analytics_workspace)                       | resource    |
| [azurerm_monitor_action_group.fabric_alerts](https://registry.terraform.io/providers/hashicorp/azurerm/4.59.0/docs/resources/monitor_action_group)                           | resource    |
| [azurerm_monitor_diagnostic_setting.fabric_capacity_diagnostics](https://registry.terraform.io/providers/hashicorp/azurerm/4.59.0/docs/resources/monitor_diagnostic_setting) | resource    |
| [azurerm_monitor_metric_alert.fabric_capacity_cpu](https://registry.terraform.io/providers/hashicorp/azurerm/4.59.0/docs/resources/monitor_metric_alert)                     | resource    |
| [azurerm_monitor_metric_alert.fabric_capacity_memory](https://registry.terraform.io/providers/hashicorp/azurerm/4.59.0/docs/resources/monitor_metric_alert)                  | resource    |
| [azurerm_monitor_metric_alert.fabric_capacity_storage](https://registry.terraform.io/providers/hashicorp/azurerm/4.59.0/docs/resources/monitor_metric_alert)                 | resource    |
| [azurerm_portal_dashboard.fabric_monitoring](https://registry.terraform.io/providers/hashicorp/azurerm/4.59.0/docs/resources/portal_dashboard)                               | resource    |
| [azurerm_resource_group.monitoring](https://registry.terraform.io/providers/hashicorp/azurerm/4.59.0/docs/resources/resource_group)                                          | resource    |
| [fabric_capacity.monitored_capacity](https://registry.terraform.io/providers/microsoft/fabric/1.7.0/docs/data-sources/capacity)                                              | data source |

## Inputs

| Name                              | Description                                                       | Type           | Default       | Required |
|-----------------------------------|-------------------------------------------------------------------|----------------|---------------|:--------:|
| fabric\_capacity\_name            | Name of the existing Fabric Capacity to monitor                   | `string`       | n/a           |   yes    |
| fabric\_capacity\_resource\_group | Resource group name where the Fabric Capacity is located          | `string`       | n/a           |   yes    |
| solution\_name                    | Name of the solution for resource naming                          | `string`       | n/a           |   yes    |
| subscription\_id                  | Azure subscription ID                                             | `string`       | n/a           |   yes    |
| alert\_email\_addresses           | List of email addresses to receive monitoring alerts              | `list(string)` | `[]`          |    no    |
| alert\_frequency                  | How often to evaluate alert conditions (in minutes)               | `number`       | `5`           |    no    |
| alert\_webhook\_urls              | List of webhook URLs for alert notifications (Teams, Slack, etc.) | `list(string)` | `[]`          |    no    |
| cpu\_threshold                    | CPU utilization threshold percentage for alerts                   | `number`       | `80`          |    no    |
| enable\_application\_insights     | Whether to create Application Insights for advanced monitoring    | `bool`         | `true`        |    no    |
| enable\_dashboard                 | Whether to create Azure Dashboard for monitoring                  | `bool`         | `true`        |    no    |
| environment                       | Environment name (dev, test, staging, prod)                       | `string`       | `"dev"`       |    no    |
| location                          | Azure region for resource deployment                              | `string`       | `"West US 2"` |    no    |
| log\_retention\_days              | Number of days to retain logs in Log Analytics workspace          | `number`       | `30`          |    no    |
| memory\_threshold                 | Memory utilization threshold percentage for alerts                | `number`       | `85`          |    no    |
| storage\_threshold                | Storage utilization threshold percentage for alerts               | `number`       | `90`          |    no    |
| tags                              | Additional tags to apply to all resources                         | `map(string)`  | `{}`          |    no    |

## Outputs

| Name                                        | Description                                            |
|---------------------------------------------|--------------------------------------------------------|
| action\_group\_id                           | ID of the monitoring action group                      |
| action\_group\_name                         | Name of the monitoring action group                    |
| application\_insights\_connection\_string   | Connection string for Application Insights             |
| application\_insights\_id                   | ID of the Application Insights instance                |
| application\_insights\_instrumentation\_key | Instrumentation key for Application Insights           |
| cpu\_alert\_id                              | ID of the CPU utilization alert                        |
| dashboard\_id                               | ID of the monitoring dashboard                         |
| dashboard\_url                              | URL to access the monitoring dashboard                 |
| diagnostic\_setting\_id                     | ID of the Fabric Capacity diagnostic setting           |
| log\_analytics\_customer\_id                | Customer ID (Workspace ID) for Log Analytics workspace |
| log\_analytics\_workspace\_id               | ID of the Log Analytics workspace                      |
| log\_analytics\_workspace\_key              | Primary shared key for Log Analytics workspace         |
| log\_analytics\_workspace\_name             | Name of the Log Analytics workspace                    |
| memory\_alert\_id                           | ID of the memory utilization alert                     |
| monitored\_fabric\_capacity\_arm\_id        | Azure ARM resource ID of the monitored Fabric Capacity |
| monitored\_fabric\_capacity\_id             | Fabric GUID of the monitored Fabric Capacity           |
| monitored\_fabric\_capacity\_name           | Name of the monitored Fabric Capacity                  |
| monitoring\_summary                         | Summary of monitoring configuration                    |
| resource\_group\_id                         | ID of the monitoring resource group                    |
| resource\_group\_name                       | Name of the monitoring resource group                  |
| storage\_alert\_id                          | ID of the storage utilization alert                    |

## Usage

### 1. Prepare Variables File

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars file to set values for your environment
```

### 2. Initialize and Deploy Terraform

```bash
terraform init
terraform plan
terraform apply
```

### 3. Access Monitoring Dashboard

After deployment, use the output `dashboard_url` to access the monitoring dashboard in Azure Portal.

## Monitoring Configuration

### Alert Thresholds

- **CPU Utilization**: Default 80% (configurable)
- **Memory Utilization**: Default 85% (configurable)
- **Storage Utilization**: Default 90% (configurable)

### Log Retention

- **Default Retention**: 30 days
- **Maximum Retention**: 730 days
- **Compliance**: Adjust according to your organization's data retention policies

## Log Query Examples

### Query Fabric Capacity CPU Utilization

```kusto
AzureMetrics
| where ResourceProvider == "MICROSOFT.FABRIC"
| where MetricName == "CpuUtilization"
| summarize avg(Average) by bin(TimeGenerated, 5m)
| render timechart
```

### Query Alert History

```kusto
AzureActivity
| where OperationName contains "Microsoft.Insights/metricAlerts"
| project TimeGenerated, Caller, OperationName, ActivityStatus
| order by TimeGenerated desc
```

## Testing

### Run Unit Tests

```bash
terraform test -filter tests/test_unit.tftest.hcl
```

### Run Integration Tests

```bash
terraform test -filter tests/test_acc.tftest.hcl
```

## Customization

### Adding Additional Metric Alerts

To add new metric alerts, add the following resource to `main.tf`:

```hcl
resource "azurerm_monitor_metric_alert" "custom_metric" {
  name                = "alert-custom-metric-${var.solution_name}"
  resource_group_name = azurerm_resource_group.monitoring.name
  scopes              = [data.azurerm_fabric_capacity.monitored_capacity.id]

  criteria {
    metric_namespace = "Microsoft.Fabric/capacities"
    metric_name      = "YourCustomMetric"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 75
  }

  action {
    action_group_id = azurerm_monitor_action_group.fabric_alerts.id
  }
}
```

### Teams/Slack Webhook Configuration

Configure webhook URLs in `terraform.tfvars`:

```hcl
alert_webhook_urls = [
  "https://hooks.slack.com/services/YOUR/SLACK/WEBHOOK",
  "https://outlook.office.com/webhook/YOUR/TEAMS/WEBHOOK"
]
```

## Troubleshooting

### Common Issues

1. **Fabric Capacity Not Found**
   - Verify the `fabric_capacity_name` and `fabric_capacity_resource_group` variables are correct
   - Ensure both AzureRM and Fabric Provider authentication are properly configured

2. **Alerts Not Being Sent**
   - Verify email addresses are correct
   - Check Action Group permissions

3. **Dashboard Access Issues**
   - Verify Azure Portal permissions
   - Check resource group access permissions

## Cost Optimization

- **Log Analytics**: Costs based on data ingestion volume
- **Application Insights**: Usage-based pricing
- **Alerts**: Small costs based on evaluation frequency
- **Dashboard**: Free (Azure Portal built-in feature)

## Security Considerations

- Log Analytics keys are sensitive information - manage securely
- Protect Application Insights connection strings
- Minimize resource group access permissions
- Secure webhook URLs for alert notifications

## Additional Resources

- [Azure Monitor Documentation](https://docs.microsoft.com/azure/azure-monitor/)
- [Log Analytics Query Language](https://learn.microsoft.com/azure/azure-monitor/logs/log-query-overview)
- [Microsoft Fabric Monitoring](https://learn.microsoft.com/fabric/admin/monitoring-workspace)
- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest)

## Limitations and Considerations

- This example is provided as a sample only and is not intended for production use without further customization.
- Existing Fabric resources are required with appropriate permissions.
- Consider monitoring costs when configuring log retention periods and alert frequencies.
<!-- END_TF_DOCS -->