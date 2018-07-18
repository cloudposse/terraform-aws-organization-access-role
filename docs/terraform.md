
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| master_account_id | The ID of the master account to grant permissions to access the current account | string | - | yes |
| policy_arn | Policy ARN to attach to the role. By default it attaches `AdministratorAccess` managed policy to grant full access to AWS services and resources in the current account | string | `arn:aws:iam::aws:policy/AdministratorAccess` | no |
| role_name | The name of the role to grant permissions to delegated IAM users in the master account to the current account | string | `OrganizationAccountAccessRole` | no |

## Outputs

| Name | Description |
|------|-------------|
| role_arn | The Amazon Resource Name (ARN) specifying the role |
| role_id | The stable and unique string identifying the role |
| role_name | The name of the crated role |

