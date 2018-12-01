#!/bin/bash
#Variables

stackname=$1
read -p "Enter your s3 bucket domain name: " s3domain
s3artifact="code-deploy.csye6225-fall2018-$s3domain.me.csye6225.com"
s3attachment="csye6225-fall2018-$s3domain.me.csye6225.com"

export VpcId=$(aws ec2 describe-vpcs --query "Vpcs[0]. [VpcId]" --output text)
export subnetid=$(aws ec2 describe-subnets --query 'Subnets[*].[SubnetId, VpcId, AvailabilityZone, CidrBlock]' --output text|grep 10.0.1.0/24|grep us-east-1a|awk '{print $1}')
export securitygrp=$(aws ec2 describe-security-groups --query 'SecurityGroups[0].[GroupId]' --output text| awk '{print $1}')
echo $VpcId
echo $subnetid
echo $securitygrp
instanceProfileName=$(aws iam list-instance-profiles --query InstanceProfiles[].InstanceProfileName --output text| awk '{print $1}')
echo $instanceProfileName
echo "S3 code deploy bucket: $s3artifact"
echo "S3 attachement bucket: $s3attachment"

createOutput=$(aws cloudformation create-stack --stack-name $stackname --template-body file://csye6225-cf-application.json --parameters ParameterKey=stackname,ParameterValue=$stackname ParameterKey=subnetid,ParameterValue=$subnetid ParameterKey=securitygrp,ParameterValue=$securitygrp ParameterKey=VpcId,ParameterValue=$VpcId ParameterKey=instanceProfileName,ParameterValue=$instanceProfileName ParameterKey=s3artifact,ParameterValue=$s3artifact ParameterKey=s3attachment,ParameterValue=$s3attachment)


if [ $? -eq 0 ]; then
	echo "Creating stack..."
	aws cloudformation wait stack-create-complete --stack-name $stackname
	echo "Stack created successfully. Stack Id below: "

	echo $createOutput

else
	echo "Error in creation of stack"
	echo $createOutput
fi;

	

