import json

# Load JSON data
org_name = input("Enter your Okta Organization's name(eg. trial-12345):   ")
api_token = input("Paste or enter your Okta API token here:   ")


with open('../config.json') as f:
    data = json.load(f)
    account_nos = data.get("account_no", [])

def generate_group_config(role_name, account_id):
    return f'"aws#acc#{role_name}#{account_id}",'


def create_providers_file(filename):
    terraform_config = f"""
terraform {{
  required_providers {{
    okta = {{
      source  = "okta/okta",
      version = "~> 4.8.1"
    }}
    aws = {{
      source  = "hashicorp/aws",
      version = "~> 5.0"
    }}
  }}
}}

provider "okta" {{
  org_name        = "{org_name}"             
  base_url        = "okta.com"
  api_token       = "{api_token}"            
  request_timeout = 300
}}
"""
    with open(filename, "w") as file:
        file.write(terraform_config)


# Initialize Terraform configuration
terraform_config = 'application = "AWS Account Federated Access"\n'
terraform_config += 'groups = ['

# Generate group configurations for each role and account ID
for role_name, role_data in data.items():
    if role_name != "account_no":
        for account_id in role_data.get("account_id", []):
            terraform_config += '' + generate_group_config(role_name, account_id) + ''

terraform_config += ']\n\n'
terraform_config += 'consent_method                  =   "REQUIRED"\n'
terraform_config += 'grant_types                     =   ["authorization_code", "urn:ietf:params:oauth:grant-type:device_code", "urn:ietf:params:oauth:grant-type:token-exchange"] \n'
terraform_config += 'type                            =   "native"\n'
terraform_config += f'redirect_uris                   =   ["com.okta.{org_name}:/"] \n'            
terraform_config += f'post_logout_redirect_uris       =   ["com.okta.{org_name}:/callback"] \n'    
terraform_config += 'issuer_mode                     =    "DYNAMIC"\n'
terraform_config += 'label                           =    "cli-access-app"\n'
terraform_config += 'response_types                  =    ["code"] \n'


# Write Terraform configuration to file
file_name = "terraform.tfvars"
with open(file_name, "w") as f:
    f.write(terraform_config)

create_providers_file("providers.tf")

print(f"Terraform configuration file '{file_name}' and providers.tf created successfully.")
