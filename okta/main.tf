# resource "aws_ssm_parameter" "okta_api_token" {
#   name  = "/okta/authentication-token"
#   type  = "String"
#   value = var.okta_authentication_token
#   lifecycle {
#     ignore_changes = [value]
#   }
# }

# resource "aws_ssm_parameter" "okta_base_url" {
#   name  = "/okta/org_base_url"
#   type  = "String"
#   value = var.okta_org_base_url
#   lifecycle {
#     ignore_changes = [value]
#   }
# }

# resource "aws_ssm_parameter" "okta_org_name" {
#   name  = "/okta/org_name"
#   type  = "String"
#   value = var.okta_org_name
#   lifecycle {
#     ignore_changes = [value]
#   }
# }

resource "okta_app_saml" "application" {
  preconfigured_app = "amazon_aws"
  label             = var.application
  status            = "ACTIVE"
  authentication_policy           =  okta_app_signon_policy.okta_app_signon_policy.id
}

resource "okta_app_saml_app_settings" "applications_setting" {
  depends_on = [okta_app_saml.application,okta_app_oauth.app]
  app_id     = okta_app_saml.application.id
  settings = jsonencode(
    {
      "awsEnvironmentType" : "aws.amazon",
      "joinAllRoles" : false
      "loginURL" : "https://console.aws.amazon.com/ec2/home"
      "sessionDuration" : 3600
      "appFilter" : "okta"
      "useGroupMapping" : true
      "groupFilter" : "^aws\\#(?{{role}}[\\w\\-]+)\\#(?{{accountid}}\\d+)$"
      "roleValuePattern" : "arn:aws:iam::$${accountid}:saml-provider/Okta-IdP,arn:aws:iam::$${accountid}:role/$${role}"
      "webSSOAllowedClient" : "${okta_app_oauth.app.client_id}"
    }
  )
}

resource "local_file" "metadata" {
  content  = okta_app_saml.application.metadata
  filename = "../aws/saml-metadata/metadata.xml"
}

resource "okta_group" "groups" {
  for_each = toset(var.groups)
  name     = each.key
}

resource "okta_app_group_assignment" "assignment" {
  depends_on = [okta_group.groups]
  for_each   = okta_group.groups
  group_id   = each.value.id
  app_id     = okta_app_saml.application.id
}

resource "okta_app_oauth" "app" {
  consent_method                  =  var.consent_method
  grant_types                     =  var.grant_types   
  issuer_mode                     =  var.issuer_mode
  label                           =  var.label
  post_logout_redirect_uris       =  var.post_logout_redirect_uris
  redirect_uris                   =  var.redirect_uris
  response_types                  =  var.response_types
  type                            =  var.type
  authentication_policy           =  okta_app_signon_policy.okta_app_signon_policy.id
}


resource "okta_app_signon_policy" "okta_app_signon_policy" {
  name        = "okta_policy"
  description = "Authentication Policy to be used on my app."
}

resource "okta_app_signon_policy_rule" "test" {
  policy_id   = okta_app_signon_policy.okta_app_signon_policy.id
  name        = "okta_auth"
  factor_mode = "1FA"
  constraints = [
    jsonencode({
      "knowledge" : {
        "types" : ["password"]
      },
    })
  ]
}