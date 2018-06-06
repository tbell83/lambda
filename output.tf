output "lambda_invoke_arn" {
  value = "${aws_lambda_function.lambda.*.invoke_arn}"
}

output "lambda_arn" {
  value = "${aws_lambda_function.lambda.*.arn}"
}

output "lambda_role_arn" {
  value = "${aws_iam_role.lambda.arn}"
}
