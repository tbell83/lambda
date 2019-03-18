variable "tags" {
  description = "A mapping of tags to assign to the module resources."
  type        = "map"
}

variable "name" {
  description = "Prefix for module resources."
  type        = "string"
}

variable "count" {
  default = 1
}

variable "edge" {
  default = "false"
}

variable "runtime" {
  description = "Lambda runtime"
  type        = "string"
}

variable "timeout" {
  description = "The amount of time your Lambda Function has to run in seconds."
  type        = "string"
  default     = "3"
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime."
  type        = "string"
  default     = "128"
}

variable "s3_bucket" {
  description = "The S3 bucket location containing the function's deployment package. Conflicts with filename."
  type        = "string"
  default     = ""
}

variable "s3_key" {
  description = "The S3 key of an object containing the function's deployment package. Conflicts with filename."
  type        = "string"
  default     = ""
}

variable "filename" {
  description = "The path to the function's deployment package within the local filesystem. If defined, The s3_-prefixed options cannot be used."
  type        = "string"
  default     = ""
}

variable "vpc_config_subnet_ids" {
  description = "A list of subnet IDs associated with the Lambda function."
  type        = "list"
  default     = []
}

variable "vpc_config_security_group_ids" {
  description = "A list of security group IDs associated with the Lambda function."
  type        = "list"
  default     = []
}

variable "lambda_role_policy_json" {
  description = "JSON of policy for lambda execution role."
  type        = "string"
  default     = ""
}

variable "handler" {
  description = "The function entrypoint in your code."
  type        = "string"
}

variable "description" {
  description = "Description of what your Lambda Function does."
  type        = "string"
  default     = ""
}

variable "environment_variables" {
  description = "A map that defines environment variables for the Lambda function."
  type        = "map"

  default = {
    "foo" = "bar"
  }
}

variable "log_retention" {
  description = "Cloudwatch log retention in days."
  type        = "string"
  default     = 7
}
