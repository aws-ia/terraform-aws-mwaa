locals {
  execution_role_arn = var.execution_role_arn != null ? var.execution_role_arn : aws_iam_role.mwaa[0].arn

  security_group_ids = length(var.security_group_ids) > 0 ? var.security_group_ids : [aws_security_group.mwaa[0].id]

  source_bucket_arn = var.source_bucket_arn != null ? var.source_bucket_arn : aws_s3_bucket.mwaa[0].arn

  default_airflow_configuration_options = {
    "logging.logging_level" = "INFO"
  }

  airflow_configuration_options = merge(local.default_airflow_configuration_options, var.airflow_configuration_options)

  iam_role_additional_policies = { for k, v in toset(concat([var.iam_role_additional_policies])) : k => v if var.execution_role_arn != null }
}
