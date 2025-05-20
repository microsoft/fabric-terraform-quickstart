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
