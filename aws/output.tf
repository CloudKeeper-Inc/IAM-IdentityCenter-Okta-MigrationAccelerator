output "policy_arn" {
  value = {
    for policy_arn, policy in aws_iam_policy.policy :
    policy_arn => policy.id
  }
}

output "role_arn" {
  value = {
    for role_arn, role in aws_iam_role.role :
    role_arn => role.arn
  }
}

output "idp_arn" {
  value = aws_iam_saml_provider.idp.arn
}

output "policy_lists_output" {
  value = local.policy_lists
}
