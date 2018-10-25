#!/bin/bash
#Variables

stackname=$1

domain=$(aws route53 list-hosted-zones --query HostedZones[0].Name --output text)
trimdomain=${domain::-1}
s3domain="code-deploy.$trimdomain"
echo "S3 Domain: $s3domain"
appname="csye6225CodeDeployApplication"
echo $appname
depname="csye6225CodeDeployApplication-depgroup"
echo $depname
accid=$(aws sts get-caller-identity --output text --query 'Account')
echo "AccountId: $accid"


createOutput=$(aws cloudformation create-stack --stack-name $stackname --capabilities CAPABILITY_NAMED_IAM --template-body file://csye6225-cf-cicd.json --parameters ParameterKey=s3domain,ParameterValue=$s3domain  ParameterKey=appname,ParameterValue=$appname ParameterKey=depname,ParameterValue=$depname ParameterKey=accid,ParameterValue=$accid)


if [ $? -eq 0 ]; then
	echo "Creating stack..."
	aws cloudformation wait stack-create-complete --stack-name $stackname
	echo "Stack created successfully. Stack Id below: "

	echo $createOutput

else
	echo "Error in creation of stack"
	echo $createOutput
fi;
