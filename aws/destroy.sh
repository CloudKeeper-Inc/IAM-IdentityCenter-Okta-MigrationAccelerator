#!/bin/bash

# Get the workspace name from user input
read -p "Enter the Terraform workspace name: " WORKSPACE_NAME

# Check if the workspace exists
if terraform workspace select "$WORKSPACE_NAME" 2>/dev/null; then
  echo "Workspace '$WORKSPACE_NAME' found. Destroying Terraform..."
else
  # If the workspace does not exist, create it
  echo "Workspace '$WORKSPACE_NAME' not found."
fi

# Construct the filename for the .tfvars file
TFVARS_FILE="terraform.${WORKSPACE_NAME}.tfvars"

# Check if a .tfvars file exists for the current workspace
if [ ! -f "$TFVARS_FILE" ]; then
  echo "Error: Terraform .tfvars file '$TFVARS_FILE' not found for workspace '$WORKSPACE_NAME'"
  exit 1
fi

# Apply Terraform with the matching .tfvars file
terraform destroy -var-file="$TFVARS_FILE"
