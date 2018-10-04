#!/bin/bash

echo "Enter Stack Name"
read name

echo "Creating CloudFormation application Stack"
aws cloudformation create-stack --stack-name $name --template-body file://csye6225-cf-application.json 
