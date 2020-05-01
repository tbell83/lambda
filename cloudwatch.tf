resource "aws_cloudwatch_log_group" "lambda" {
  count = var.mod_count

  name              = "/aws/lambda/${var.name}"
  retention_in_days = var.log_retention
  tags              = var.tags
}

resource "aws_cloudwatch_metric_alarm" "invocations" {
  count = local.alerting == true && var.cloudwatch_alarms["invocations"]["enabled"] == 1 ? var.mod_count : 0

  alarm_actions       = [var.sns_topic_arn]
  alarm_description   = "This metric monitors invocations of ${aws_lambda_function.lambda[count.index].function_name} lambda"
  alarm_name          = "${aws_lambda_function.lambda[count.index].function_name}-invocations"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = var.cloudwatch_alarms["invocations"]["evaluation_periods"]
  metric_name         = "Invocations"
  namespace           = "AWS/Lambda"
  ok_actions          = [var.sns_topic_arn]
  period              = var.cloudwatch_alarms["invocations"]["period"]
  statistic           = "Sum"
  threshold           = var.cloudwatch_alarms["invocations"]["threshold"]

  dimensions = {
    FunctionName = aws_lambda_function.lambda[count.index].function_name
  }
}

resource "aws_cloudwatch_metric_alarm" "success_rate" {
  count = local.alerting == true && var.cloudwatch_alarms["success_rate"]["enabled"] == 1 ? var.mod_count : 0

  alarm_actions       = [var.sns_topic_arn]
  alarm_description   = "This metric monitors the success rate of ${aws_lambda_function.lambda[count.index].function_name} lambda"
  alarm_name          = "${aws_lambda_function.lambda[count.index].function_name}-success-rate"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = var.cloudwatch_alarms["success_rate"]["evaluation_periods"]
  ok_actions          = [var.sns_topic_arn]
  threshold           = var.cloudwatch_alarms["success_rate"]["threshold"]
  treat_missing_data  = "ignore"

  metric_query {
    id          = "availability"
    expression  = "100 - 100 * errors / MAX([errors, invocations])"
    label       = "Success Rate (%)"
    return_data = "true"
  }

  metric_query {
    id = "invocations"

    metric {
      metric_name = "Invocations"
      namespace   = "AWS/Lambda"
      period      = var.cloudwatch_alarms["success_rate"]["period"]
      stat        = "Sum"
      unit        = "Count"

      dimensions = {
        FunctionName = aws_lambda_function.lambda[count.index].function_name
        Resource     = aws_lambda_function.lambda[count.index].function_name
      }
    }
  }

  metric_query {
    id = "errors"

    metric {
      metric_name = "Errors"
      namespace   = "AWS/Lambda"
      period      = var.cloudwatch_alarms["success_rate"]["period"]
      stat        = "Sum"
      unit        = "Count"

      dimensions = {
        FunctionName = aws_lambda_function.lambda[count.index].function_name
        Resource     = aws_lambda_function.lambda[count.index].function_name
      }
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "throttles" {
  count = local.alerting == true && var.cloudwatch_alarms["throttles"]["enabled"] == 1 ? var.mod_count : 0

  alarm_actions       = [var.sns_topic_arn]
  alarm_description   = "This metric monitors throttles of ${aws_lambda_function.lambda[count.index].function_name} lambda"
  alarm_name          = "${aws_lambda_function.lambda[count.index].function_name}-throttles"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.cloudwatch_alarms["throttles"]["evaluation_periods"]
  metric_name         = "Throttles"
  namespace           = "AWS/Lambda"
  ok_actions          = [var.sns_topic_arn]
  period              = var.cloudwatch_alarms["throttles"]["period"]
  statistic           = "Maximum"
  threshold           = var.cloudwatch_alarms["throttles"]["threshold"]

  dimensions = {
    FunctionName = aws_lambda_function.lambda[count.index].function_name
  }
}
