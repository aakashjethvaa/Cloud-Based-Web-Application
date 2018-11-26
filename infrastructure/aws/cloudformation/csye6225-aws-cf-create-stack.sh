#!/bin/bash

echo "Provide Stack Name"
read name

echo "--------------------------Creating CloudFormation Stack----------------------------------"
aws cloudformation create-stack --stack-name $name --template-body file://csye6225-cf-networking.json 

