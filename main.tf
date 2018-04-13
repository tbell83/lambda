resource "aws_lambda_function" "lambda" {
  s3_bucket     = "${var.s3_bucket}"
  s3_key        = "${var.s3_key}"
  function_name = "${var.name}"
  runtime       = "${var.runtime}"
  handler       = "${var.handler}"
  tags          = "${var.tags}"
  description   = "${var.description}"
  memory_size   = "${var.memory_size}"
  timeout       = "${var.timeout}"
  role          = "${aws_iam_role.lambda.arn}"

  vpc_config {
    subnet_ids         = ["${compact(split(",", "${length(var.vpc_config_security_group_ids) != 0 && length(var.vpc_config_subnet_ids) != 0 ? "${join(",", var.vpc_config_subnet_ids)}" : ""}"))}"]
    security_group_ids = ["${compact(split(",", "${length(var.vpc_config_security_group_ids) != 0 && length(var.vpc_config_subnet_ids) != 0 ? "${join(",", var.vpc_config_security_group_ids)}" :  ""}"))}"]
  }

  environment {
    variables = "${var.environment_variables}"
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
