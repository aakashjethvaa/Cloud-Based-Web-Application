#!/bin/bash

echo "Enter Stack Name"
read name

echo "Deleting CloudFormation Stack"
aws cloudformation delete-stack --stack-name $name
