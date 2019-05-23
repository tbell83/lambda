resource "aws_cloudwatch_log_group" "lambda" {
  count = "${var.mod_count}"

  name              = "/aws/lambda/${var.name}"
  retention_in_days = "${var.log_retention}"
  tags              = "${var.tags}"
}
