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
