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

variable "vpc_id" {
  description = "VPC Id for MWAA Security groups"
  default     = "vpc-0a8bc75bb6754df82"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet CIDRs for MWAA environment"
  default     = ["subnet-014a974fbd4d17b5f", "subnet-0df42f1af3be0dc32"]
  type        = list(string)
}