data "aws_caller_identity" "current" {
  count = var.mod_count
}

data "aws_region" "current" {
  count = var.mod_count
}

data "aws_iam_role" "lambda" {
  count = local.role == false ? var.mod_count : 0
  name  = var.lambda_role
}
