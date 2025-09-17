# Copyright (c) Microsoft Corporation
# SPDX-License-Identifier: MPL-2.0

# Azure Dashboard for Fabric Monitoring
resource "azurerm_dashboard" "fabric_monitoring" {
  count               = var.enable_dashboard ? 1 : 0
  name                = "dashboard-${var.solution_name}"
  resource_group_name = azurerm_resource_group.monitoring.name
  location            = azurerm_resource_group.monitoring.location

  tags = local.common_tags

  dashboard_properties = jsonencode({
    lenses = {
      "0" = {
        order = 0
        parts = {
          "0" = {
            position = {
              x       = 0
              y       = 0
              rowSpan = 4
              colSpan = 6
            }
            metadata = {
              inputs = [
                {
                  name       = "resourceTypeMode"
                  isOptional = true
                }
              ]
              type = "Extension/HubsExtension/PartType/MonitorChartPart"
              settings = {
                content = {
                  options = {
                    chart = {
                      metrics = [
                        {
                          resourceMetadata = {
                            id = data.fabric_capacity.monitored_capacity.id
                          }
                          name            = "CpuUtilization"
                          aggregationType = 4
                          namespace       = "Microsoft.Fabric/capacities"
                          metricVisualization = {
                            displayName         = "CPU Utilization"
                            resourceDisplayName = var.fabric_capacity_name
                          }
                        }
                      ]
                      title     = "Fabric Capacity - CPU Utilization"
                      titleKind = 1
                      visualization = {
                        chartType = 2
                        legendVisualization = {
                          isVisible    = true
                          position     = 2
                          hideSubtitle = false
                        }
                        axisVisualization = {
                          x = {
                            isVisible = true
                            axisType  = 2
                          }
                          y = {
                            isVisible = true
                            axisType  = 1
                          }
                        }
                      }
                      timespan = {
                        relative = {
                          duration = 86400000
                        }
                      }
                    }
                  }
                }
              }
            }
          }
          "1" = {
            position = {
              x       = 6
              y       = 0
              rowSpan = 4
              colSpan = 6
            }
            metadata = {
              inputs = [
                {
                  name       = "resourceTypeMode"
                  isOptional = true
                }
              ]
              type = "Extension/HubsExtension/PartType/MonitorChartPart"
              settings = {
                content = {
                  options = {
                    chart = {
                      metrics = [
                        {
                          resourceMetadata = {
                            id = data.fabric_capacity.monitored_capacity.id
                          }
                          name            = "MemoryUtilization"
                          aggregationType = 4
                          namespace       = "Microsoft.Fabric/capacities"
                          metricVisualization = {
                            displayName         = "Memory Utilization"
                            resourceDisplayName = var.fabric_capacity_name
                          }
                        }
                      ]
                      title     = "Fabric Capacity - Memory Utilization"
                      titleKind = 1
                      visualization = {
                        chartType = 2
                        legendVisualization = {
                          isVisible    = true
                          position     = 2
                          hideSubtitle = false
                        }
                        axisVisualization = {
                          x = {
                            isVisible = true
                            axisType  = 2
                          }
                          y = {
                            isVisible = true
                            axisType  = 1
                          }
                        }
                      }
                      timespan = {
                        relative = {
                          duration = 86400000
                        }
                      }
                    }
                  }
                }
              }
            }
          }
          "2" = {
            position = {
              x       = 0
              y       = 4
              rowSpan = 4
              colSpan = 6
            }
            metadata = {
              inputs = [
                {
                  name       = "resourceTypeMode"
                  isOptional = true
                }
              ]
              type = "Extension/HubsExtension/PartType/MonitorChartPart"
              settings = {
                content = {
                  options = {
                    chart = {
                      metrics = [
                        {
                          resourceMetadata = {
                            id = data.fabric_capacity.monitored_capacity.id
                          }
                          name            = "StorageUtilization"
                          aggregationType = 4
                          namespace       = "Microsoft.Fabric/capacities"
                          metricVisualization = {
                            displayName         = "Storage Utilization"
                            resourceDisplayName = var.fabric_capacity_name
                          }
                        }
                      ]
                      title     = "Fabric Capacity - Storage Utilization"
                      titleKind = 1
                      visualization = {
                        chartType = 2
                        legendVisualization = {
                          isVisible    = true
                          position     = 2
                          hideSubtitle = false
                        }
                        axisVisualization = {
                          x = {
                            isVisible = true
                            axisType  = 2
                          }
                          y = {
                            isVisible = true
                            axisType  = 1
                          }
                        }
                      }
                      timespan = {
                        relative = {
                          duration = 86400000
                        }
                      }
                    }
                  }
                }
              }
            }
          }
          "3" = {
            position = {
              x       = 6
              y       = 4
              rowSpan = 4
              colSpan = 6
            }
            metadata = {
              inputs = [
                {
                  name  = "ComponentId"
                  value = var.enable_application_insights ? azurerm_application_insights.fabric_insights[0].id : azurerm_log_analytics_workspace.fabric_logs.id
                }
              ]
              type = "Extension/AppInsightsExtension/PartType/AppMapGalPt"
              settings = {
                content = {
                  title = "Application Map - Fabric Components"
                }
              }
            }
          }
          "4" = {
            position = {
              x       = 0
              y       = 8
              rowSpan = 3
              colSpan = 12
            }
            metadata = {
              inputs = [
                {
                  name       = "resourceTypeMode"
                  isOptional = true
                }
              ]
              type = "Extension/HubsExtension/PartType/MonitorChartPart"
              settings = {
                content = {
                  options = {
                    chart = {
                      metrics = [
                        {
                          resourceMetadata = {
                            id = data.fabric_capacity.monitored_capacity.id
                          }
                          name            = "ActiveConnections"
                          aggregationType = 4
                          namespace       = "Microsoft.Fabric/capacities"
                          metricVisualization = {
                            displayName         = "Active Connections"
                            resourceDisplayName = var.fabric_capacity_name
                          }
                        }
                      ]
                      title     = "Fabric Capacity - Active Connections"
                      titleKind = 1
                      visualization = {
                        chartType = 2
                        legendVisualization = {
                          isVisible    = true
                          position     = 2
                          hideSubtitle = false
                        }
                        axisVisualization = {
                          x = {
                            isVisible = true
                            axisType  = 2
                          }
                          y = {
                            isVisible = true
                            axisType  = 1
                          }
                        }
                      }
                      timespan = {
                        relative = {
                          duration = 86400000
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    metadata = {
      model = {
        timeRange = {
          value = {
            relative = {
              duration = 86400000
            }
          }
          type = "MsPortalFx.Composition.Configuration.ValueTypes.TimeRange"
        }
        filterLocale = {
          value = "en-us"
        }
        filters = {
          value = {
            MsPortalFx_TimeRange = {
              model = {
                format      = "utc"
                granularity = "auto"
                relative    = "24h"
              }
              displayCache = {
                name  = "UTC Time"
                value = "Past 24 hours"
              }
              filteredPartIds = ["StartboardPart-MonitorChartPart-0", "StartboardPart-MonitorChartPart-1", "StartboardPart-MonitorChartPart-2", "StartboardPart-MonitorChartPart-4"]
            }
          }
        }
      }
    }
  })
}
