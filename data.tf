data "aws_caller_identity" "current" {
  count = "${var.count}"
}

data "aws_region" "current" {
  count = "${var.count}"
}

data "aws_iam_role" "lambda" {
  count = "${var.lambda_role != "" ? var.count : 0}"
  name  = "${var.lambda_role}"
}
