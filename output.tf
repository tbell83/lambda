output "cloudwatch_log_group" {
  value = aws_cloudwatch_log_group.lambda
}

output "iam_role" {
  value = local.role == true ? aws_iam_role.lambda : data.aws_iam_role.lambda
}

output "iam_policy" {
  value = aws_iam_policy.lambda
}

output "lambda_function" {
  value = aws_lambda_function.lambda
}
