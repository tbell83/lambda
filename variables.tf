variable "tags" {
  description = "A mapping of tags to assign to the module resources."
  type        = map(string)
}

variable "name" {
  description = "Prefix for module resources."
  type        = string
}

variable "mod_count" {
  default = 1
}

variable "edge" {
  default = false
}

variable "runtime" {
  description = "Lambda runtime"
  type        = string
}

variable "timeout" {
  description = "The amount of time your Lambda Function has to run in seconds."
  type        = number
  default     = 3
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime."
  type        = number
  default     = 128
}

variable "s3_bucket" {
  description = "The S3 bucket location containing the function's deployment package. Conflicts with filename."
  type        = string
  default     = null
}

variable "s3_key" {
  description = "The S3 key of an object containing the function's deployment package. Conflicts with filename."
  type        = string
  default     = null
}

variable "filename" {
  description = "The path to the function's deployment package within the local filesystem. If defined, The s3_-prefixed options cannot be used."
  type        = string
  default     = null
}

variable "vpc_config_subnet_ids" {
  description = "A list of subnet IDs associated with the Lambda function."
  type        = list
  default     = []
}

variable "vpc_config_security_group_ids" {
  description = "A list of security group IDs associated with the Lambda function."
  type        = list
  default     = []
}

variable "lambda_role_policy_json" {
  description = "JSON of policy for lambda execution role."
  type        = string
  default     = ""
}

variable "handler" {
  description = "The function entrypoint in your code."
  type        = string
  default     = "index.handler"
}

variable "description" {
  description = "Description of what your Lambda Function does."
  type        = string
  default     = ""
}

variable "environment_variables" {
  description = "A map that defines environment variables for the Lambda function."
  type        = map(string)
  default     = null
}

variable "log_retention" {
  description = "Cloudwatch log retention in days."
  type        = string
  default     = 7
}

variable "lambda_role" {
  description = "Lambda role name to use as lambda execution role.  By default the module will create a role if none is provided."
  type        = string
  default     = ""
}

variable "lambda_function_name" {
  description = "(Optional) Name for the lambda function.  By default is generated using var.name-var.region."
  type        = string
  default     = ""
}

variable "lambda_policy_name" {
  description = "(Optional) Name for the lambda function.  By default is generated using var.name_lambda_execution_policy_data.aws_region.current.*.name"
  type        = string
  default     = ""
}

variable "assume_principals" {
  description = "List of ARNs that can assume the execution policy in addition to the Lambda/Lambda@Edge services."
  default     = []
}

variable "layers" {
  description = "lambda layers to be used by this function"
  type        = list
  default     = []
}

variable "reserved_concurrent_executions" {
  default = -1
}

variable "env" {
  default = ""
}

variable "sns_topic_arn" {
  default = null
}
