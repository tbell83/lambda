output "lambda_invoke_arn" {
  count = "${var.count}"
  value = "${aws_lambda_function.lambda.invoke_arn}"
}

output "lambda_arn" {
  count = "${var.count}"
  value = "${aws_lambda_function.lambda.arn}"
}
