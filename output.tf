output "iam_role" {
  value = local.role == true ? aws_iam_role.lambda : data.aws_iam_role.lambda
}

output "iam_policy" {
  value = aws_iam_policy.lambda
}

output "lambda_function" {
  value = aws_lambda_function.lambda
}

output "cloudwatch_log_group" {
  value = aws_cloudwatch_log_group.lambda
}

output "cloudwatch_metric_alarm_throttles" {
  value = aws_cloudwatch_metric_alarm.throttles
}

output "cloudwatch_metric_alarm_duration" {
  value = aws_cloudwatch_metric_alarm.duration
}

output "cloudwatch_metric_alarm_invocations" {
  value = aws_cloudwatch_metric_alarm.invocations
}

output "cloudwatch_metric_alarm_errors" {
  value = aws_cloudwatch_metric_alarm.errors
}
