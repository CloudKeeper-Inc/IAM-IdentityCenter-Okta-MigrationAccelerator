#!/bin/bash

# Get the workspace name from user input
read -p "Enter the Terraform workspace name: " WORKSPACE_NAME

# Check if Terraform has been initialized
if [ ! -f ".terraform/terraform.tfstate" ]; then
  echo "Terraform is not initialized. Initializing..."
  terraform init
fi

# Check if the workspace exists
if terraform workspace select "$WORKSPACE_NAME" 2>/dev/null; then
  echo "Workspace '$WORKSPACE_NAME' found. Applying Terraform..."
else
  # If the workspace does not exist, create it
  terraform workspace new "$WORKSPACE_NAME"
  echo "Workspace '$WORKSPACE_NAME' created."
fi

# Construct the filename for the .tfvars file
TFVARS_FILE="terraform.${WORKSPACE_NAME}.tfvars"

# Check if a .tfvars file exists for the current workspace
if [ ! -f "$TFVARS_FILE" ]; then
  echo "Error: Terraform .tfvars file '$TFVARS_FILE' not found for workspace '$WORKSPACE_NAME'"
  exit 1
fi

# Apply Terraform with the matching .tfvars file
terraform apply -auto-approve -var-file="$TFVARS_FILE" > output.txt
