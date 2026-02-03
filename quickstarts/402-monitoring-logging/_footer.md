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
