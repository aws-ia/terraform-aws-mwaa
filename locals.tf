locals {
  execution_role_arn = var.execution_role_arn != null ? var.execution_role_arn : aws_iam_role.mwaa[0].arn

  security_group_ids = length(var.security_group_ids) > 0 ? var.security_group_ids : [aws_security_group.mwaa[0].id]

  source_bucket_arn = var.source_bucket_arn != null ? var.source_bucket_arn : aws_s3_bucket.mwaa[0].arn

  default_airflow_configuration_options = {
    "core.default_task_retries"            = 3
    "celery.worker_autoscale"              = "5,5"
    "core.check_slas"                      = "false"
    "core.dag_concurrency"                 = 96
    "core.dag_file_processor_timeout"      = 600
    "core.dagbag_import_timeout"           = 600
    "core.max_active_runs_per_dag"         = 32
    "core.parallelism"                     = 64
    "scheduler.processor_poll_interval"    = 15
    "logging.logging_level"                = "INFO"
    "core.dag_file_processor_timeout"      = 120
    "web_server.web_server_master_timeout" = 480
    "web_server.web_server_worker_timeout" = 480
  }

  airflow_configuration_options = merge(local.default_airflow_configuration_options, var.airflow_configuration_options)

  iam_role_additional_policies = { for k, v in toset(concat([var.iam_role_additional_policies])) : k => v if var.execution_role_arn != null }
}
