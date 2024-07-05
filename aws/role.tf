resource "aws_iam_role" "role" {
  for_each = var.role

  name = each.value.name
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = "arn:aws:iam::${var.account_id}:saml-provider/Okta-IdP"
        }
        Action = "sts:AssumeRoleWithSAML"
        Condition = {
          StringEquals = {
            "SAML:aud" = "https://signin.aws.amazon.com/saml"
          }
        }
      }
    ]
  })

  managed_policy_arns = concat(try(var.role_aws_managed_policy[each.key], []), try(local.policy_lists[each.key], []))

  dynamic "inline_policy" {
    for_each = contains(keys(var.inline_policies), each.key) ? toset(var.inline_policies[each.key]) : toset([])

    content {
      name   = try(inline_policy.value.name, null)
      policy = try(file(inline_policy.value.policy), null)
    }
  }

  depends_on = [
    aws_iam_saml_provider.idp,
    aws_iam_policy.policy
  ]
}
