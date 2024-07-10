output "client_id" {
  value = okta_app_oauth.app.client_id
}

output "group" {
  value = [for user in okta_group.groups: user.id]
}
