#!/bin/bash

echo "Provide Stack Name"
read name

echo "--------------------------Creating CloudFormation Stack----------------------------------"
aws cloudformation create-stack --stack-name $name --template-body file://csye6225-cf-networking.json 
<<<<<<< HEAD





=======
>>>>>>> 304a9d8064835fd17a3ed3bee9e9b4ffe79d71f7
