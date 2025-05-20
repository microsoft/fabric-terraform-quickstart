<!-- BEGIN_TF_DOCS -->
# Testing with Terraform (300 level)

Automated tests can be written to verify Fabric resources deployment using the Fabric Terraform Provider.

Checkout how to write automated unit tests against this module using [Terraform](https://developer.hashicorp.com/terraform/cli/test) in the sample tests:

- [tests/test\_unit.tftest.hcl](./tests/test\_unit.tftest.hcl)
- [tests/test\_input.tftest.hcl](./tests/test\_input.tftest.hcl)

---

## Requirements

| Name      | Version       |
|-----------|---------------|
| terraform | >= 1.8, < 2.0 |
| fabric    | 1.1.0         |

## Providers

| Name   | Version |
|--------|---------|
| fabric | 1.1.0   |

## Modules

No modules.

## Resources

| Name                                                                                                                                                | Type     |
|-----------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [fabric_workspace.example](https://registry.terraform.io/providers/microsoft/fabric/1.1.0/docs/resources/workspace)                                 | resource |
| [fabric_workspace_role_assignment.example](https://registry.terraform.io/providers/microsoft/fabric/1.1.0/docs/resources/workspace_role_assignment) | resource |

## Inputs

| Name                   | Description                            | Type                                                                     | Default              | Required |
|------------------------|----------------------------------------|--------------------------------------------------------------------------|----------------------|:--------:|
| principal              | Workspace role assignment Principal ID | <pre>object({<br/>    id   = string<br/>    type = string<br/>  })</pre> | n/a                  |   yes    |
| workspace\_description | Description of the Workspace           | `string`                                                                 | `"test_description"` |    no    |
| workspace\_name        | Name of the Workspace                  | `string`                                                                 | `"test_workspace"`   |    no    |

## Outputs

| Name                            | Description                             |
|---------------------------------|-----------------------------------------|
| workspace\_id                   | The Fabric workspace ID                 |
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
terraform test -filter tests/test_unit.tftest.hcl
```

## Limitations and Considerations

- This example is provided as a sample only and is not intended for production use without further customization.
<!-- END_TF_DOCS -->