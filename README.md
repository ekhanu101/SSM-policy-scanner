# SSMPolicy-Scanner

## Purpose
The use of this repository is for checking Non-EKS related EC2 instances to check for their roles/policies.

## Usage
Once cloned to your client, do the following:

- Start out by setting the AWS_PROFILE environment variable to the target account

```export AWS_PROFILE=<account_name>```

- Make sure that it is able to execute

```chmod +x id_list.sh```

- Run the command

```bash id_list.sh```

