import csv, json
from client import get_client


def upload_file_s3(file, bucket_name, bucket_key):
    s3_client = get_client('s3')
    with open(file, 'rb') as data:
        s3_client.upload_fileobj(data, bucket_name, bucket_key)


def get_account_list(client):
    accounts = client.list_accounts()
    account_ids = []
    for account in accounts['Accounts']:
        account_ids.append(account['Id'])
    return account_ids


def upload_account_ids_to_s3(account_ids, bucket_name):
    filename = 'extracted-data/'+'accounts_ids.csv'
    with open(filename, 'w') as csvfile:
        write = csv.writer(csvfile)
        for element in account_ids:
            write.writerow([element])
    bucket_key = 'accounts_ids.csv'
    # upload_file_s3(filename, bucket_name, bucket_key)


def get_sso_instance_arn(client):
    instance_info = client.list_instances()
    instance_arn = instance_info['Instances'][0]['InstanceArn']
    instance_id = instance_info['Instances'][0]['IdentityStoreId']
    return instance_arn, instance_id


def underscore_remover(name):
    name_list = list(name)
    name_length = len(name_list)
    for counter in range(name_length):
        if ord(name_list[counter]) == 95:
            name_list[counter] = '-'
    sep = ''
    name_string = sep.join(name_list)
    return name_string


def camelcase_changer(name):
    name_list = list(name)
    name_length = len(name_list)
    camelcasing_index = []
    changed_name = name
    for counter in range(name_length - 1):
        current_char = ord(name_list[counter])
        next_char = ord(name_list[counter+1])
        if (current_char >= 97 and current_char<= 122) and (next_char >= 65 and next_char<= 90):
            camelcasing_index.append(counter)
    if len(camelcasing_index)>0:
        counter = 1
        for index in camelcasing_index:
            name_list.insert(index+counter,'-')
            counter+=1
        sep = ''
        changed_name = sep.join(name_list)
    changed_name = changed_name.lower()
    return changed_name



# def get_policy_arn(policy_name):
#     iam_client = get_client('iam')
    
#     paginator = iam_client.get_paginator('list_policies')
    
#     for page in paginator.paginate(Scope='AWS'):
#         for policy in page['Policies']:
#             if policy['PolicyName'] == policy_name:
#                 return policy['Arn']
    
#     return None



def get_policy_arn(policy_name):
    iam_client = get_client('iam')
    
    try:
        response = iam_client.get_policy(
            PolicyArn=f'arn:aws:iam::aws:policy/{policy_name}'
        )
        arn = response['Policy']['Arn']
    except:
        arn = f'arn:aws:iam::aws:policy/job-function/{policy_name}'
    
    return arn



def get_sso_account_data(permission_sets_arns, account, client, instance_arn):
    sso_info_list=[]
    for permission_set_arn in permission_sets_arns:
        inline_policy_status = 'No'

        permission_set_description = client.describe_permission_set(InstanceArn=instance_arn, PermissionSetArn=permission_set_arn)
        permission_set_name = permission_set_description['PermissionSet']['Name']
        # permission_set_name = camelcase_changer(underscore_remover(permission_set_description['PermissionSet']['Name']))
        managed_policies = client.list_managed_policies_in_permission_set(InstanceArn=instance_arn, PermissionSetArn=permission_set_arn)
        customer_managed_policies = client.list_customer_managed_policy_references_in_permission_set(InstanceArn=instance_arn, PermissionSetArn=permission_set_arn)
        inline_policy = client.get_inline_policy_for_permission_set(InstanceArn=instance_arn, PermissionSetArn=permission_set_arn)

        aws_managed_policy =[]
        customer_managed_policy =[]

        for policy in managed_policies['AttachedManagedPolicies']:
            # aws_managed_policy.append(policy['Name'])
            arn = get_policy_arn(policy['Name'])
            aws_managed_policy.append(arn)

        for policy in customer_managed_policies['CustomerManagedPolicyReferences']:
            customer_managed_policy.append(policy['Name'])

        if len(inline_policy['InlinePolicy'])>0:
            inline_policy_status = permission_set_name + '.json'

        sso_data = {}
        sso_data.update({'Saml_Provider_Name': 'aws-sso-'+ permission_set_name+'-'+ account+'-'+'DONOTDELETE'})
        sso_data.update({'Role_Name': permission_set_name})
        sso_data.update({'Attached_Managed_Policies': aws_managed_policy})
        sso_data.update({'Customer_Managed_Policies': customer_managed_policy})
        sso_data.update({'Inline_Policy': inline_policy_status})
        sso_info_list.append(sso_data)

    return sso_info_list



