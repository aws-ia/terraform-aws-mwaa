# Amazon Managed Workflows for Apache Airflow(MWAA) Module

This terraform module can be used to deploy [Amazon Managed Workflows for Apache Airflow(MWAA)](https://docs.aws.amazon.com/mwaa/latest/userguide/what-is-mwaa.html) environment.

   ✅ Deployment examples can be found under [examples](https://github.com/aws-ia/terraform-aws-mwaa/tree/main/examples) folder.

   ✅ Amazon MWAA documentation for more details about [Amazon MWAA](https://docs.aws.amazon.com/mwaa/index.html)

   ✅ Amazon MWAA for Analytics [Workshop](https://catalog.us-east-1.prod.workshops.aws/workshops/795e88bb-17e2-498f-82d1-2104f4824168/en-US)

## Amazon MWAA Architecture

<p align="center">
  <img src="https://raw.githubusercontent.com/aws-ia/terraform-aws-mwaa/main/images/mwaa-architecture-terraform-iac.png" alt="example of Amazon MWAA Architecture for an example public deployment" width="100%">
</p>

## Usage

The example below builds Amazon MWAA environment with existing VPC and Private Subnets.
Amazon MWAA supporting resources S3 bucket, IAM role and Security groups created by this module by default.
This module allows you to bring your own S3 bucket, IAM role and Security group.

```hcl
module "mwaa" {
  source = "aws-ia/mwaa/aws"

  name                 = "basic-mwaa"
  airflow_version      = "2.2.2"
  environment_class    = "mw1.medium"

  vpc_id                = "<ENTER_VPC_ID>"
  private_subnet_ids    = ["<ENTER_SIBNET_ID1>","<ENTER_SIBNET_ID2>"]

  min_workers           = 1
  max_workers           = 25
  webserver_access_mode = "PUBLIC_ONLY" # Default PRIVATE_ONLY for production environments

  logging_configuration = {
    dag_processing_logs = {
      enabled   = true
      log_level = "INFO"
    }

    scheduler_logs = {
      enabled   = true
      log_level = "INFO"
    }

    task_logs = {
      enabled   = true
      log_level = "INFO"
    }

    webserver_logs = {
      enabled   = true
      log_level = "INFO"
    }

    worker_logs = {
      enabled   = true
      log_level = "INFO"
    }
  }

  airflow_configuration_options = {
    "core.load_default_connections" = "false"
    "core.load_examples"            = "false"
    "webserver.dag_default_view"    = "tree"
    "webserver.dag_orientation"     = "TB"
    "logging.logging_level"         = "INFO"
  }
}
```

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/aws-ia/terraform-aws-mwaa/blob/main/LICENSE).

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.20.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.20.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.mwaa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.mwaa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.mwaa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_mwaa_environment.mwaa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/mwaa_environment) | resource |
| [aws_s3_bucket.mwaa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.mwaa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_public_access_block.mwaa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.mwaa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.mwaa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_security_group.mwaa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.mwaa_sg_inbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.mwaa_sg_inbound_vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.mwaa_sg_outbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.mwaa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.mwaa_assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_airflow_configuration_options"></a> [airflow\_configuration\_options](#input\_airflow\_configuration\_options) | (Optional) The airflow\_configuration\_options parameter specifies airflow override options. | `any` | `null` | no |
| <a name="input_airflow_version"></a> [airflow\_version](#input\_airflow\_version) | (Optional) Airflow version of your environment, will be set by default to the latest version that MWAA supports. | `string` | `null` | no |
| <a name="input_create_iam_role"></a> [create\_iam\_role](#input\_create\_iam\_role) | Create IAM role for MWAA | `bool` | `true` | no |
| <a name="input_create_s3_bucket"></a> [create\_s3\_bucket](#input\_create\_s3\_bucket) | Create new S3 bucket for MWAA. | `string` | `true` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Create security group for MWAA | `bool` | `true` | no |
| <a name="input_dag_s3_path"></a> [dag\_s3\_path](#input\_dag\_s3\_path) | (Required) The relative path to the DAG folder on your Amazon S3 storage bucket. For example, dags. | `string` | `"dags"` | no |
| <a name="input_environment_class"></a> [environment\_class](#input\_environment\_class) | (Optional) Environment class for the cluster. Possible options are mw1.small, mw1.medium, mw1.large.<br>Will be set by default to mw1.small. Please check the AWS Pricing for more information about the environment classes. | `string` | `"mw1.small"` | no |
| <a name="input_execution_role_arn"></a> [execution\_role\_arn](#input\_execution\_role\_arn) | (Required) The Amazon Resource Name (ARN) of the task execution role that the Amazon MWAA and its environment can assume<br>Mandatory if `create_iam_role=false` | `string` | `null` | no |
| <a name="input_force_detach_policies"></a> [force\_detach\_policies](#input\_force\_detach\_policies) | IAM role Force detach policies | `bool` | `false` | no |
| <a name="input_iam_role_additional_policies"></a> [iam\_role\_additional\_policies](#input\_iam\_role\_additional\_policies) | Additional policies to be added to the IAM role | `list(string)` | `[]` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | IAM Role Name to be created if execution\_role\_arn is null | `string` | `null` | no |
| <a name="input_iam_role_path"></a> [iam\_role\_path](#input\_iam\_role\_path) | IAM role path | `string` | `"/"` | no |
| <a name="input_iam_role_permissions_boundary"></a> [iam\_role\_permissions\_boundary](#input\_iam\_role\_permissions\_boundary) | IAM role Permission boundary | `string` | `null` | no |
| <a name="input_kms_key"></a> [kms\_key](#input\_kms\_key) | (Optional) The Amazon Resource Name (ARN) of your KMS key that you want to use for encryption.<br>Will be set to the ARN of the managed KMS key aws/airflow by default. | `string` | `null` | no |
| <a name="input_logging_configuration"></a> [logging\_configuration](#input\_logging\_configuration) | (Optional) The Apache Airflow logs which will be send to Amazon CloudWatch Logs. | `any` | `null` | no |
| <a name="input_max_workers"></a> [max\_workers](#input\_max\_workers) | (Optional) The maximum number of workers that can be automatically scaled up.<br>Value need to be between 1 and 25. Will be 10 by default | `number` | `10` | no |
| <a name="input_min_workers"></a> [min\_workers](#input\_min\_workers) | (Optional) The minimum number of workers that you want to run in your environment. Will be 1 by default. | `number` | `1` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Apache Airflow MWAA Environment | `string` | n/a | yes |
| <a name="input_plugins_s3_object_version"></a> [plugins\_s3\_object\_version](#input\_plugins\_s3\_object\_version) | (Optional) The plugins.zip file version you want to use. | `string` | `null` | no |
| <a name="input_plugins_s3_path"></a> [plugins\_s3\_path](#input\_plugins\_s3\_path) | (Optional) The relative path to the plugins.zip file on your Amazon S3 storage bucket. For example, plugins.zip. If a relative path is provided in the request, then plugins\_s3\_object\_version is required. | `string` | `null` | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | (Required) The private subnet IDs in which the environment should be created.<br>MWAA requires two subnets. | `list(string)` | n/a | yes |
| <a name="input_requirements_s3_object_version"></a> [requirements\_s3\_object\_version](#input\_requirements\_s3\_object\_version) | Optional) The requirements.txt file version you want to use. | `string` | `null` | no |
| <a name="input_requirements_s3_path"></a> [requirements\_s3\_path](#input\_requirements\_s3\_path) | (Optional) The relative path to the requirements.txt file on your Amazon S3 storage bucket. For example, requirements.txt. If a relative path is provided in the request, then requirements\_s3\_object\_version is required. | `string` | `null` | no |
| <a name="input_schedulers"></a> [schedulers](#input\_schedulers) | (Optional) The number of schedulers that you want to run in your environment. | `string` | `null` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Security group IDs for MWAA | `list(string)` | `[]` | no |
| <a name="input_source_bucket_arn"></a> [source\_bucket\_arn](#input\_source\_bucket\_arn) | (Required) The Amazon Resource Name (ARN) of your Amazon S3 storage bucket. For example, arn:aws:s3:::airflow-mybucketname | `string` | `null` | no |
| <a name="input_source_bucket_name"></a> [source\_bucket\_name](#input\_source\_bucket\_name) | New bucket will be created with the given name for MWAA when create\_s3\_bucket=true | `string` | `null` | no |
| <a name="input_source_cidr"></a> [source\_cidr](#input\_source\_cidr) | (Required) Source CIDR block which will be allowed on MWAA SG to access Airflow UI<br>Used only if `create_security_group=true` | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of resource tags to associate with the resource | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | (Required) VPC ID to deploy the MWAA Environment.<br>Mandatory if `create_security_group=true` | `string` | `""` | no |
| <a name="input_webserver_access_mode"></a> [webserver\_access\_mode](#input\_webserver\_access\_mode) | (Optional) Specifies whether the webserver should be accessible over the internet or via your specified VPC. Possible options: PRIVATE\_ONLY (default) and PUBLIC\_ONLY | `string` | `"PRIVATE_ONLY"` | no |
| <a name="input_weekly_maintenance_window_start"></a> [weekly\_maintenance\_window\_start](#input\_weekly\_maintenance\_window\_start) | (Optional) Specifies the start date for the weekly maintenance window | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_s3_bucket_name"></a> [aws\_s3\_bucket\_name](#output\_aws\_s3\_bucket\_name) | S3 bucket Name of the MWAA Environment |
| <a name="output_mwaa_arn"></a> [mwaa\_arn](#output\_mwaa\_arn) | The ARN of the MWAA Environment |
| <a name="output_mwaa_role_arn"></a> [mwaa\_role\_arn](#output\_mwaa\_role\_arn) | IAM Role ARN of the MWAA Environment |
| <a name="output_mwaa_role_name"></a> [mwaa\_role\_name](#output\_mwaa\_role\_name) | IAM role name of the MWAA Environment |
| <a name="output_mwaa_security_group_id"></a> [mwaa\_security\_group\_id](#output\_mwaa\_security\_group\_id) | Security group id of the MWAA Environment |
| <a name="output_mwaa_service_role_arn"></a> [mwaa\_service\_role\_arn](#output\_mwaa\_service\_role\_arn) | The Service Role ARN of the Amazon MWAA Environment |
| <a name="output_mwaa_status"></a> [mwaa\_status](#output\_mwaa\_status) | The status of the Amazon MWAA Environment |
| <a name="output_mwaa_webserver_url"></a> [mwaa\_webserver\_url](#output\_mwaa\_webserver\_url) | The webserver URL of the MWAA Environment |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
