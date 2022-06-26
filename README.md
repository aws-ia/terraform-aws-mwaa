<!-- BEGIN_TF_DOCS -->
# Amazon Managed Workflows for Apache Airflow (MWAA) - Terraform Module

Terraform module for create an Amazon Managed Workflows for Apache Airflow (MWAA) environment.
The module will create the following resources:
 - MWAA Environment
 - MWAA Service IAM Role and IAM Policy
 - MWAA S3 Bucket(To Store Dags, Plugins, Requirements.txt file,etc)
 - MWAA Security Group

 ## Usage

```hcl
module "mwaa" {
  source               = "aws-ia/mwaa/aws"
  environment_name     = "mwaa-dev"
  airflow_version      = "2.2.2"
  environment_class    = "mw1.medium"
  dag_s3_path          = "dags"
  plugins_s3_path      = "plugins.zip"
  requirements_s3_path = "dags/requirements.txt"
  logging_configuration = {
    "dag_processing_logs" = {
      enabled   = true
      log_level = "INFO"
    }

    "scheduler_logs" = {
      enabled   = true
      log_level = "INFO"
    }

    "task_logs" = {
      enabled   = true
      log_level = "INFO"
    }

    "webserver_logs" = {
      enabled   = true
      log_level = "INFO"
    }

    "worker_logs" = {
      enabled   = true
      log_level = "INFO"
    }
  }
  airflow_configuration_options = {
    "core.default_task_retries"         = 3
    "celery.worker_autoscale"           = "5,5"
    "core.check_slas"                   = "false"
    "core.dag_concurrency"              = 96
    "core.dag_file_processor_timeout"   = 600
    "core.dagbag_import_timeout"        = 600
    "core.max_active_runs_per_dag"      = 32
    "core.parallelism"                  = 64
    "scheduler.processor_poll_interval" = 15
    log_level                           = "INFO"
    dag_timeout                         = 480
    "webserver_timeout" = {
      master = 480
      worker = 480
    }
  }
  min_workers           = 1
  max_workers           = 25
  vpc_id                = "VPC-XXXXX"
  private_subnet_ids    = ["subnet-XXXXXX", "subnet-XXXXXX"]
  webserver_access_mode = "PUBLIC_ONLY"
  source_cidr           = ["10.0.0.0/16"] #Add your IP here to access Airflow UI
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.72.0 |
| <a name="requirement_awscc"></a> [awscc](#requirement\_awscc) | >= 0.21.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.72.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.mwaa_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.mwaa_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_mwaa_environment.aws_mwaa_environment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/mwaa_environment) | resource |
| [aws_s3_bucket.mwaa_content](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.mwaa_content](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_public_access_block.mwaa_public_access_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_versioning.mwaa_content](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_object.plugins](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_s3_object.python_requirements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_security_group.mwaa_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.mwaa_sg_inbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.mwaa_sg_inbound_vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.mwaa_sg_outbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.mwaa_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.mwaa_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_airflow_configuration_options"></a> [airflow\_configuration\_options](#input\_airflow\_configuration\_options) | (Optional) The airflow\_configuration\_options parameter specifies airflow override options. | `any` | n/a | yes |
| <a name="input_airflow_version"></a> [airflow\_version](#input\_airflow\_version) | (Optional) Airflow version of your environment, will be set by default to the latest version that MWAA supports. | `any` | n/a | yes |
| <a name="input_environment_class"></a> [environment\_class](#input\_environment\_class) | (Optional) Environment class for the cluster. Possible options are mw1.small, mw1.medium, mw1.large. Will be set by default to mw1.small. Please check the AWS Pricing for more information about the environment classes. | `any` | n/a | yes |
| <a name="input_environment_name"></a> [environment\_name](#input\_environment\_name) | (Required) Name of MWAA Environment | `any` | n/a | yes |
| <a name="input_logging_configuration"></a> [logging\_configuration](#input\_logging\_configuration) | The Apache Airflow logs which will be send to Amazon CloudWatch Logs. | `any` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | (Required) The private subnet IDs in which the environment should be created. MWAA requires two subnets. | `list(string)` | n/a | yes |
| <a name="input_source_cidr"></a> [source\_cidr](#input\_source\_cidr) | (Required) Source CIDR block which will be  allowed on MWAA SG to access Airflow UI | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | (Required) VPC ID to deploy the MWAA Environment. | `any` | n/a | yes |
| <a name="input_webserver_access_mode"></a> [webserver\_access\_mode](#input\_webserver\_access\_mode) | (Optional) Specifies whether the webserver should be accessible over the internet or via your specified VPC. Possible options: PRIVATE\_ONLY (default) and PUBLIC\_ONLY. | `any` | n/a | yes |
| <a name="input_dag_s3_path"></a> [dag\_s3\_path](#input\_dag\_s3\_path) | (Required) The relative path to the DAG folder on your Amazon S3 storage bucket. For example, dags. | `string` | `"dags"` | no |
| <a name="input_max_workers"></a> [max\_workers](#input\_max\_workers) | (Optional) The maximum number of workers that can be automatically scaled up. Value need to be between 1 and 25. Will be 10 by default. | `number` | `10` | no |
| <a name="input_min_workers"></a> [min\_workers](#input\_min\_workers) | (Optional) The minimum number of workers that you want to run in your environment. Will be 1 by default. | `number` | `1` | no |
| <a name="input_plugins_s3_path"></a> [plugins\_s3\_path](#input\_plugins\_s3\_path) | (Optional) The relative path to the plugins.zip file on your Amazon S3 storage bucket. For example, plugins.zip. If a relative path is provided in the request, then plugins\_s3\_object\_version is required. | `string` | `"plugins.zip"` | no |
| <a name="input_requirements_s3_path"></a> [requirements\_s3\_path](#input\_requirements\_s3\_path) | (Optional) The relative path to the requirements.txt file on your Amazon S3 storage bucket. For example, requirements.txt. If a relative path is provided in the request, then requirements\_s3\_object\_version is required. | `string` | `"requirements.txt"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_s3_bucket"></a> [aws\_s3\_bucket](#output\_aws\_s3\_bucket) | n/a |
| <a name="output_mwaa_arn"></a> [mwaa\_arn](#output\_mwaa\_arn) | n/a |
| <a name="output_mwaa_role_arn"></a> [mwaa\_role\_arn](#output\_mwaa\_role\_arn) | n/a |
| <a name="output_mwaa_role_name"></a> [mwaa\_role\_name](#output\_mwaa\_role\_name) | n/a |
| <a name="output_mwaa_security_group"></a> [mwaa\_security\_group](#output\_mwaa\_security\_group) | n/a |
| <a name="output_mwaa_webserver_url"></a> [mwaa\_webserver\_url](#output\_mwaa\_webserver\_url) | n/a |
<!-- END_TF_DOCS -->