def upload_custom_policy_to_s3(permission_sets_arns, bucket_name , account_id, client, instance_arn):
    for permission_set_arn in permission_sets_arns:
        custom_policy = client.get_inline_policy_for_permission_set(InstanceArn=instance_arn, PermissionSetArn=permission_set_arn)
        foldername = account_id
        if len(custom_policy['InlinePolicy'])>0:
            permission_set_description = client.describe_permission_set(InstanceArn = instance_arn, PermissionSetArn= permission_set_arn)
            permission_set_name = permission_set_description['PermissionSet']['Name']
            # permission_set_name = camelcase_changer(underscore_remover(permission_set_description['PermissionSet']['Name']))
            file_name = 'aws/inline-policy-json/' + permission_set_name + '.json'
            bucket_key = foldername + '/' + permission_set_name + '.json'
            with open(file_name, 'w') as outfile:
                outfile.write(custom_policy['InlinePolicy'])
            # upload_file_s3(file_name, bucket_name, bucket_key)



def permission_sets_name(client, permission_sets_arns, instance_arn):
    permission_sets = {}
    for permission_set in permission_sets_arns:
        response = client.describe_permission_set(
            InstanceArn=instance_arn,
            PermissionSetArn=permission_set
        )
        permission_sets[response['PermissionSet']['Name']] = permission_set

    return permission_sets



def convert_to_policy_dicts(policy_names):
    policy_dicts = []
    for name in policy_names:
        policy_dict = {
            "name": name,
            "policy_json": f"customer-managed-policy-json/{name}.json"
        }
        policy_dicts.append(policy_dict)
    return policy_dicts



def create_config_json(permission_sets_map, account_ids):
    config = '"account_no": '
    config += f'{account_ids},'

    for permission_set in permission_sets_map:

        config += f' "{permission_set}": '  
        config += '{{ "account_id": {account_id}, '.format(account_id=permission_sets_map[permission_set]["account_id"])

        config += '"policies": '
        policy_dicts = convert_to_policy_dicts(permission_sets_map[permission_set]['Customer_Managed_Policies'])
        config += f'{policy_dicts}, '  

        if permission_sets_map[permission_set]["Inline_Policy"]:
            inline_policy_dict = {
                permission_sets_map[permission_set]["Inline_Policy"].split('.')[0]: f'inline-policy-json/{permission_sets_map[permission_set]["Inline_Policy"]}'
            }
            config += f'"inline_policies": [{inline_policy_dict}], '

        policy_dicts = [f'{item}' for item in permission_sets_map[permission_set]['Attached_Managed_Policies']]
        config += f'"managed_policy": {policy_dicts} ' 
        config += ' }, '
    
    config = f'{{ {config} }}'
    config = config[:-4]
    config += ' }'
    config = config.replace("'",'"')

    config = json.loads(config)
    file_name = 'config' + '.json'
    with open(file_name, 'w') as outfile:
        json.dump(config, outfile, indent=4)


# def generate_locals_tf(data, file_path='okta/locals.tf'):
#     with open(file_path, 'w') as file:
#         file.write('locals {\n')
#         file.write('  aws_roles = {\n')

#         for key, value in data.items():
#             file.write(f'    "{key}" = ')
#             if isinstance(value, list) and value:
#                 file.write('[\n')
#                 for item in value:
#                     file.write('      {\n')
#                     for sub_key, sub_value in item.items():
#                         file.write(f'        {sub_key} = "{sub_value}"\n')
#                     file.write('      },\n')
#                 file.write('    ]\n')
#             else:
#                 file.write('[]\n')
        
#         file.write('  }\n')
#         file.write('}\n')



def generate_locals_tf(data, file_path='okta/locals.tf'):
    with open(file_path, "w") as file:
        file.write("locals {\n")
        file.write("  users = {\n")
        for email, details in data.items():
            file.write(f'    "{email}" = {{\n')
            file.write(f'      first_name = "{details["first_name"]}"\n')
            file.write(f'      last_name = "{details["last_name"]}"\n')
            file.write(f'      groups = [\n')
            for group in details['groups']:
                file.write(f'        "{group}",\n')
            file.write(f'      ]\n')
            file.write(f'    }}\n')
        file.write("  }\n")
        file.write("}\n")
