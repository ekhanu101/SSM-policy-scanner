import subprocess

def search_role():
    with open('instance_profiles.txt', 'r') as f:
        in_pr = [line.replace('\n', '') for line in f]
   
    for i in in_pr:
        try:
            role_res = subprocess.call(['aws', 'iam', 'get-instance-profile', '--instance-profile-name', f'{i}', '--query', \
                 'InstanceProfile.Roles[].RoleName[]', '--output', 'text'])        
        except Exception as e:
            print(e)
    
if __name__ == "__main__":
    search_role()
