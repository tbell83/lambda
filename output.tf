output "lambda_invoke_arn" {
  value = "${var.edge == "true" ? aws_lambda_function.lambda_edge.*.invoke_arn : aws_lambda_function.lambda.*.invoke_arn}"
}

output "lambda_arn" {
  value = "${var.edge == "true" ? aws_lambda_function.lambda_edge.*.arn : aws_lambda_function.lambda.*.arn}"
}

output "lambda_role_arn" {
  value = "${aws_iam_role.lambda.*.arn}"
}
