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

# Run unit tests only
terraform test -filter tests/test_unit.tftest.hcl

# Run integration tests only
terraform test -filter tests/test_acc.tftest.hcl
```

## Monitoring Access

After deployment:

1. Log in to Azure Portal
2. Navigate to the output `dashboard_url`
3. View real-time monitoring dashboard

## Limitations and Considerations

- This example is provided as a sample only and is not intended for production use without further customization.
- Existing Fabric Capacity is required with appropriate monitoring permissions.
- Azure costs may apply based on log retention periods and alert frequencies.
