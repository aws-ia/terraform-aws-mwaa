locals {
  execution_role_arn = var.create_iam_role ? aws_iam_role.mwaa[0].arn : var.execution_role_arn

  security_group_ids = var.create_security_group ? concat([aws_security_group.mwaa[0].id], var.security_group_ids) : var.security_group_ids

  source_bucket_arn = var.create_s3_bucket ? aws_s3_bucket.mwaa[0].arn : data.aws_s3_bucket.selected.arn

  default_airflow_configuration_options = {
    "logging.logging_level" = "INFO"
  }

  airflow_configuration_options = merge(local.default_airflow_configuration_options, var.airflow_configuration_options)

  iam_role_additional_policies = { for k, v in var.iam_role_additional_policies : k => v if var.create_iam_role }
}
