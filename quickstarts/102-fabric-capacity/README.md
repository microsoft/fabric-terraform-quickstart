<!-- BEGIN_TF_DOCS -->
# Fabric Capacity (100 level)

---

## Requirements

| Name      | Version       |
|-----------|---------------|
| terraform | >= 1.8, < 2.0 |
| azuread   | 3.4.0         |
| azurerm   | 4.30.0        |
| fabric    | 1.1.0         |

## Providers

| Name    | Version |
|---------|---------|
| azuread | 3.4.0   |
| azurerm | 4.30.0  |
| fabric  | 1.1.0   |

## Modules

No modules.

## Resources

| Name                                                                                                                                   | Type        |
|----------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [azurerm_fabric_capacity.example](https://registry.terraform.io/providers/hashicorp/azurerm/4.30.0/docs/resources/fabric_capacity)     | resource    |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/4.30.0/docs/resources/resource_group)       | resource    |
| [fabric_workspace.example](https://registry.terraform.io/providers/microsoft/fabric/1.1.0/docs/resources/workspace)                    | resource    |
| [azuread_directory_object.example](https://registry.terraform.io/providers/hashicorp/azuread/3.4.0/docs/data-sources/directory_object) | data source |
| [azuread_user.example](https://registry.terraform.io/providers/hashicorp/azuread/3.4.0/docs/data-sources/user)                         | data source |
| [azurerm_client_config.example](https://registry.terraform.io/providers/hashicorp/azurerm/4.30.0/docs/data-sources/client_config)      | data source |
| [fabric_capacity.example](https://registry.terraform.io/providers/microsoft/fabric/1.1.0/docs/data-sources/capacity)                   | data source |

## Inputs

| Name                          | Description                                       | Type          | Default     | Required |
|-------------------------------|---------------------------------------------------|---------------|-------------|:--------:|
| solution\_name                | Name of the solution                              | `string`      | n/a         |   yes    |
| subscription\_id              | The Azure subscription ID                         | `string`      | n/a         |   yes    |
| fabric\_capacity\_admin\_upns | Collection of admin UPNs for the Fabric Capacity. | `set(string)` | `[]`        |    no    |
| fabric\_capacity\_sku         | Fabric Capacity SKU name                          | `string`      | `"F2"`      |    no    |
| location                      | Location of the Azure resources                   | `string`      | `"WestUS3"` |    no    |

## Outputs

| Name              | Description                 |
|-------------------|-----------------------------|
| fabric\_capacity  | The Fabric Capacity object  |
| fabric\_workspace | The Fabric Workspace object |

## Usage

Execute example with the following commands:

```shell
terraform init
terraform apply
```

## Limitations and Considerations

- This example is provided as a sample only and is not intended for production use without further customization.
<!-- END_TF_DOCS -->