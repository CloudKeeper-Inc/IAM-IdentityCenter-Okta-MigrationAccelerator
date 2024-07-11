# Inline Policy JSONs

This directory is designated for storing inline policy JSON files. These files will be placed here automatically by the program.

## Nomenclature for JSON Files

The JSON files will follow the naming convention: `<policy_name>.json`.

## Example Policy JSON File

Below is an example of what an inline policy JSON file might look like:

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
