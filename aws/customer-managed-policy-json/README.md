# Customer Managed Policies

This directory is intended to store customer-managed policy JSON files for Single Sign-On (SSO).

## Nomenclature for JSON Files

The JSON files should follow the naming convention: `<policy_name>_sso.json`.

## File Naming Example

If your policy name is `example-policy`, the JSON file should be named `example-policy_sso.json`.

## Location of Policy Names

The names of the JSON files can be found in the CSV files inside the `extracted-data` folder. Each CSV file will contain the necessary policy names to be used for naming your JSON files.

## Example Policy JSON File

Here is an example of what a policy JSON file might look like:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:GetObject"
      ],
      "Resource": [
        "arn:aws:s3:::example-bucket",
        "arn:aws:s3:::example-bucket/*"
      ]
    }
  ]
}
