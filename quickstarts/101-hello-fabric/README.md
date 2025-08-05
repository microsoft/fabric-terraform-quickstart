<!-- BEGIN_TF_DOCS -->
# Hello Fabric (100 level)

---

## Requirements

| Name      | Version       |
|-----------|---------------|
| terraform | >= 1.8, < 2.0 |
| fabric    | 1.4.0         |

## Providers

| Name   | Version |
|--------|---------|
| fabric | 1.4.0   |

## Modules

No modules.

## Resources

| Name                                                                                                                | Type     |
|---------------------------------------------------------------------------------------------------------------------|----------|
| [fabric_workspace.example](https://registry.terraform.io/providers/microsoft/fabric/1.4.0/docs/resources/workspace) | resource |

## Inputs

| Name            | Description           | Type     | Default | Required |
|-----------------|-----------------------|----------|---------|:--------:|
| workspace\_name | Name of the Workspace | `string` | n/a     |   yes    |

## Outputs

| Name          | Description                 |
|---------------|-----------------------------|
| workspace     | The Fabric workspace object |
| workspace\_id | The Fabric workspace ID     |

## Usage

Execute example with the following commands:

```shell
terraform init
terraform apply
```

## Limitations and Considerations

- This example is provided as a sample only and is not intended for production use without further customization.
<!-- END_TF_DOCS -->