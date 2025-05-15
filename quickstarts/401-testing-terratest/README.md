# Testing with Terratest (400 level)

Automated tests can be written to verify Fabric resources deployment using the Fabric Terraform Provider.

Checkout how to write automated unit tests against [301-testing-terraform](./../301-testing-terraform/) module using [Terratest](https://github.com/gruntwork-io/terratest) in the sample test in [workspace_test.go](./workspace_test.go).

## Output Values

| Name                           | Description                  |
|--------------------------------|------------------------------|
| `workspace_id`                 | Workspace ID                 |
| `workspace_role_assignment_id` | Workspace role assignment ID |

## Testing

Running Terratest with GoLang tests:

```shell
# Run all tests
go test -v

# Run selected test
go test -v -run TestTerraform_Workspace
```

## Limitations and Considerations

- This example is provided as a sample only and is not intended for production use without further customization.
