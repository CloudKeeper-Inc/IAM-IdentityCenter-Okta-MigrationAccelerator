variable "account_id" {
  description = "Account ID"
  type        = string
}

variable "saml_metadata_document" {
  description = "IDP name"
  type        = string
  default     = "saml-metadata/metadata.xml"
}

variable "policy" {
  description = "A map of customer-managed policies to create."
  type = map(object({
    name        = string
    path        = string
    description = string
    policy_json = string
  }))
  default = {
  }
}

variable "role" {
  description = "A map of roles to create."
  type = map(object({
    name                    = string
    # assume_role_policy_json = string
  }))
  default = {}
}

variable "inline_policies" {
  description = "A map of inline policies to attach to the IAM role."
  type = map(list(object({
    name   = string
    policy = string
  })))
  default = {}
}

variable "role_aws_managed_policy" {
  description = "A map of inline policies to attach to the IAM role."
  type        = map(list(string))
  default = {}
}

variable "role_customer_managed_policy" {
  description = "A map of inline policies to attach to the IAM role."
  type        = map(list(string))
  default = {}
}
