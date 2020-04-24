resource "aws_secretsmanager_secret" "secretsmanager_secret" {
  name                    = var.name
  name_prefix             = var.name_prefix
  description             = var.description
  kms_key_id              = var.kms_key_id
  policy                  = var.policy
  recovery_window_in_days = var.recovery_window_in_days
  rotation_lambda_arn     = var.rotation_lambda_arn

  dynamic "rotation_rules" {
    for_each = var.rotation_rules == {} ? [] : [var.rotation_rules]
    content {
      automatically_after_days = lookup(rotation_rules.value, "automatically_after_days", null)
    }
  }
  
  tags = var.tags
}

