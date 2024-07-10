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
  org_name        = "org_name"              #Replace org_name with name of your Okta organization name
  base_url        = "okta.com"
  api_token       = "api_token"             #Replace api_token with your Okta API token
  request_timeout = 300
}
