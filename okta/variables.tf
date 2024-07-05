variable "region" {
  description = "Region for AWS Provider, where SSM paramters for OKTA creds are stored"
  type        = string
  default     = "us-east-1"
}

variable "application" {
  description = "Name of the application being created"
  type        = string
  default     = "oktaapp"
}

variable "groups" {
  description = "A list of all the groups"
  type        = list(string)
  default     = ["aws#Admin#123456789112"]
}

variable "okta_authentication_token" {
  type        = string
  description = "API Token for Okta Authentication"
  default     = "UNSET"
}

variable "okta_org_base_url" {
  type        = string
  description = "Base URL for Okta org"
  default     = "UNSET"
}

variable "okta_org_name" {
  type        = string
  description = "Okta Org name"
  default     = "UNSET"
}

variable "consent_method" {
  type        = string
  description = "Okta Org name"
}

variable "grant_types" {
  type        = list(string)
  description = "Okta Org name"
}

variable "issuer_mode" {
  type        = string
  description = "Okta Org name"
}

variable "label" {
  type        = string
  description = "Okta Org name"
}

variable "post_logout_redirect_uris" {
  type        = list(string)
  description = "Okta Org name"
}

variable "redirect_uris" {
  type        = list(string)
  description = "Okta Org name"
}

variable "response_types" {
  type        = list(string)
  description = "Okta Org name"
}

# variable "token_endpoint_auth_method" {
#   type        = string
#   description = "Okta Org name"
# }

variable "type" {
  type        = string
  description = "Okta Org name"
}