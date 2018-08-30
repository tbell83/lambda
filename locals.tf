locals {
  lambda_arn = "${split(",", var.edge == "true" ? join(",", aws_lambda_function.lambda_edge.*.arn) : join(",", aws_lambda_function.lambda.*.arn))}"
  lambda_invoke_arn = "${split(",", var.edge == "true" ? join(",", aws_lambda_function.lambda_edge.*.invoke_arn) : join(",", aws_lambda_function.lambda.*.invoke_arn))}"
  lambda_role_arn = "${aws_iam_role.lambda.*.arn}"
}
