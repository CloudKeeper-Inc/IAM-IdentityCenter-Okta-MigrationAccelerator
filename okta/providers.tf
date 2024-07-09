terraform {
  required_providers {
    okta = {
      source  = "okta/okta",
      version = "~> 4.8.1"
    }
    aws = {
      source  = "hashicorp/aws",
      version = "~> 5.0"
    }
  }
}


provider "okta" {
  org_name        = "trial-7054786"
  base_url        = "okta.com"
  api_token       = "00VeyV41bqfsUf-ZJbG2Ue9oE1svgvOQwLrWjMcx1J"
  request_timeout = 30
}

# locals {
#   # Flatten the aws_roles map into a list of maps
#   users = flatten([
#     for key, users_list in local.aws_roles : [
#       for user in users_list : merge(user, { account_key = key })
#     ]
#   ])

#   # Map groups to their users
#   group_user_map = {
#     for group, users_list in aws_roles : group => [
#       for user in users_list : join(".", [user.first_name, user.last_name])
#     ]
#   }
# }

locals {
  # Flatten the aws_roles map into a list of maps
  # users = flatten([
  #   for key, users_list in local.aws_roles : [
  #     for user in users_list : merge(user, { account_key = user.email })
  #   ]
  # ])

  users = flatten([
    for key, users_list in local.aws_roles : [
      for user in users_list : user
    ]
  ])

  # Map groups to their users
  # group_user_map = {
  #   for group, users_list in local.aws_roles : users_list.email => [
  #     for user in users_list : user.email
  #   ]
  # }
}

# locals {
#   group_user_map = {
#     for group, users_list in local.aws_roles : group => [
#       for user in users_list : group
#     ]
#   }
# }

locals {
  group_user_map = {
    for group, users_list in local.aws_roles : group => [
      for user in users_list : user.email
    ]
  }
}
