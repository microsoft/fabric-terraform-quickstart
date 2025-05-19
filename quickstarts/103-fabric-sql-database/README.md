<!-- BEGIN_TF_DOCS -->
# Fabric SQL Database (100 level)
---
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.8, < 2.0 |
| fabric | 1.1.0 |
## Providers

| Name | Version |
|------|---------|
| fabric | 1.1.0 |
## Modules

No modules.
## Resources

| Name | Type |
|------|------|
| [fabric_sql_database.example_sql](https://registry.terraform.io/providers/microsoft/fabric/1.1.0/docs/resources/sql_database) | resource |
| [fabric_workspace.example_workspace](https://registry.terraform.io/providers/microsoft/fabric/1.1.0/docs/resources/workspace) | resource |
| [fabric_capacity.capacity](https://registry.terraform.io/providers/microsoft/fabric/1.1.0/docs/data-sources/capacity) | data source |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| fabric\_capacity\_name | The existing Fabric Capacity name. | `string` | n/a | yes |
| fabric\_sql\_database\_name | The name of SQL database to be created. | `string` | n/a | yes |
| fabric\_workspace\_name | The name of workspace to be created. | `string` | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| fabric\_sql\_database\_id | The created Fabric SQL database  id |
| fabric\_workspace\_id | The created Fabric workspace id |
## Usage

Execute example with the following commands:

```shell
terraform init
terraform apply
```

## Limitations and Considerations

- This example is provided as a sample only and is not intended for production use without further customization.
<!-- END_TF_DOCS -->