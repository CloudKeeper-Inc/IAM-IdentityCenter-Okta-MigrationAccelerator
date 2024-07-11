!/bin/bash

terraform_folder="okta/"

cd "$terraform_folder" || { echo "Failed to change directory to $terraform_folder"; exit 1; }
python3 launch.py || { echo "Failed to run launch.py"; exit 1; }
terraform init || { echo "Failed to initialize Terraform"; exit 1; }
terraform apply -var-file=terraform.tfvars -auto-approve --parallelism=1 || { echo "Failed to apply Terraform"; exit 1; }

echo "Script execution completed successfully"

python_script_folder="../aws/"

cd "$python_script_folder" || { echo "Failed to change directory to $python_script_folder"; exit 1; }

python3 launch.py || { echo "Failed to run launch.py"; exit 1; }



