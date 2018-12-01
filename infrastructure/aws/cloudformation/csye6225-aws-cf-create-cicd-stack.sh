#!/bin/bash
#Variables

stackname=$1


read -p "Enter your s3 upload artifact bucket name: " s3domainName
s3domain="code-deploy.csye6225-fall2018-$s3domainName.me.csye6225.com"
echo "S3 Bucket: $s3domain"

accid=$(aws sts get-caller-identity --output text --query 'Account')
echo "AccountId: $accid"


createOutput=$(aws cloudformation create-stack --stack-name $stackname --capabilities CAPABILITY_NAMED_IAM --template-body file://csye6225-cf-ci-cd.json --parameters ParameterKey=s3domain,ParameterValue=$s3domain ParameterKey=accid,ParameterValue=$accid)


if [ $? -eq 0 ]; then
	echo "Creating stack..."
	aws cloudformation wait stack-create-complete --stack-name $stackname
	echo "Stack created successfully. Stack Id below: "

	echo $createOutput

else
	echo "Error in creation of stack"
	echo $createOutput
fi;
