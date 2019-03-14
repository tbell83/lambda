
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| count |  | string | `1` | no |
| description | Description of what your Lambda Function does. | string | `` | no |
| edge |  | string | `false` | no |
| environment_variables | A map that defines environment variables for the Lambda function. | map | `<map>` | no |
| handler | The function entrypoint in your code. | string | - | yes |
| lambda_role_policy_json | JSON of policy for lambda execution role. | string | `` | no |
| log_retention | Cloudwatch log retention in days. | string | `7` | no |
| memory_size | Amount of memory in MB your Lambda Function can use at runtime. | string | `128` | no |
| name | Prefix for module resources. | string | - | yes |
| runtime | Lambda runtime | string | - | yes |
| s3_bucket | The S3 bucket location containing the function's deployment package. Conflicts with filename. | string | - | yes |
| s3_key | The S3 key of an object containing the function's deployment package. Conflicts with filename. | string | - | yes |
| tags | A mapping of tags to assign to the module resources. | map | - | yes |
| timeout | The amount of time your Lambda Function has to run in seconds. | string | `3` | no |
| vpc_config_security_group_ids | A list of security group IDs associated with the Lambda function. | list | `<list>` | no |
| vpc_config_subnet_ids | A list of subnet IDs associated with the Lambda function. | list | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| lambda_arn |  |
| lambda_invoke_arn |  |
| lambda_role_arn |  |

