# Fabric Capacity (100 level)

## Input Variables

| Name                  | Description                     | Type   | Default | Required |
|-----------------------|---------------------------------|--------|---------|:--------:|
| `name`                | Name of the solution            | string |         |   true   |
| `location`            | Location of the Azure resources | string | WestUS3 |  false   |
| `fabric_capacity_sku` | Fabric Capacity SKU name        | string | F2      |  false   |
| `subscription_id`     | The Azure subscription ID       | string |         |   true   |

## Output Values

| Name               | Description             |
|--------------------|-------------------------|
| `fabric_capacity`  | Fabric Capacity object  |
| `fabric_workspace` | Fabric Workspace object |

## Usage

Execute example with the following commands:

```shell
terraform init
terraform apply
```

## Expected Behavior

The Terraform creates following resources:

- Azure Resource Group
- Azure Fabric Capacity
- Fabric Workspace

## Limitations and Considerations

- This example is provided as a sample only and is not intended for production use without further customization.
