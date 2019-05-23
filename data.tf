data "aws_caller_identity" "current" {
  count = "${var.mod_count}"
}

data "aws_region" "current" {
  count = "${var.mod_count}"
}

data "aws_iam_role" "lambda" {
  count = "${var.lambda_role != "" ? var.mod_count : 0}"
  name  = "${var.lambda_role}"
}
