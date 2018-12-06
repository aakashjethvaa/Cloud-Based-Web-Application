#!/bin/bash
#Variables

stackname=$1
read -p "Enter your s3 bucket domain name: " s3domain
s3artifact="code-deploy.csye6225-fall2018-$s3domain.me.csye6225.com"
s3attachment="csye6225-fall2018-$s3domain.me.csye6225.com"
domain="csye6225-fall2018-$s3domain.me"

appname="csye6225CodeDeployApplication"
echo $appname
depname="csye6225CodeDeployApplication-depgroup"
echo $depname



#hostedzone=${s3attachment::-1}

HZID=$(aws route53 list-hosted-zones --query 'HostedZones[0].Id' --output text)
HZID=${HZID#*e/}
echo $HZID

certARN=$(aws acm list-certificates --query CertificateSummaryList[].CertificateArn  --output text)
echo "$certARN"

export VpcId=$(aws ec2 describe-vpcs --query "Vpcs[1]. [VpcId]" --output text)
export subnetid=$(aws ec2 describe-subnets --query 'Subnets[*].[SubnetId, VpcId, AvailabilityZone, CidrBlock]' --output text|grep 10.0.1.0/24|grep us-east-1a|awk '{print $1}')
export securitygrp=$(aws ec2 describe-security-groups --query 'SecurityGroups[0].[GroupId]' --output text| awk '{print $1}')
echo $VpcId
echo $subnetid
echo $securitygrp
instanceProfileName=$(aws iam list-instance-profiles --query InstanceProfiles[].InstanceProfileName --output text| awk '{print $1}')
echo $instanceProfileName
echo "S3 code deploy bucket: $s3artifact"
echo "S3 attachement bucket: $s3attachment"

createOutput=$(aws cloudformation create-stack --stack-name $stackname --template-body file://csye6225-cf-auto-scaling-application.json --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM --parameters ParameterKey=stackname,ParameterValue=$stackname ParameterKey=subnetid,ParameterValue=$subnetid ParameterKey=securitygrp,ParameterValue=$securitygrp ParameterKey=VpcId,ParameterValue=$VpcId ParameterKey=instanceProfileName,ParameterValue=$instanceProfileName ParameterKey=s3artifact,ParameterValue=$s3artifact ParameterKey=s3attachment,ParameterValue=$s3attachment ParameterKey=hostedzone,ParameterValue=$domain ParameterKey=hzid,ParameterValue=$HZID ParameterKey=certARN,ParameterValue=$certARN ParameterKey=appname,ParameterValue=$appname ParameterKey=depname,ParameterValue=$depname)


if [ $? -eq 0 ]; then
	echo "Creating stack..."
	aws cloudformation wait stack-create-complete --stack-name $stackname
	echo "Stack created successfully. Stack Id below: "

	echo $createOutput

else
	echo "Error in creation of stack"
	echo $createOutput
fi;
ParameterKey=appname,ParameterValue=$appname ParameterKey=depname,ParameterValue=$depname
