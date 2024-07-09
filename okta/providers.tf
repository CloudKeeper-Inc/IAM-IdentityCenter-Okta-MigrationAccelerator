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
  org_name        = "trial-8983249"
  base_url        = "okta.com"
  api_token       = "00eqgAUnfy9N-8nxDzcUpbV0-XuJYr7f8II-3Llc48"
  request_timeout = 300
}
