locals {
  lambda_arn            = join("", aws_lambda_function.lambda.*.arn)
  lambda_invoke_arn     = join("", aws_lambda_function.lambda.*.invoke_arn)
  lambda_qualified_arn  = join("", aws_lambda_function.lambda.*.qualified_arn)
  lambda_version        = join(",", aws_lambda_function.lambda.*.version)
  lambda_function_name  = join(",", aws_lambda_function.lambda.*.function_name)
  lambda_role_arn       = var.lambda_role == "" ? join("", aws_iam_role.lambda.*.arn) : join("", data.aws_iam_role.lambda.*.arn)
  lambda_role_name      = var.lambda_role == "" ? join("", aws_iam_role.lambda.*.name) : join("", data.aws_iam_role.lambda.*.name)
  lambda_role_unique_id = var.lambda_role == "" ? join("", aws_iam_role.lambda.*.unique_id) : join("", data.aws_iam_role.lambda.*.unique_id)
  lambda_role_id        = var.lambda_role == "" ? join("", aws_iam_role.lambda.*.id) : join("", data.aws_iam_role.lambda.*.id)
}
