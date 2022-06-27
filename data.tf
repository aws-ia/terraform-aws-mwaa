data "aws_partition" "current" {}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

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

    principals {
      type        = "Service"
      identifiers = ["batch.amazonaws.com"]
    }

    principals {
      type        = "Service"
      identifiers = ["ssm.amazonaws.com"]
    }
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }
  }
}
#tfsec:ignore:AWS099
data "aws_iam_policy_document" "mwaa" {
  statement {
    effect = "Allow"
    actions = [
      "airflow:PublishMetrics",
      "airflow:CreateWebLoginToken"
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
      local.source_bucket_arn,
      "${local.source_bucket_arn}/*"
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
      "cloudwatch:PutMetricData",
      "batch:DescribeJobs",
      "batch:ListJobs",
      "eks:*"
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
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:GenerateDataKey*",
      "kms:Encrypt"
    ]
    not_resources = [
      "arn:${data.aws_partition.current.id}:kms:*:${data.aws_caller_identity.current.account_id}:key/*"
    ]
    condition {
      test     = "StringLike"
      variable = "kms:ViaService"

      values = [
        "sqs.${data.aws_region.current.name}.amazonaws.com"
      ]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "batch:*",
    ]
    resources = [
      "arn:${data.aws_partition.current.id}:batch:*:${data.aws_caller_identity.current.account_id}:*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ssm:*"
    ]
    resources = [
      "arn:${data.aws_partition.current.id}:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "logs:*"
    ]
    resources = ["arn:${data.aws_partition.current.id}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/*"]
  }

  statement {
    effect    = "Allow"
    actions   = ["cloudwatch:*"]
    resources = ["arn:${data.aws_partition.current.id}:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/*"]
  }
}
