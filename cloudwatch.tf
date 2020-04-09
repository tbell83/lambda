resource "aws_cloudwatch_log_group" "lambda" {
  count = var.mod_count

  name              = "/aws/lambda/${var.name}"
  retention_in_days = var.log_retention
  tags              = var.tags
}

resource "aws_cloudwatch_metric_alarm" "duration" {
  count = local.alerting == true ? var.mod_count : 0

  alarm_actions       = [var.sns_topic_arn]
  alarm_description   = "This metric monitors duration of ${aws_lambda_function.lambda[count.index].function_name} lambda"
  alarm_name          = "${aws_lambda_function.lambda[count.index].function_name}-duration"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "Duration"
  namespace           = "AWS/Lambda"
  ok_actions          = [var.sns_topic_arn]
  period              = "120"
  statistic           = "Maximum"
  threshold           = "500"

  dimensions = {
    FunctionName = aws_lambda_function.lambda[count.index].function_name
  }
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
  threshold           = "25"

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
  threshold           = "25"

  dimensions = {
    FunctionName = aws_lambda_function.lambda[count.index].function_name
  }
}

resource "aws_cloudwatch_metric_alarm" "errors" {
  count = local.alerting == true ? var.mod_count : 0

  alarm_actions       = [var.sns_topic_arn]
  alarm_description   = "This metric monitors errors of ${aws_lambda_function.lambda[count.index].function_name} lambda"
  alarm_name          = "${aws_lambda_function.lambda[count.index].function_name}-errors"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  ok_actions          = [var.sns_topic_arn]
  period              = "120"
  statistic           = "Maximum"
  threshold           = "25"

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
  threshold           = var.success_rate_threshold
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
      period      = "300"
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
      period      = "300"
      stat        = "Sum"
      unit        = "Count"

      dimensions = {
        FunctionName = aws_lambda_function.lambda[count.index].function_name
        Resource     = aws_lambda_function.lambda[count.index].function_name
      }
    }
  }
}
