import json
import os
import subprocess
import random

with open('../config.json') as f:
    data = json.load(f)
    account_nos = data.get("account_no", [])


def generate_policy_config(policy_items,processed_policies):
    config = ""
    
    for policy_item in policy_items:
        if policy_item["name"] not in processed_policies:
            processed_policies.add(policy_item["name"])
            config += f'  {policy_item["name"]} = {{\n'
            config += f'    name        = "{policy_item["name"]}"\n'
            config += f'    path        = "/"\n'
            config += f'    description = "{policy_item["name"]}"\n'
            config += f'    policy_json = "{policy_item["policy_json"]}"\n'
            config += f'  }}\n'
    return config

def generate_managed_policy_config(managed_policie):
    config = ""
    config += f'"{managed_policie}",'
    return config

def generate_inline_policy_config(inline_policies):
    config = ""
    for policy_item in inline_policies:
        for policy_name, policy_details in policy_item.items():
            config += f'    {{\n'
            config += f'      name   = "{policy_name}"\n'
            config += f'      policy = "{policy_details}"\n'
            config += f'    }},\n'
    return config

def generate_role_config(role_name):
    config = ""
    
    config += f'  {role_name} = {{\n'
    config += f'      name   = "{role_name}"\n'
    config += f'    }},\n'
    return config   




# Convert JSON to Terraform configuration files for each account ID
processed_accountid = set()
for account_id in data["account_no"]:
    terraform_config = ""

    # Account ID
    terraform_config += f'account_id = "{account_id}"\n\n'

    # Policies
    terraform_config += 'policy = {\n'
    processed_policies = set()
    for role_name, role_data in data.items():

        if role_name != "account_no" and account_id in role_data["account_id"]:
            processed_accountid.add(account_id)
            if "policies" in role_data and role_data["policies"]:
                terraform_config += generate_policy_config(role_data["policies"],processed_policies)
    terraform_config += '}\n\n'

    # Managed Policies
    terraform_config += 'role_aws_managed_policy = {'
    processed_managed_policies = set()
    for role_name, role_data in data.items():
        if role_name != "account_no" and account_id in role_data["account_id"]:
            processed_accountid.add(account_id)
            if "managed_policy" in role_data and role_data["managed_policy"]:
              if role_data["managed_policy"] != [] :  
                terraform_config += f'{role_name} =['
                for managed_policie in role_data["managed_policy"]:
                   terraform_config += generate_managed_policy_config(managed_policie)
                terraform_config += f']'
        terraform_config += f'\n'    
    terraform_config += '}\n\n'

    # Inline Policies
    terraform_config += 'inline_policies = {\n'
    for role_name, role_data in data.items():
        if role_name != "account_no" and account_id in role_data["account_id"]:
            processed_accountid.add(account_id)
            if "inline_policies" in role_data and role_data["inline_policies"]:
               terraform_config += f'  {role_name} = [\n'
               terraform_config += generate_inline_policy_config(role_data["inline_policies"])
               terraform_config += f'  ]\n'
    terraform_config += '}\n\n'
    
    #customer_managed

    terraform_config += f'role_customer_managed_policy = {{\n'
    for role_name, role_data in data.items():
        if role_name != "account_no" and account_id in role_data["account_id"]: 
            if "policies" in role_data and role_data["policies"]:          
                terraform_config += f'  {role_name} = ['
                for policy_item in role_data["policies"]:
                    terraform_config += f'"{policy_item["name"]}",'
                terraform_config += f']\n'
    terraform_config += f'}}\n\n'    

    # Role
    terraform_config += 'role = {\n'
    for role_name, role_data in data.items():
        if role_name != "account_no" and account_id in role_data["account_id"]:
            processed_accountid.add(account_id)
            terraform_config += generate_role_config(role_name)
    terraform_config += '}\n\n'

    # Delete existing Terraform variable file if exists
    tf_vars_file = f"terraform.{account_id}.tfvars"
    if os.path.exists(tf_vars_file):
        os.remove(tf_vars_file)
        print(f"Deleted existing Terraform configuration file '{tf_vars_file}'.")    
  

    # Write Terraform configuration to file
    if account_id in processed_accountid:
      file_name = f"terraform.{account_id}.tfvars"
      with open(file_name, "w") as f:
          f.write(terraform_config)
      print(f"Terraform configuration file '{file_name}' created successfully.")
###############################################################################################################
# Check if the Terraform state file exists
terraform_state_file = ".terraform/terraform.tfstate"
terraform_initialized = os.path.isfile(terraform_state_file)

if not terraform_initialized:
    print("Terraform is not initialized. Initializing...")
    subprocess.run(["terraform", "init"])

# Iterate over each account number
for account_id in account_nos:
    print(f"Processing account {account_id}...")

    workspace_name = account_id

    # Check if the workspace exists
    try:
        result = subprocess.run(
            ["terraform", "workspace", "select", workspace_name],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            check=True,
            text=True  # This ensures that the output is returned as a string
        )
        print(f"Workspace '{workspace_name}' found. Applying Terraform...")
    except subprocess.CalledProcessError as e:
        print(f"Error selecting workspace '{workspace_name}': {e.stderr}")
        result = subprocess.run(
            ["terraform", "workspace", "new", workspace_name],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            check=True,
            text=True  # This ensures that the output is returned as a string
        )
        result = subprocess.run(
            ["terraform", "workspace", "select", workspace_name],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            check=True,
            text=True  # This ensures that the output is returned as a string
        )
        print(f"Workspace '{workspace_name}' found. Applying Terraform...")
    except FileNotFoundError as e:
        print(f"Terraform command not found: {e}")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")

    # Construct the filename for the .tfvars file
    tfvars_file = f"terraform.{workspace_name}.tfvars"

    # Check if a .tfvars file exists for the current workspace
    if not os.path.isfile(tfvars_file):
        print(f"Error: Terraform .tfvars file '{tfvars_file}' not found for workspace '{workspace_name}'")
        exit(1)

    # Apply Terraform with the matching .tfvars file
    subprocess.run(["terraform", "apply", "-auto-approve","-var-file=" + tfvars_file], check=True)