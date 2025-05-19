<!-- BEGIN_TF_DOCS -->
# Testing with Terraform (300 level)

Automated tests can be written to verify Fabric resources deployment using the Fabric Terraform Provider.

Checkout how to write automated unit tests against this module using [Terraform](https://developer.hashicorp.com/terraform/cli/test) in the sample tests:

- [tests/unit\_test.tftest.hcl](./tests/unit\_test.tftest.hcl)
- [tests/input\_validations.tftest.hcl](./tests/input\_validations.tftest.hcl)
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
| [fabric_workspace.example](https://registry.terraform.io/providers/microsoft/fabric/1.1.0/docs/resources/workspace) | resource |
| [fabric_workspace_role_assignment.example](https://registry.terraform.io/providers/microsoft/fabric/1.1.0/docs/resources/workspace_role_assignment) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| principal\_id | Workspace role assignment Principal ID | `string` | `"96ce09da-4aab-46b5-b8ac-529f35944c83"` | no |
| workspace\_description | Description of the Workspace | `string` | `"test_description"` | no |
| workspace\_name | Name of the Workspace | `string` | `"test_workspace"` | no |
## Outputs

| Name | Description |
|------|-------------|
| workspace\_id | The Fabric workspace ID |
| workspace\_role\_assignment\_id | The Fabric workspace role assignment ID |
## Usage

Execute example with the following commands:

```shell
terraform init
terraform apply
```

## Testing

Running Terraform tests:

```shell
# Run all tests
terraform test

# Run selected test
terraform test -filter=tests/unit_test.tftest.hcl
```

## Limitations and Considerations

- This example is provided as a sample only and is not intended for production use without further customization.
<!-- END_TF_DOCS -->