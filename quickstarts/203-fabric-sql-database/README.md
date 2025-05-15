# Fabric SQL Database (200 level)

## Input Variables
- Please fill the input variables in terraform.tfstate file.

| Name                                | Description                                                   | Type        | Default | Required |
|-------------------------------------|---------------------------------------------------------------|-------------|---------|----------|
| `fabric_workspace_name`             | The name of workspace to be created                           | string      |         |   true   |
| `fabric_sql_database_name`          | The name of SQL database to be created                        | string      |         |   true   |
| `fabric_capacity_name`              | The existing Fabric Capacity name                             | string      |         |   true   |

## Output Values

| Name                     | Description                           |
|--------------------------|---------------------------------------|
| `fabric_workspace_id`    | The created Fabric workspace id       |
| `fabric_sql_database_id` | The created Fabric SQL database  id   |

## Prerequisites
- This example requires an existing Fabric capacity.
- This example requires authentication setup. The authenticating method is not included in this example. For Service Principal, please refer to : https://registry.terraform.io/providers/microsoft/fabric/latest/docs/guides/auth_spn_cert. For user context authentication, please run 'az login' in the command window.

## Usage
- Create a terraform.tfstate file, fill values for all variables in the variables.tf file.
- Execute example with the following commands:

```shell
terraform init
terraform plan
terraform apply
```

## Expected Behavior

The Terraform creates following resources:

- Fabric Workspace.
- Fabric SQL database

## Limitations and Considerations

- This example is provided as a sample only and is not intended for production use without further customization.
