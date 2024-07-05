resource "aws_iam_policy" "policy" {
  for_each = var.policy

  name        = each.value.name
  path        = each.value.path
  description = each.value.description

  policy = file(each.value.policy_json)
}
