resource "aws_cloudwatch_log_group" "lambda" {
  count = var.mod_count

  name              = "/aws/lambda/${var.name}"
  retention_in_days = var.log_retention
  tags              = var.tags
}

resource "aws_cloudwatch_metric_alarm" "duration" {
  count = local.alerting == true ? var.mod_count : 0

  alarm_name          = "${aws_lambda_function.lambda[count.index].function_name}-duration"
  alarm_actions       = [var.sns_topic_arn]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "Duration"
  namespace           = "AWS/Lambda"
  period              = "120"
  statistic           = "Maximum"
  threshold           = "500"
  alarm_description   = "This metric monitors duration of ${aws_lambda_function.lambda[count.index].function_name} lambda"

  dimensions = {
    FunctionName = aws_lambda_function.lambda[count.index].function_name
  }
}

resource "aws_cloudwatch_metric_alarm" "throttles" {
  count = local.alerting == true ? var.mod_count : 0

  alarm_name          = "${aws_lambda_function.lambda[count.index].function_name}-throttles"
  alarm_actions       = [var.sns_topic_arn]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "Throttles"
  namespace           = "AWS/Lambda"
  period              = "120"
  statistic           = "Maximum"
  threshold           = "25"
  alarm_description   = "This metric monitors throttles of ${aws_lambda_function.lambda[count.index].function_name} lambda"

  dimensions = {
    FunctionName = aws_lambda_function.lambda[count.index].function_name
  }
}

resource "aws_cloudwatch_metric_alarm" "invocations" {
  count = local.alerting == true ? var.mod_count : 0

  alarm_name          = "${aws_lambda_function.lambda[count.index].function_name}-invocations"
  alarm_actions       = [var.sns_topic_arn]
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "Invocations"
  namespace           = "AWS/Lambda"
  period              = "120"
  statistic           = "Sum"
  threshold           = "25"
  alarm_description   = "This metric monitors invocations of ${aws_lambda_function.lambda[count.index].function_name} lambda"

  dimensions = {
    FunctionName = aws_lambda_function.lambda[count.index].function_name
  }
}

resource "aws_cloudwatch_metric_alarm" "errors" {
  count = local.alerting == true ? var.mod_count : 0

  alarm_name          = "${aws_lambda_function.lambda[count.index].function_name}-errors"
  alarm_actions       = [var.sns_topic_arn]
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = "120"
  statistic           = "Maximum"
  threshold           = "25"
  alarm_description   = "This metric monitors errors of ${aws_lambda_function.lambda[count.index].function_name} lambda"

  dimensions = {
    FunctionName = aws_lambda_function.lambda[count.index].function_name
  }
}
