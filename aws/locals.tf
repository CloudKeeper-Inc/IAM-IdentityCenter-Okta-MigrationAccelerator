locals {
  policy_lists = {
    for role_key, policies in var.role_customer_managed_policy :
    role_key => [for policy in policies : aws_iam_policy.policy[policy].arn]
  }
}
