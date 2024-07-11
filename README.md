# IAM Identity Center to Okta Migration Accelerator

## Overview

This repository provides a seamless way to migrate from AWS Identity Center to Okta with minimal effort. Follow the steps below to complete the migration process.

## Prerequisites

Before you begin the migration process, ensure you have the following prerequisites in place:

1. **Python and Terraform**:
   - Ensure that you have Python and Terraform installed and properly configured on your system.
   - [Install Python](https://www.python.org/downloads/)
   - [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)

2. **AWS CLI**:
   - Install AWS CLI if not already installed. Follow the [AWS CLI installation guide](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).
   - Configure the AWS CLI with your AWS credentials.

3. **Configuring AWS CLI**:
   - Ensure that you have AWS secret keys and access keys inside the credentials file with the profile name as the account number. Your `~/.aws/credentials` file should look like this:
     ```
     [123456789123]
     aws_access_key_id = your_aws_access_key_id
     aws_secret_access_key = your_aws_secret_access_key
     
     [789456123789]
     aws_access_key_id = your_aws_access_key_id
     aws_secret_access_key = your_aws_secret_access_key
     
     [456123789456]
     aws_access_key_id = your_aws_access_key_id
     aws_secret_access_key = your_aws_secret_access_key
     ```

## Dependencies

1. **Bash**:
   - Ensure you have a bash shell available for executing the `launch.sh` script.
   - If you are using a Windows machine, consider using Git Bash or WSL (Windows Subsystem for Linux).

2. **Customer Managed Policy JSONs**:
   - Prepare the customer managed policy JSON files and place them inside the `aws/customer-managed-policy-json` directory.
   - Ensure the JSON files follow the nomenclature `<customer-managed-policy-name>_sso.json`.

## Steps

1. **Run the Migration Script:**
   ```bash
   python3 main.py
   ```

2. **Specify AWS Region:**
   Enter the AWS region where your IAM Identity Center is running (e.g., us-east-1).
   ```
   Enter the AWS region where your IAM Identity Center is running (eg. us-east-1): us-east-1
   Selected region: us-east-1
   Please wait while the script is running...
   AWS SSO data extraction completed...
   ```

3. **Insert Customer Managed Policy JSONs:**
   Place your customer-managed policy JSON files inside the `aws/customer-managed-policy-json` directory. The JSON files should follow this naming convention: `<customer-managed-policy-name>_sso.json`. Once done, enter 'y' or 'Y'.
   ```
   Insert customer managed policy jsons inside "aws/customer-managed-policy-json" directory...
   Json nomenclature: <customer-managed-policy-name>_sso.json
   Once done enter y or Y...y
   ```

4. **Creating Resources:**
   Once the above steps are finished, the program then starts creating Okta and AWS resources for SSO setup.

5. **Enter Okta Organization Details:**
   Provide your Okta organization name and API token.
   ```
   Enter your Okta Organization's name (eg. trial-12345): okta_org
   Paste or enter your Okta API token here: token_okta
   ```

---

This README provides a comprehensive guide to using this repository for migrating from AWS Identity Center to Okta. Ensure all steps are followed accurately for a successful migration.