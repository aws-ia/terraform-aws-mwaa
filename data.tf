data "aws_partition" "current" {}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_s3_bucket" "selected" {
  bucket = var.source_bucket_name
}

data "aws_kms_key" "by_alias" {
  key_id = var.kms_key
}
# ---------------------------------------------------------------------------------------------------------------------
# MWAA Role
# ---------------------------------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "mwaa_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["airflow.amazonaws.com"]
    }

    principals {
      type        = "Service"
      identifiers = ["airflow-env.amazonaws.com"]
    }

  }
}
#tfsec:ignore:AWS099
data "aws_iam_policy_document" "mwaa" {
  statement {
    effect = "Allow"
    actions = [
      "airflow:PublishMetrics"
    ]
    resources = [
      "arn:${data.aws_partition.current.id}:airflow:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:environment/${var.name}"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:*"
    ]
    resources = [
      data.aws_s3_bucket.selected.arn,
      "${data.aws_s3_bucket.selected.arn}/*"
    ]
  }
# Restrict Public Access 
  statement {
    effect = "Allow"
    actions =  [
        "s3:GetAccountPublicAccessBlock"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:PutLogEvents",
      "logs:GetLogEvents",
      "logs:GetLogRecord",
      "logs:GetLogGroupFields",
      "logs:GetQueryResults"
    ]
    resources = [
      "arn:${data.aws_partition.current.id}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:airflow-${var.name}-*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:DescribeLogGroups",
      "cloudwatch:PutMetricData"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "sqs:ChangeMessageVisibility",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:ReceiveMessage",
      "sqs:SendMessage"
    ]
    resources = [
      "arn:${data.aws_partition.current.id}:sqs:${data.aws_region.current.name}:*:airflow-celery-*"
    ]
  }

  statement {
    effect        = "Allow"
    actions       = [
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:GenerateDataKey*",
      "kms:Encrypt",
      "kms:PutKeyPolicy"
    ]
    resources     = data.aws_kms_key.by_alias.arn != null ? [
      data.aws_kms_key.by_alias.arn
    ] : []
    not_resources = data.aws_kms_key.by_alias.arn == null ? [
      "arn:aws:kms:*:${data.aws_caller_identity.current.account_id}:key/*"
    ] : []
    condition {
      test     = "StringLike"
      values   = data.aws_kms_key.by_alias.arn != null ? [
        "sqs.${data.aws_region.current.name}.amazonaws.com" ] : [
        "sqs.${data.aws_region.current.name}.amazonaws.com"
      ]
      variable = "kms:ViaService"
    }
  }

}
