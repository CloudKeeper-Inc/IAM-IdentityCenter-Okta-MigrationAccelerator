import json, boto3, csv, os
from utils import *
from client import *
import os
from botocore.exceptions import ClientError

# bucket_name = os.environ['bucket_name']
# master_account_id = os.environ['master_account_id']
# sso_acc_role_arn = 'arn:aws:iam::'+master_account_id+':role/AWS-SSO-Read-Only-Role'
# bucket_name = 'bucket-for-sso-data'
bucket_name = ""#os.environ['SSO_DATA_BUCKET']

region = input("\nEnter the AWS region where your IAM Identity Center is running(eg. us-east-1): ")
print('Selected region:', region)
print('\nPlease wait while the script is running...\n')

org_client = boto3.client('organizations', region_name = 'us-east-1')
account_ids = get_account_list(org_client)

sso_admin_client = boto3.client('sso-admin', region_name = region)
ps_paginator = sso_admin_client.get_paginator('list_permission_sets_provisioned_to_account')
acc_assignment_paginator = sso_admin_client.get_paginator('list_account_assignments')

identity_store_client = boto3.client('identitystore', region_name = region)

instance_arn, instance_id = get_sso_instance_arn(sso_admin_client)


csv_headers = ['Saml_Provider_Name', 'Role_Name', 'Attached_Managed_Policies', 'Customer_Managed_Policies', 'Inline_Policy','IdPMetadataFileName']

permission_sets_map = {}
okta_group_role_map = {}

for account_id in account_ids:
    sso_data = []
    ps_response_iterator = ps_paginator.paginate(InstanceArn=instance_arn, AccountId=account_id)
    permission_sets = []
    for ps in ps_response_iterator:
        permission_sets.extend(ps.get('PermissionSets', []))

    if len(permission_sets) > 1:
            sso_data = get_sso_account_data(permission_sets, account_id, sso_admin_client, instance_arn)

            permission_sets_names = permission_sets_name(sso_admin_client, permission_sets, instance_arn)

            upload_custom_policy_to_s3(permission_sets, None , account_id, sso_admin_client, instance_arn)

            for name in permission_sets_names:
                if name not in permission_sets_map:
                    permission_sets_map[name] = {"account_id": [], "Attached_Managed_Policies": [], "Customer_Managed_Policies": [], "Inline_Policy": ''}
                permission_sets_map[name]["account_id"].append(account_id)
                for sso_entry in sso_data:
                    if sso_entry["Role_Name"] == name:
                        permission_sets_map[name]["Attached_Managed_Policies"] = sso_entry["Attached_Managed_Policies"]
                        permission_sets_map[name]["Customer_Managed_Policies"] = sso_entry["Customer_Managed_Policies"]
                        if sso_entry["Inline_Policy"] == 'No':
                            permission_sets_map[name]["Inline_Policy"] = ''
                        else:
                            permission_sets_map[name]["Inline_Policy"] = sso_entry["Inline_Policy"]
                        break

                account_assignment_iterator = acc_assignment_paginator.paginate(AccountId=account_id, InstanceArn=instance_arn, PermissionSetArn=permission_sets_names[name])
                account_assignments = []
                for assignment in account_assignment_iterator:
                    account_assignments.extend(assignment.get('AccountAssignments', []))

                if len(account_assignments) > 1:
                    for assignment in account_assignments:
                        if assignment['PrincipalType'] == 'GROUP':
                            group_memberships = identity_store_client.list_group_memberships(
                                IdentityStoreId=instance_id,
                                GroupId=assignment['PrincipalId'],
                                MaxResults=100
                            )
                            if len(group_memberships) > 1:
                                for member in group_memberships['GroupMemberships']:
                                    try:
                                        user_desc = identity_store_client.describe_user(
                                            IdentityStoreId=instance_id,
                                            UserId=member['MemberId']['UserId']
                                        )
                                        if user_desc['Emails'][0]['Value'] not in okta_group_role_map:
                                            okta_group_role_map[user_desc['Emails'][0]['Value']] = {'first_name': user_desc['Name']['GivenName'], 'last_name': user_desc['Name']['FamilyName'], 'groups': set()}
                                        okta_group_role_map[user_desc['Emails'][0]['Value']]['groups'].add(f'aws#acc#{name}#{assignment["AccountId"]}')
                                    except ClientError as e:
                                        if e.response['Error']['Code'] == 'ResourceNotFoundException':
                                            pass
                        else:
                            try:
                                user_desc = identity_store_client.describe_user(
                                    IdentityStoreId=instance_id,
                                    UserId=assignment['PrincipalId']
                                )
                                if user_desc['Emails'][0]['Value'] not in okta_group_role_map:
                                    okta_group_role_map[user_desc['Emails'][0]['Value']] = {'first_name': user_desc['Name']['GivenName'], 'last_name': user_desc['Name']['FamilyName'], 'groups': set()}
                                okta_group_role_map[user_desc['Emails'][0]['Value']]['groups'].add(f'aws#acc#{name}#{assignment["AccountId"]}')
                            except ClientError as e:
                                if e.response['Error']['Code'] == 'ResourceNotFoundException':
                                    pass

    filename = 'extracted-data/' + account_id + '.csv'
    with open(filename, 'w') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames = csv_headers)
        writer.writeheader()
        writer.writerows(sso_data)

generate_locals_tf(okta_group_role_map)
create_config_json(permission_sets_map, account_ids)

print('AWS SSO data extraction completed...\n')

choice = ''
while choice.lower() != 'y':
    choice = input('Insert customer managed policy jsons inside "aws/customer-managed-policy-json" directory...\n\tJson nomenclature: <customer-managed-policy-name>_sso.json\n\tOnce done enter y or Y...')

print('\nCreating resources...\n')
os.system('./launch.sh')

print('\nExecution Finished...\n')
