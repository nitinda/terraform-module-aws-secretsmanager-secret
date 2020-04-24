variable "name" {
  description = "Specifies the friendly name of the new secret."
  default     = null
}

variable "name_prefix" {
  description = "Creates a unique name beginning with the specified prefix"
  default     = null
}

variable "description" {
  description = "A description of the secret."
  default     = null
}

variable "kms_key_id" {
  description = "Specifies the ARN or alias of the AWS KMS customer master key (CMK) to be used to encrypt the secret values in the versions stored in this secret"
  default     = null
}

variable "policy" {
  description = "A valid JSON document representing a resource policy."
  default     = null
}

variable "recovery_window_in_days" {
  description = "Specifies the number of days that AWS Secrets Manager waits before it can delete the secret."
  default     = 30
  type        = number
}

variable "rotation_lambda_arn" {
  description = "Specifies the ARN of the Lambda function that can rotate the secret."
  default     = null
}

variable "rotation_rules" {
  description = "A structure that defines the rotation configuration for this secret."
  default     = null
}

variable "tags" {
  description = "Specifies a key-value map of user-defined tags that are attached to the secret."
  default     = {}
  type        = map(string)
}