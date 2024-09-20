# Hello Fabric (100 level)

## Input Variables

| Name                    | Description                  | Type   | Default | Required |
|-------------------------|------------------------------|--------|---------|:--------:|
| `workspace_name`        | Name of the Workspace        | string |         |   true   |

## Output Values

| Name           | Description      |
|----------------|------------------|
| `workspace`    | Workspace object |
| `workspace_id` | Workspace ID     |

## Usage

Execute example with the following commands:

```shell
terraform init
terraform apply
```

## Expected Behavior

The Fabric provider creates following resources:

- Workspace

## Limitations and Considerations

- This example is provided as a sample only and is not intended for production use without further customization.
