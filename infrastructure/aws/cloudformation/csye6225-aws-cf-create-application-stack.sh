#!/bin/bash
#Variables

stackname=$1


export VpcId=$(aws ec2 describe-vpcs --query "Vpcs[1]. [VpcId]" --output text)
export subnetid=$(aws ec2 describe-subnets --query 'Subnets[*].[SubnetId, VpcId, AvailabilityZone, CidrBlock]' --output text|grep 10.0.1.0/24|grep us-east-1a|awk '{print $1}')
export securitygrp=$(aws ec2 describe-security-groups --query 'SecurityGroups[0].[GroupId]' --output text| awk '{print $1}')
echo $VpcId
echo $subnetid
echo $securitygrp
createOutput=$(aws cloudformation create-stack --stack-name $stackname --template-body file://csye6225-cf-application.json --parameters ParameterKey=stackname,ParameterValue=$stackname ParameterKey=subnetid,ParameterValue=$subnetid ParameterKey=securitygrp,ParameterValue=$securitygrp ParameterKey=VpcId,ParameterValue=$VpcId)


if [ $? -eq 0 ]; then
	echo "Creating stack..."
	aws cloudformation wait stack-create-complete --stack-name $stackname
	echo "Stack created successfully. Stack Id below: "

	echo $createOutput

else
	echo "Error in creation of stack"
	echo $createOutput
fi;
