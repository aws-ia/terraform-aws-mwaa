locals {
  execution_role_arn = var.create_iam_role ? aws_iam_role.mwaa[0].arn : var.execution_role_arn

  security_group_ids = var.create_security_group ? concat([aws_security_group.mwaa[0].id], var.security_group_ids) : var.security_group_ids

  source_bucket_arn = var.create_s3_bucket ? aws_s3_bucket.mwaa[0].arn : var.source_bucket_arn

  source_bucket_prefix = var.source_bucket_name == null ? format("%s-%s-", "mwaa", data.aws_caller_identity.current.account_id) : (var.use_source_bucket_name_as_prefix ? var.source_bucket_name : null)

  source_bucket_name = local.source_bucket_prefix != null ? null : var.source_bucket_name

  default_airflow_configuration_options = {
    "logging.logging_level" = "INFO"
  }

  airflow_configuration_options = merge(local.default_airflow_configuration_options, var.airflow_configuration_options)

  iam_role_additional_policies = { for k, v in var.iam_role_additional_policies : k => v if var.create_iam_role }
}
