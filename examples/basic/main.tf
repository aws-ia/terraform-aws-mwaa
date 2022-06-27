#####################################################################################
# Terraform module examples are meant to show an _example_ on how to use a module
# per use-case. The code below should not be copied directly but referenced in order
# to build your own root module that invokes this module
#####################################################################################
provider "aws" {
  region = var.region
}

#-----------------------------------------------------------
# NOTE: MWAA Airflow environment takes minimum of 20 mins
#-----------------------------------------------------------
module "mwaa" {
  source = "../.."

  name                 = "basic-mwaa"
  airflow_version      = "2.2.2"
  environment_class    = "mw1.medium"
  dag_s3_path          = "dags"
  plugins_s3_path      = "plugins.zip"
  requirements_s3_path = "requirements.txt"

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
  min_workers           = 1
  max_workers           = 25
  vpc_id                = var.vpc_id
  private_subnet_ids    = var.private_subnet_ids
  webserver_access_mode = "PUBLIC_ONLY"   # Change this to PRIVATE_ONLY for production environments
  source_cidr           = ["10.1.0.0/16"] # Add your IP here to access Airflow UI

  # create_security_group = true # change to to `false` to bring your sec group using `security_group_ids`
  # source_bucket_arn = "<ENTER_S3_BUCKET_ARN>" # Module creates a new S3 bucket if `source_bucket_arn` is not specified
  # execution_role_arn = "<ENTER_YOUR_IAM_ROLE_ARN>" # Module creates a new IAM role if `execution_role_arn` is not specified
}
