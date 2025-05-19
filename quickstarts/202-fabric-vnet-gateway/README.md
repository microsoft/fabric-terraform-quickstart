<!-- BEGIN_TF_DOCS -->
# Fabric Virtual Network Gateway (200 level)

---

## Requirements

| Name      | Version       |
|-----------|---------------|
| terraform | >= 1.8, < 2.0 |
| azuread   | 3.4.0         |
| azurerm   | 4.29.0        |
| fabric    | 1.1.0         |

## Providers

| Name    | Version |
|---------|---------|
| azuread | 3.4.0   |
| azurerm | 4.29.0  |
| fabric  | 1.1.0   |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                                   | Type        |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [azurerm_network_security_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/4.29.0/docs/resources/network_security_group)                                       | resource    |
| [azurerm_resource_group.example](https://registry.terraform.io/providers/hashicorp/azurerm/4.29.0/docs/resources/resource_group)                                                       | resource    |
| [azurerm_role_assignment.example](https://registry.terraform.io/providers/hashicorp/azurerm/4.29.0/docs/resources/role_assignment)                                                     | resource    |
| [azurerm_subnet.example](https://registry.terraform.io/providers/hashicorp/azurerm/4.29.0/docs/resources/subnet)                                                                       | resource    |
| [azurerm_subnet_network_security_group_association.example](https://registry.terraform.io/providers/hashicorp/azurerm/4.29.0/docs/resources/subnet_network_security_group_association) | resource    |
| [azurerm_virtual_network.example](https://registry.terraform.io/providers/hashicorp/azurerm/4.29.0/docs/resources/virtual_network)                                                     | resource    |
| [fabric_gateway.example](https://registry.terraform.io/providers/microsoft/fabric/1.1.0/docs/resources/gateway)                                                                        | resource    |
| [fabric_gateway_role_assignment.example_admin](https://registry.terraform.io/providers/microsoft/fabric/1.1.0/docs/resources/gateway_role_assignment)                                  | resource    |
| [fabric_gateway_role_assignment.example_connection_creator](https://registry.terraform.io/providers/microsoft/fabric/1.1.0/docs/resources/gateway_role_assignment)                     | resource    |
| [azuread_group.example_admin](https://registry.terraform.io/providers/hashicorp/azuread/3.4.0/docs/data-sources/group)                                                                 | data source |
| [azuread_group.example_connection_creator](https://registry.terraform.io/providers/hashicorp/azuread/3.4.0/docs/data-sources/group)                                                    | data source |
| [azurerm_client_config.example](https://registry.terraform.io/providers/hashicorp/azurerm/4.29.0/docs/data-sources/client_config)                                                      | data source |
| [fabric_capacity.example](https://registry.terraform.io/providers/microsoft/fabric/1.1.0/docs/data-sources/capacity)                                                                   | data source |

## Inputs

| Name                                  | Description                                                  | Type     | Default     | Required |
|---------------------------------------|--------------------------------------------------------------|----------|-------------|:--------:|
| fabric\_capacity\_name                | Existing Fabric Capacity name                                | `string` | n/a         |   yes    |
| solution\_name                        | Name of the solution                                         | `string` | n/a         |   yes    |
| subscription\_id                      | The Azure subscription ID                                    | `string` | n/a         |   yes    |
| fabric\_vnet\_gw\_admin               | Entra Group name for Fabric VNet Gateway admins              | `string` | `null`      |    no    |
| fabric\_vnet\_gw\_connection\_creator | Entra Group name for Fabric VNet Gateway connection creators | `string` | `null`      |    no    |
| location                              | Location of the Azure resources                              | `string` | `"WestUS2"` |    no    |

## Outputs

| Name             | Description                |
|------------------|----------------------------|
| fabric\_capacity | The Fabric Capacity object |
| fabric\_gateway  | The Fabric Gateway object  |

## Usage

Execute example with the following commands:

```shell
terraform init
terraform apply
```

## Limitations and Considerations

- This example is provided as a sample only and is not intended for production use without further customization.
<!-- END_TF_DOCS -->