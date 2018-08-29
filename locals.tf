locals {
  lambda_arn = "${var.edge == "true" ? aws_lambda_function.lambda_edge.*.arn : aws_lambda_function.lambda.*.arn}"
  lambda_invoke_arn = "${var.edge == "true" ? aws_lambda_function.lambda_edge.*.invoke_arn : aws_lambda_function.lambda.*.invoke_arn}"
  lambda_role_arn = "${aws_iam_role.lambda.*.arn}"
}
