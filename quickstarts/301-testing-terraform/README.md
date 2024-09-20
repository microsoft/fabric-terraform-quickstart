# Testing with Terraform (300 level)

Automated tests can be written to verify Fabric resources deployment using the Fabric Terraform Provider.

Checkout how to write automated unit tests against this module using [Terraform](https://developer.hashicorp.com/terraform/cli/test) in the sample tests:

- [tests/unit_test.tftest.hcl](./tests/unit_test.tftest.hcl)
- [tests/input_validations.tftest.hcl](./tests/input_validations.tftest.hcl)

## Input Variables

| Name                    | Description                            |  Type  |                Default                 | Required |
|-------------------------|----------------------------------------|:------:|:--------------------------------------:|:--------:|
| `workspace_name`        | Name of the Workspace                  | string |            `test_workspace`            |  false   |
| `workspace_description` | Description of the Workspace           | string |           `test_description`           |  false   |
| `principal_id`          | Workspace role assignment Principal ID | string | `96ce09da-4aab-46b5-b8ac-529f35944c83` |   true   |

## Output Values

| Name                           | Description                  |
|--------------------------------|------------------------------|
| `workspace_id`                 | Workspace ID                 |
| `workspace_role_assignment_id` | Workspace role assignment ID |

## Usage

Execute example with the following commands:

```shell
terraform init
terraform apply
```

## Expected Behavior

The Fabric provider creates following resources:

- `workspace`
- `workspace_role_assignment`

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
