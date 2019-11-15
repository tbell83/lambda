resource "aws_lambda_function" "lambda" {
  count = var.mod_count

  s3_bucket                      = var.s3_bucket
  s3_key                         = var.s3_key
  filename                       = var.filename == null && var.s3_bucket == null && var.s3_key == null ? "dummy.zip" : var.filename
  function_name                  = var.lambda_function_name != "" ? var.lambda_function_name : var.name
  runtime                        = var.runtime
  handler                        = var.handler
  layers                         = var.layers
  tags                           = var.tags
  description                    = var.description
  memory_size                    = var.memory_size
  timeout                        = var.timeout
  reserved_concurrent_executions = var.reserved_concurrent_executions
  role                           = var.lambda_role != "" ? join("", data.aws_iam_role.lambda.*.arn) : join("", aws_iam_role.lambda.*.arn)

  vpc_config {
    subnet_ids         = var.vpc_config_subnet_ids
    security_group_ids = var.vpc_config_security_group_ids
  }

  dynamic "environment" {
    for_each = var.environment_variables != null ? [1] : []
    content {
      variables = var.environment_variables
    }
  }
}
