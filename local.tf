locals {
  role     = var.lambda_role == "" ? true : false
  edge     = var.edge == true || var.edge == "true" ? true : false
  alerting = var.sns_topic_arn != null ? true : false
  vpc      = length(var.vpc_config_security_group_ids) != 0 && length(var.vpc_config_subnet_ids) != 0 ? true : false
}
