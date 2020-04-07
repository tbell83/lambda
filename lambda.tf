resource "aws_lambda_function" "lambda" {
  count = var.mod_count

  description                    = var.description
  filename                       = var.filename == null && var.s3_bucket == null && var.s3_key == null ? "dummy.zip" : var.filename
  function_name                  = var.lambda_function_name != "" ? var.lambda_function_name : var.name
  handler                        = var.handler
  kms_key_arn                    = var.kms_key_arn == null ? null : var.kms_key_arn
  layers                         = var.layers
  memory_size                    = var.memory_size
  reserved_concurrent_executions = var.reserved_concurrent_executions
  role                           = local.role == true ? join("", aws_iam_role.lambda.*.arn) : join("", data.aws_iam_role.lambda.*.arn)
  runtime                        = var.runtime
  s3_bucket                      = var.s3_bucket
  s3_key                         = var.s3_key
  tags                           = var.tags
  timeout                        = var.timeout

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
