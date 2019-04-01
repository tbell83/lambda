resource "aws_iam_role" "lambda" {
  count = "${var.lambda_role == "" && var.count > 0 ? 1 : 0}"

  name               = "${var.name}"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role.json}"
}

data "aws_iam_policy_document" "assume_role" {
  count = "${var.count}"

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["${compact(list(
        "lambda.amazonaws.com",
        "${var.edge == "true" ? "edgelambda.amazonaws.com" : ""}"
      ))}"]

      type = "Service"
    }
  }
}

resource "aws_iam_policy" "lambda" {
  count = "${var.count}"

  name   = "${var.lambda_policy_name != "" ? var.lambda_policy_name : "${var.name}_lambda_execution_policy_${data.aws_region.current.name}"}"
  path   = "/lambda_module/"
  policy = "${data.aws_iam_policy_document.lambda.json}"
}

resource "aws_iam_role_policy_attachment" "lambda-lambda" {
  count = "${var.count}"

  role       = "${var.lambda_role != "" ? join("", data.aws_iam_role.lambda.*.name) : join("", aws_iam_role.lambda.*.name)}"
  policy_arn = "${aws_iam_policy.lambda.arn}"
}

data "aws_iam_policy_document" "lambda" {
  count = "${var.count}"

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
  count  = "${length(var.vpc_config_security_group_ids) != 0 && length(var.vpc_config_subnet_ids) != 0 ? var.count : 0 }"
  name   = "${var.name}_in_vpc"
  path   = "/lambda_module/"
  policy = "${data.aws_iam_policy_document.in_vpc.json}"
}

resource "aws_iam_role_policy_attachment" "lambda-in_vpc" {
  count      = "${length(var.vpc_config_security_group_ids) != 0 && length(var.vpc_config_subnet_ids) != 0 ? var.count : 0 }"
  role       = "${var.lambda_role != "" ? join("", data.aws_iam_role.lambda.*.name) : join("", aws_iam_role.lambda.*.name)}"
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
