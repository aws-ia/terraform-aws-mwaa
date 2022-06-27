variable "name" {
  description = "Name of MWAA Environment"
  default     = "basic-mwaa"
  type        = string
}

variable "region" {
  description = "region"
  type        = string
  default     = "us-west-2"
}

variable "tags" {
  description = "Default tags"
  default     = {}
  type        = map(string)
}

variable "vpc_cidr" {
  description = "VPC CIDR for MWAA"
  type        = string
  default     = "10.1.0.0/16"
}
