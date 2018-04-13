resource "aws_iam_role" "lambda" {
  name               = "${var.name}"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role.json}"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_policy" "lambda" {
  name   = "lambda_execution_policy"
  path   = "/${var.name}/"
  policy = "${data.aws_iam_policy_document.lambda.json}"
}

resource "aws_iam_role_policy_attachment" "lambda-lambda" {
  role       = "${aws_iam_role.lambda.name}"
  policy_arn = "${aws_iam_policy.lambda.arn}"
}

data "aws_iam_policy_document" "lambda" {
  source_json = "${var.lambda_role_policy_json}"

  statement {
    sid       = "CreateCloudwatchLogGroups"
    resources = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"]
    actions   = ["logs:CreateLogGroup"]
  }

  statement {
    sid       = "WriteCloudwatchLogs"
    resources = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.name}:*"]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
}

resource "aws_iam_policy" "in_vpc" {
  count  = "${length(var.vpc_config_security_group_ids) != 0 && length(var.vpc_config_subnet_ids) != 0 ? 1 : 0 }"
  name   = "in_vpc"
  path   = "/${var.name}/"
  policy = "${data.aws_iam_policy_document.in_vpc.json}"
}

resource "aws_iam_role_policy_attachment" "lambda-in_vpc" {
  count      = "${length(var.vpc_config_security_group_ids) != 0 && length(var.vpc_config_subnet_ids) != 0 ? 1 : 0 }"
  role       = "${aws_iam_role.lambda.name}"
  policy_arn = "${aws_iam_policy.in_vpc.arn}"
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
