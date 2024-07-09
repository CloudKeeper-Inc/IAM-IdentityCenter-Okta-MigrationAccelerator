output "client_id" {
  value = okta_app_oauth.app.client_id
}

output "gp" {
  value = {
    for user_key, user_value in local.users :
    user_key => [for group in user_value.groups : okta_group.groups[group].id]
  }
}
