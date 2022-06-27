#####################################################################################
# Terraform module examples are meant to show an _example_ on how to use a module
# per use-case. The code below should not be copied directly but referenced in order
# to build your own root module that invokes this module
#####################################################################################

module "mwaa" {
  source               = "../../.."
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
