## Usage

How to use in tests?

```hcl
run "random" {
  module {
    source = "../../tests/random_generator"
  }
}

run "testacc_example" {
  variables {
    my_var = "foo-${run.random.string}-bar"
  }
}
```

## Limitations and Considerations

- This example is provided as a sample only and is not intended for production use without further customization.
