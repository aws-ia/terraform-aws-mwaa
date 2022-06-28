#####################################################################################
# Terraform module examples are meant to show an _example_ on how to use a module
# per use-case. The code below should not be copied directly but referenced in order
# to build your own root module that invokes this module
#####################################################################################
provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 2)
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

  airflow_configuration_options = { # Checkout the suggested Airflow configurations under https://docs.aws.amazon.com/mwaa/latest/userguide/configuring-env-variables.html
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
  min_workers        = 1
  max_workers        = 25
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets

  webserver_access_mode = "PUBLIC_ONLY"   # Choose the Private network option(PRIVATE_ONLY) if your Apache Airflow UI is only accessed within a corporate network, and you do not require access to public repositories for web server requirements installation
  source_cidr           = ["10.1.0.0/16"] # Add your IP here to access Airflow UI

  # create_security_group = true # change to to `false` to bring your sec group using `security_group_ids`
  # source_bucket_arn = "<ENTER_S3_BUCKET_ARN>" # Module creates a new S3 bucket if `source_bucket_arn` is not specified
  # execution_role_arn = "<ENTER_YOUR_IAM_ROLE_ARN>" # Module creates a new IAM role if `execution_role_arn` is not specified
}

#---------------------------------------------------------------
# Supporting Resources
#---------------------------------------------------------------
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = var.name
  cidr = var.vpc_cidr

  azs             = local.azs
  public_subnets  = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k)]
  private_subnets = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 10)]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = var.tags
}
