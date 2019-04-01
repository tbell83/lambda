resource "aws_lambda_function" "lambda" {
  count = "${var.edge == "false" && var.s3_bucket != "" && var.s3_key != "" ? var.count : 0}"

  s3_bucket     = "${var.s3_bucket}"
  s3_key        = "${var.s3_key}"
  function_name = "${var.lambda_function_name != "" ? var.lambda_function_name : var.name}"
  runtime       = "${var.runtime}"
  handler       = "${var.handler}"
  tags          = "${var.tags}"
  description   = "${var.description}"
  memory_size   = "${var.memory_size}"
  timeout       = "${var.timeout}"
  role          = "${var.lambda_role != "" ? join("", data.aws_iam_role.lambda.*.arn) : join("", aws_iam_role.lambda.*.arn)}"

  vpc_config {
    subnet_ids         = ["${compact(split(",", "${length(var.vpc_config_security_group_ids) != 0 && length(var.vpc_config_subnet_ids) != 0 ? "${join(",", var.vpc_config_subnet_ids)}" : ""}"))}"]
    security_group_ids = ["${compact(split(",", "${length(var.vpc_config_security_group_ids) != 0 && length(var.vpc_config_subnet_ids) != 0 ? "${join(",", var.vpc_config_security_group_ids)}" :  ""}"))}"]
  }

  environment {
    variables = "${var.environment_variables}"
  }
}

resource "aws_lambda_function" "lambda_edge" {
  count = "${var.edge == "true" && var.s3_bucket != "" && var.s3_key != "" ? var.count : 0}"

  s3_bucket     = "${var.s3_bucket}"
  s3_key        = "${var.s3_key}"
  function_name = "${var.lambda_function_name != "" ? var.lambda_function_name : var.name}"
  runtime       = "${var.runtime}"
  handler       = "${var.handler}"
  tags          = "${var.tags}"
  description   = "${var.description}"
  memory_size   = "${var.memory_size}"
  timeout       = "${var.timeout}"
  role          = "${var.lambda_role != "" ? join("", data.aws_iam_role.lambda.*.arn) : join("", aws_iam_role.lambda.*.arn)}"

  vpc_config {
    subnet_ids         = ["${compact(split(",", "${length(var.vpc_config_security_group_ids) != 0 && length(var.vpc_config_subnet_ids) != 0 ? "${join(",", var.vpc_config_subnet_ids)}" : ""}"))}"]
    security_group_ids = ["${compact(split(",", "${length(var.vpc_config_security_group_ids) != 0 && length(var.vpc_config_subnet_ids) != 0 ? "${join(",", var.vpc_config_security_group_ids)}" :  ""}"))}"]
  }
}

resource "aws_lambda_function" "lambda_file" {
  count = "${var.edge == "false" && var.filename != "" ? var.count : 0}"

  filename      = "${var.filename}"
  function_name = "${var.name}"
  runtime       = "${var.runtime}"
  handler       = "${var.handler}"
  tags          = "${var.tags}"
  description   = "${var.description}"
  memory_size   = "${var.memory_size}"
  timeout       = "${var.timeout}"
  role          = "${var.lambda_role != "" ? join("", data.aws_iam_role.lambda.*.arn) : join("", aws_iam_role.lambda.*.arn)}"

  vpc_config {
    subnet_ids         = ["${compact(split(",", "${length(var.vpc_config_security_group_ids) != 0 && length(var.vpc_config_subnet_ids) != 0 ? "${join(",", var.vpc_config_subnet_ids)}" : ""}"))}"]
    security_group_ids = ["${compact(split(",", "${length(var.vpc_config_security_group_ids) != 0 && length(var.vpc_config_subnet_ids) != 0 ? "${join(",", var.vpc_config_security_group_ids)}" :  ""}"))}"]
  }

  environment {
    variables = "${var.environment_variables}"
  }
}

resource "aws_lambda_function" "lambda_edge_file" {
  count = "${var.edge == "true" && var.filename != "" ? var.count : 0}"

  filename      = "${var.filename}"
  function_name = "${var.lambda_function_name != "" ? var.lambda_function_name : var.name}"
  runtime       = "${var.runtime}"
  handler       = "${var.handler}"
  tags          = "${var.tags}"
  description   = "${var.description}"
  memory_size   = "${var.memory_size}"
  timeout       = "${var.timeout}"
  role          = "${var.lambda_role != "" ? join("", data.aws_iam_role.lambda.*.arn) : join("", aws_iam_role.lambda.*.arn)}"

  vpc_config {
    subnet_ids         = ["${compact(split(",", "${length(var.vpc_config_security_group_ids) != 0 && length(var.vpc_config_subnet_ids) != 0 ? "${join(",", var.vpc_config_subnet_ids)}" : ""}"))}"]
    security_group_ids = ["${compact(split(",", "${length(var.vpc_config_security_group_ids) != 0 && length(var.vpc_config_subnet_ids) != 0 ? "${join(",", var.vpc_config_security_group_ids)}" :  ""}"))}"]
  }
}
