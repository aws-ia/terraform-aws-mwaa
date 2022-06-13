variable "environment_name" {
  description = "(Required) Name of MWAA Environment"
}

variable "airflow_version" {
  description = "(Optional) Airflow version of your environment, will be set by default to the latest version that MWAA supports."
}

variable "environment_class" {
  description = "(Optional) Environment class for the cluster. Possible options are mw1.small, mw1.medium, mw1.large. Will be set by default to mw1.small. Please check the AWS Pricing for more information about the environment classes."
}

variable "dag_s3_path" {
  description = "(Required) The relative path to the DAG folder on your Amazon S3 storage bucket. For example, dags."
  default     = "dags"
}

variable "plugins_s3_path" {
  description = "(Optional) The relative path to the plugins.zip file on your Amazon S3 storage bucket. For example, plugins.zip. If a relative path is provided in the request, then plugins_s3_object_version is required."
  default     = "plugins.zip"
}

variable "requirements_s3_path" {
  description = "(Optional) The relative path to the requirements.txt file on your Amazon S3 storage bucket. For example, requirements.txt. If a relative path is provided in the request, then requirements_s3_object_version is required."
  default     = "requirements.txt"
}

variable "logging_configuration" {
  description = "The Apache Airflow logs which will be send to Amazon CloudWatch Logs."
  type        = any
}

variable "airflow_configuration_options" {
  description = "(Optional) The airflow_configuration_options parameter specifies airflow override options."
  type        = any
}

variable "min_workers" {
  description = "(Optional) The minimum number of workers that you want to run in your environment. Will be 1 by default."
  default     = 1
}

variable "max_workers" {
  description = "(Optional) The maximum number of workers that can be automatically scaled up. Value need to be between 1 and 25. Will be 10 by default."
  default     = 10
}

variable "vpc_id" {
  description = "(Required) VPC ID to deploy the MWAA Environment."
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "(Required) The private subnet IDs in which the environment should be created. MWAA requires two subnets."
}

variable "source_cidr" {
  description = "(Required) Source CIDR block which will be  allowed on MWAA SG to access Airflow UI"
}

variable "webserver_access_mode" {
  description = "(Optional) Specifies whether the webserver should be accessible over the internet or via your specified VPC. Possible options: PRIVATE_ONLY (default) and PUBLIC_ONLY."
}

