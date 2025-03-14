# Fabric Virtual Network Gateway (200 level)

## Input Variables

| Name                                | Description                                                   | Type        | Default | Required |
|-------------------------------------|---------------------------------------------------------------|-------------|---------|:--------:|
| `subscription_id`                   | The Azure subscription ID                                     | string      |         |   true   |
| `solution_name`                     | Name of the solution                                          | string      |         |   true   |
| `location`                          | Location of the Azure resources                               | string      | WestUS2 |  false   |
| `fabric_capacity_sku`               | Fabric Capacity SKU name                                      | string      | F2      |  false   |
| `fabric_capacity_admin_upns`        | Collection of admin UPNs for the Fabric Capacity.             | set(string) |         |  false   |
| `fabric_vnet_gw_admin`              | Entra Group name for Fabric VNet Gateway admins.              | string      |         |  false   |
| `fabric_vnet_gw_connection_creator` | Entra Group name for Fabric VNet Gateway connection creators. | string      |         |  false   |

> [!WARNING]
> Azure VNet region needs to be in one of supported regions to be able to create a Fabric virtual network (VNet) data gateway, see [Regions supported for VNet data gateways](https://learn.microsoft.com/data-integration/vnet/create-data-gateways#regions-supported-for-vnet-data-gateways).

## Output Values

| Name               | Description                           |
|--------------------|---------------------------------------|
| `fabric_capacity`  | Fabric Capacity object                |
| `fabric_workspace` | Fabric Workspace object               |
| `fabric_gateway`   | Fabric Virtual Network Gateway object |

## Usage

Execute example with the following commands:

```shell
terraform init
terraform apply
```

## Expected Behavior

The Terraform creates following resources:

- Azure Resource Group
- Azure Virtual Network with Subnet
- Azure Role Assignment for Virtual Network
- Azure Fabric Capacity
- Fabric Workspace
- Fabric Virtual Network Gateway
- Fabric Gateway Role Assignment

## Limitations and Considerations

- This example is provided as a sample only and is not intended for production use without further customization.
