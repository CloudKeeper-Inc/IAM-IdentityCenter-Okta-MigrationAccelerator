# #!/bin/bash

# # Read the file and extract account ID
# account_id=$(grep -oP 'account_id\s*=\s*"\K[^"]+' aws/terraform.dev.tfvars)

# # Extract role names
# role_names=$(awk -F'=' '/role/ && /name/ {gsub(/[ "]/,"",$2); print $2}' aws/terraform.dev.tfvars)

# # Print the extracted values
# echo "Account ID: $account_id"
# echo "Role Names: $role_names"

# # Initialize the AWS syntax string
# aws_syntax=""

# # Loop through each role name
# while read -r role_name; do
#     # Construct the AWS syntax string
#     aws_syntax+="\"aws#$role_name#$account_id\", "
# done <<< "$role_names"

# # Remove the trailing comma and space
# aws_syntax="${aws_syntax%, }"

# # Define the output file
# output_file="output.txt"

# # Print the AWS syntax string to the output file
# echo "groups = [$aws_syntax]" > "$output_file"

# # Print a message indicating the output file
# echo "Output has been written to $output_file"


!/bin/bash

terraform_folder="okta/"

cd "$terraform_folder" || { echo "Failed to change directory to $terraform_folder"; exit 1; }
python3 launch.py || { echo "Failed to run launch.py"; exit 1; }
terraform init || { echo "Failed to initialize Terraform"; exit 1; }
terraform apply -var-file=terraform.tfvars -auto-approve || { echo "Failed to apply Terraform"; exit 1; }

echo "Script execution completed successfully"

python_script_folder="../aws/"

cd "$python_script_folder" || { echo "Failed to change directory to $python_script_folder"; exit 1; }

python3 launch.py || { echo "Failed to run launch.py"; exit 1; }



