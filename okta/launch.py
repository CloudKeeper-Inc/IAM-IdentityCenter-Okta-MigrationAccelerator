import json

# Load JSON data
with open('../config.json') as f:
    data = json.load(f)
    account_nos = data.get("account_no", [])

def generate_group_config(role_name, account_id):
    return f'"aws#{role_name}#{account_id}",'

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
terraform_config += 'redirect_uris                   =   ["com.okta.trial-1771640:/"] \n'
terraform_config += 'post_logout_redirect_uris       =   ["com.okta.trial-1771640:/callback"] \n'
terraform_config += 'issuer_mode                     =    "DYNAMIC"\n'
terraform_config += 'label                           =    "cli-access-app"\n'
terraform_config += 'response_types                  =    ["code"] \n'


# Write Terraform configuration to file
file_name = "terraform.tfvars"
with open(file_name, "w") as f:
    f.write(terraform_config)

print(f"Terraform configuration file '{file_name}' created successfully.")
