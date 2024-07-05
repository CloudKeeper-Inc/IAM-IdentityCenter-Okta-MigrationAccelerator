import json, boto3, csv, os
from utils import *
from client import *
import os

# bucket_name = os.environ['bucket_name']
# master_account_id = os.environ['master_account_id']
# sso_acc_role_arn = 'arn:aws:iam::'+master_account_id+':role/AWS-SSO-Read-Only-Role'
# bucket_name = 'bucket-for-sso-data-adityaajay'
bucket_name = ""#os.environ['SSO_DATA_BUCKET']
region = 'eu-west-1'

    
s3_client = boto3.client('s3', region_name = region)

org_client = boto3.client('organizations', region_name = region)
account_ids = get_account_list(org_client)


upload_account_ids_to_s3(account_ids, bucket_name)

sso_admin_client = boto3.client('sso-admin', region_name = region)

instance_arn = get_sso_instance_arn(sso_admin_client)


csv_headers = ['Saml_Provider_Name', 'Role_Name', 'Attached_Managed_Policies', 'Customer_Managed_Policies', 'Inline_Policy','IdPMetadataFileName']

permission_sets_map = {}

for account_id in account_ids:
    sso_data = []
    permission_sets = sso_admin_client.list_permission_sets_provisioned_to_account(InstanceArn=instance_arn, AccountId=account_id)
    if len(permission_sets) > 1:
            permission_sets_arns = permission_sets['PermissionSets']
            
            sso_data = get_sso_account_data(permission_sets_arns, account_id, sso_admin_client, instance_arn)

            for item in permission_sets_name(sso_admin_client, permission_sets['PermissionSets'], instance_arn):
                if item not in permission_sets_map:
                    permission_sets_map[item] = {"account_id": [], "Attached_Managed_Policies": [], "Customer_Managed_Policies": [], "Inline_Policy": ''}
                permission_sets_map[item]["account_id"].append(account_id)
                for sso_entry in sso_data:
                    if sso_entry["Role_Name"] == item:
                        permission_sets_map[item]["Attached_Managed_Policies"] = sso_entry["Attached_Managed_Policies"]
                        permission_sets_map[item]["Customer_Managed_Policies"] = sso_entry["Customer_Managed_Policies"]
                        if sso_entry["Inline_Policy"] == 'No':
                            permission_sets_map[item]["Inline_Policy"] = ''
                        else:
                            permission_sets_map[item]["Inline_Policy"] = sso_entry["Inline_Policy"]
                        break
                  
            upload_custom_policy_to_s3(permission_sets_arns, bucket_name, account_id, sso_admin_client, instance_arn)

    filename = 'extracted-data/' + account_id + '.csv'
    with open(filename, 'w') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames = csv_headers)
        writer.writeheader()
        writer.writerows(sso_data)

    bucket_key = account_id + '/' + 'data.csv'
    # upload_file_s3(filename, bucket_name, bucket_key)


create_config_json(permission_sets_map, account_ids)
