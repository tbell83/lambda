resource "aws_iam_role" "lambda" {
  count = local.role == true ? var.mod_count : 0

  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.assume_role[count.index].json
}

data "aws_iam_policy_document" "assume_role" {
  count = var.mod_count

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = compact(list(
        "lambda.amazonaws.com",
        local.edge == true ? "edgelambda.amazonaws.com" : ""
      ))

      type = "Service"
    }

    dynamic "principals" {
      for_each = length(var.assume_principals) > 0 ? [1] : []
      content {
        type        = "AWS"
        identifiers = var.assume_principals
      }
    }
  }
}

resource "aws_iam_policy" "lambda" {
  count = var.mod_count

  name   = var.lambda_policy_name != "" ? var.lambda_policy_name : "${var.name}_lambda_execution_policy_${data.aws_region.current[count.index].name}"
  path   = "/lambda_module/"
  policy = data.aws_iam_policy_document.lambda[count.index].json
}

resource "aws_iam_role_policy_attachment" "lambda-lambda" {
  count = var.mod_count

  role       = local.role == true ? aws_iam_role.lambda[count.index].name : data.aws_iam_role.lambda[count.index].name
  policy_arn = aws_iam_policy.lambda[count.index].arn
}

data "aws_iam_policy_document" "lambda" {
  count = var.mod_count

  source_json = var.lambda_role_policy_json

  statement {
    sid       = "CreateCloudwatchLogGroups"
    resources = ["arn:aws:logs:*:${data.aws_caller_identity.current[count.index].account_id}:*"]
    actions   = ["logs:CreateLogGroup"]
  }

  statement {
    sid = "WriteCloudwatchLogs"
    resources = [
      "arn:aws:logs:${data.aws_region.current[count.index].name}:${data.aws_caller_identity.current[count.index].account_id}:log-group:/aws/lambda/${var.name}:*",
      "arn:aws:logs:*:${data.aws_caller_identity.current[count.index].account_id}:log-group:/aws/lambda/*.${var.name}:*",
    ]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
}

resource "aws_iam_role_policy" "in_vpc" {
  count = local.vpc == true ? var.mod_count : 0

  name   = "${var.name}_in_vpc-${data.aws_region.current[count.index].name}"
  role   = local.role == true ? aws_iam_role.lambda[count.index].name : data.aws_iam_role.lambda[count.index].name
  policy = data.aws_iam_policy_document.in_vpc.json
}

data "aws_iam_policy_document" "in_vpc" {
  statement {
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
    ]

    resources = ["*"]
  }
}
