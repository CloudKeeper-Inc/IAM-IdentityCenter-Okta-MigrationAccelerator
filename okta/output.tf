output "client_id" {
  value = okta_app_oauth.app.client_id
}

output "users" {
  value = { for idx, user in distinct(local.users) : user.email => user }
}

output "groups" {
  value = toset(var.groups)
}

output "group_user_map" {
  value = local.group_user_map
}