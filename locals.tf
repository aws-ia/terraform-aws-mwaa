locals {
  execution_role_arn = var.execution_role_arn != null ? var.execution_role_arn : aws_iam_role.mwaa[0].arn

  security_group_ids = length(var.security_group_ids) > 0 ? var.security_group_ids : [aws_security_group.mwaa[0].id]

  source_bucket_arn = var.source_bucket_arn != null ? var.source_bucket_arn : aws_s3_bucket.mwaa[0].arn

  default_airflow_configuration_options = {
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

  airflow_configuration_options = merge(local.default_airflow_configuration_options, var.airflow_configuration_options)

  //  iam_role_additional_policies = { for k, v in toset(concat([
  //    "${local.policy_arn_prefix}/AmazonEKSWorkerNodePolicy",
  //    "${local.policy_arn_prefix}/AmazonEKS_CNI_Policy",
  //    "${local.policy_arn_prefix}/AmazonEC2ContainerRegistryReadOnly",
  //    "${local.policy_arn_prefix}/AmazonSSMManagedInstanceCore"],
  //  local.managed_node_group["additional_iam_policies"
  //  ])) : k => v if local.managed_node_group["create_iam_role"] }

  iam_role_additional_policies = { for k, v in toset(concat([var.iam_role_additional_policies])) : k => v if var.execution_role_arn != null }
}
