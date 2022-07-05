import subprocess

def search_policies():
    with open('role_results.txt', 'r') as f:
        policies = [line.replace('\n', '') for line in f]
   
    for i in policies:
        try:
            role_res = subprocess.call(['aws', 'iam', 'list-attached-role-policies', '--role-name', f'{i}', '--output', 'json'])        
        except Exception as e:
            print(e)

if __name__ == "__main__":
    search_policies()
