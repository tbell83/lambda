resource "aws_cloudwatch_log_group" "lambda" {
  count = var.mod_count

  name              = "/aws/lambda/${var.name}"
  retention_in_days = var.log_retention
  tags              = var.tags
}

resource "aws_cloudwatch_metric_alarm" "throttles" {
  count = local.alerting == true ? var.mod_count : 0

  alarm_actions       = [var.sns_topic_arn]
  alarm_description   = "This metric monitors throttles of ${aws_lambda_function.lambda[count.index].function_name} lambda"
  alarm_name          = "${aws_lambda_function.lambda[count.index].function_name}-throttles"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "Throttles"
  namespace           = "AWS/Lambda"
  ok_actions          = [var.sns_topic_arn]
  period              = "120"
  statistic           = "Maximum"
  threshold           = var.alarm_threshold_throttles

  dimensions = {
    FunctionName = aws_lambda_function.lambda[count.index].function_name
  }
}

resource "aws_cloudwatch_metric_alarm" "invocations" {
  count = local.alerting == true ? var.mod_count : 0

  alarm_actions       = [var.sns_topic_arn]
  alarm_description   = "This metric monitors invocations of ${aws_lambda_function.lambda[count.index].function_name} lambda"
  alarm_name          = "${aws_lambda_function.lambda[count.index].function_name}-invocations"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "Invocations"
  namespace           = "AWS/Lambda"
  ok_actions          = [var.sns_topic_arn]
  period              = "120"
  statistic           = "Sum"
  threshold           = var.alarm_threshold_invocations

  dimensions = {
    FunctionName = aws_lambda_function.lambda[count.index].function_name
  }
}

resource "aws_cloudwatch_metric_alarm" "success_rate" {
  count = local.alerting == true ? var.mod_count : 0

  alarm_actions       = [var.sns_topic_arn]
  alarm_description   = "This metric monitors the success rate of ${aws_lambda_function.lambda[count.index].function_name} lambda over a 5 minute period"
  alarm_name          = "${aws_lambda_function.lambda[count.index].function_name}-success-rate"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  ok_actions          = [var.sns_topic_arn]
  threshold           = var.alarm_threshold_success_rate
  treat_missing_data  = "ignore"

  metric_query {
    id          = "success_rate"
    expression  = "100 - 100 * errors / MAX([errors, invocations])"
    label       = "Success Rate (%)"
    return_data = "true"
  }

  metric_query {
    id = "invocations"

    metric {
      metric_name = "invocations"
      namespace   = "AWS/Lambda"
      period      = "300"
      stat        = "Sum"
      unit        = "Count"

      dimensions = {
        FunctionName = aws_lambda_function.lambda[count.index].function_name
      }
    }
  }

  metric_query {
    id = "errors"

    metric {
      metric_name = "errors"
      namespace   = "AWS/Lambda"
      period      = "300"
      stat        = "Sum"
      unit        = "Count"

      dimensions = {
        FunctionName = aws_lambda_function.lambda[count.index].function_name
      }
    }
  }
}
