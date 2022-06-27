output "mwaa_webserver_url" {
  description = "The webserver URL of the MWAA Environment"
  value       = aws_mwaa_environment.mwaa.webserver_url
}

output "mwaa_arn" {
  description = "The ARN of the MWAA Environment"
  value       = aws_mwaa_environment.mwaa.arn
}

output "mwaa_service_role_arn" {
  description = "The Service Role ARN of the Amazon MWAA Environment"
  value       = aws_mwaa_environment.mwaa.service_role_arn
}

output "mwaa_status" {
  description = " The status of the Amazon MWAA Environment"
  value       = aws_mwaa_environment.mwaa.status
}

output "mwaa_role_arn" {
  description = "The ARN of the MWAA Environment"
  value       = var.execution_role_arn == null ? aws_iam_role.mwaa[0].arn : ""
}

output "mwaa_role_name" {
  description = "The ARN of the MWAA Environment"
  value       = var.execution_role_arn == null ? aws_iam_role.mwaa[0].id : ""
}

output "mwaa_security_group" {
  description = "The ARN of the MWAA Environment"
  value       = var.create_security_group == true ? aws_security_group.mwaa[0].id : ""
}

output "aws_s3_bucket" {
  description = "The ARN of the MWAA Environment"
  value       = var.source_bucket_arn == null ? aws_s3_bucket.mwaa[0].id : ""
}