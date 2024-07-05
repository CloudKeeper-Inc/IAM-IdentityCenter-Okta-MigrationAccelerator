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
    dev-dba-policy = {
      name        = "dev-rds-full-access-policy"
      path        = "/"
      description = "Dev Account: RDS full access for DBAs"
      policy_json = "customer-managed-policy-json/policy-dev-dba.json"
    }
  }
}

variable "role" {
  description = "A map of roles to create."
  type = map(object({
    name                    = string
    # assume_role_policy_json = string
  }))
  default = {
    idp-admin-role = {
      name                    = "dev-admin-idp-role"
      assume_role_policy_json = "trust-relation-json/assume-role-dev-admin-policy.json"
    }
    idp-dba-role = {
      name                    = "dev-dba-idp-role"
      assume_role_policy_json = "trust-relation-json/assume-role-dev-dba-policy.json"
    }
  }
}

variable "inline_policies" {
  description = "A map of inline policies to attach to the IAM role."
  type = map(list(object({
    name   = string
    policy = string
  })))
  default = {
    idp-dba-role = [
      {
        name   = "example-full-access-policy"
        policy = "inline-policy-json/inline-policy-dev-dba.json"
      },
      {
        name   = "example-jit-policy"
        policy = "inline-policy-json/inline-policy-dev-jit.json"
      }
    ]
  }
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
