#!/bin/bash

#Before running this script, make sure you set your AWS_PROFILE
#to the account you would like to check
set -e
CURRENT_PROFILE=$(aws sts get-caller-identity)

#Outputs file that lists all Instance IDs NOT containing 'alpha.eksctl.io/cluster-name' tag Key

profileSearch() {
#Querying Instance Profile Associations
echo "---------- CURRENT AWS ENVIRONMENT ----------"
echo $CURRENT_PROFILE
sleep .5
echo "Querying Instance Profiles"
aws ec2 describe-instances --query "Reservations[].Instances[?!(Tags[?Key=='alpha.eksctl.io/cluster-name'])][].IamInstanceProfile.Arn" > profile_arn.json
echo "Instance Profiles Collected!"

sleep .5
}

arnFormatter() {
#Script to clean up output from instance profile query for further consumption
FILE=profile_arn.json

for f in $FILE
do
  echo "---------- Processing $f ----------"
  cat $f | sed '1d;$d;s/.$//' | awk -F'/' '{print $2}' > roles_tmp.txt
done

ROLES=roles_tmp.txt
for r in $ROLES
do
  cat $r | sed -r 's/["]+//g' > instance_profiles.txt
done

sleep .5
rm roles_tmp.txt

echo "---------- Obtained Roles from Instance Profiles ----------"
sleep .5
}

pyRoles() {
    #Runs the subprocess Python3 script to output the results of the Roles from the instance profiles
    echo "---------- Showing Results of the Roles ----------"
    python3 get_roles.py > role_results.txt
    cat role_results.txt
    echo "---------- DONE ----------"
    sleep 1
}

pyPolicies() {
    #Runs the subprocess Python3 script to output the Policies relating to the roles
    #each block of "AttachedPolicies" Relates back to the Roles in the previous file
    echo "---------- Showing Policies Attached to the Roles in Order ----------"
    python3 get_policies.py > policy_results.json
    cat policy_results.json
    echo "---------- DONE ----------"
    sleep 1
}

profileSearch
arnFormatter
pyRoles
pyPolicies