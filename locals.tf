locals {
  lambda_arn = "${split(",",
    (var.edge == "true" || var.edge == true) && var.s3_bucket != "" && var.s3_key != "" ?
    join(",", aws_lambda_function.lambda_edge.*.arn) :
    (var.edge == "true" || var.edge == true) && var.filename != "" ?
    join(",", aws_lambda_function.lambda_edge_file.*.arn) :
    (var.edge == "false" || var.edge == false) && var.s3_bucket != "" && var.s3_key != "" ?
    join(",", aws_lambda_function.lambda.*.arn) :
    join(",", aws_lambda_function.lambda_file.*.arn)
  )}"

  lambda_invoke_arn = "${split(",",
    (var.edge == "true" || var.edge == true) && var.s3_bucket != "" && var.s3_key != "" ?
    join(",", aws_lambda_function.lambda_edge.*.invoke_arn) :
    (var.edge == "true" || var.edge == true) && var.filename != "" ?
    join(",", aws_lambda_function.lambda_edge_file.*.invoke_arn) :
    (var.edge == "false" || var.edge == false) && var.s3_bucket != "" && var.s3_key != "" ?
    join(",", aws_lambda_function.lambda.*.invoke_arn) :
    join(",", aws_lambda_function.lambda_file.*.invoke_arn)
  )}"

  lambda_qualified_arn = "${split(",",
    (var.edge == "true" || var.edge == true) && var.s3_bucket != "" && var.s3_key != "" ?
    join(",", aws_lambda_function.lambda_edge.*.qualified_arn) :
    (var.edge == "true" || var.edge == true) && var.filename != "" ?
    join(",", aws_lambda_function.lambda_edge_file.*.qualified_arn) :
    (var.edge == "false" || var.edge == false) && var.s3_bucket != "" && var.s3_key != "" ?
    join(",", aws_lambda_function.lambda.*.qualified_arn) :
    join(",", aws_lambda_function.lambda_file.*.qualified_arn)
  )}"

  lambda_version = "${split(",",
    (var.edge == "true" || var.edge == true) && var.s3_bucket != "" && var.s3_key != "" ?
    join(",", aws_lambda_function.lambda_edge.*.version) :
    (var.edge == "true" || var.edge == true) && var.filename != "" ?
    join(",", aws_lambda_function.lambda_edge_file.*.version) :
    (var.edge == "false" || var.edge == false) && var.s3_bucket != "" && var.s3_key != "" ?
    join(",", aws_lambda_function.lambda.*.version) :
    join(",", aws_lambda_function.lambda_file.*.version)
  )}"

  lambda_function_name = "${split(",",
    (var.edge == "true" || var.edge == true) && var.s3_bucket != "" && var.s3_key != "" ?
    join(",", aws_lambda_function.lambda_edge.*.function_name) :
    (var.edge == "true" || var.edge == true) && var.filename != "" ?
    join(",", aws_lambda_function.lambda_edge_file.*.function_name) :
    (var.edge == "false" || var.edge == false) && var.s3_bucket != "" && var.s3_key != "" ?
    join(",", aws_lambda_function.lambda.*.function_name) :
    join(",", aws_lambda_function.lambda_file.*.function_name)
  )}"

  lambda_role_arn       = "${var.lambda_role == "" ? join("", aws_iam_role.lambda.*.arn) : join("", data.aws_iam_role.lambda.*.arn)}"
  lambda_role_name      = "${var.lambda_role == "" ? join("", aws_iam_role.lambda.*.name) : join("", data.aws_iam_role.lambda.*.name)}"
  lambda_role_unique_id = "${var.lambda_role == "" ? join("", aws_iam_role.lambda.*.unique_id) : join("", data.aws_iam_role.lambda.*.unique_id)}"
  lambda_role_id        = "${var.lambda_role == "" ? join("", aws_iam_role.lambda.*.id) : join("", data.aws_iam_role.lambda.*.id)}"
}
