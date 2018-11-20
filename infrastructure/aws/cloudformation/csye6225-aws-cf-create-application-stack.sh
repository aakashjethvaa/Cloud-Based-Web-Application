<<<<<<< HEAD
STACK_NAME=$1
VPC_NAME="${STACK_NAME}-csye6225-vpc"
EC2_NAME="ec2"
EC2VOL_SIZE="16"
EC2VOL_TYPE="gp2"
AMI_IMAGE="ami-9887c6e7"
DYNAMO_TABLE="csye6225"
MASTER_USERNAME="csye6225master"
MASTER_USERPWD="csye6225password"
DB_NAME="csye6225"
DB_INSTANCE_CLASS="db.t2.medium"
DB_INSTANCE_IDENTIFIER="csye6225-fall2018"
DB_ENGINE="MySQL"

echo "Enter Bucket name"
read name
BUCKET_NAME=$name
=======
#!/bin/bash
#Variables
>>>>>>> 17ab7d6fff12270986c87bec7d4d4eaca191b16e

stackname=$1
read -p "Enter your s3 bucket domain name: " s3domain
s3artifact="code-deploy.csye6225-fall2018-$s3domain.me.csye6225.com"
s3attachment="csye6225-fall2018-$s3domain.me.csye6225.com"

<<<<<<< HEAD
aws cloudformation create-stack --stack-name $STACK_NAME --capabilities "CAPABILITY_NAMED_IAM" --template-body file://csye6225-cf-application.json --parameters ParameterKey=VpcId,ParameterValue=$vpcId ParameterKey=EC2Name,ParameterValue=$EC2_NAME ParameterKey=EC2SecurityGroup,ParameterValue=$eC2SecurityGroupId ParameterKey=SubnetId1,ParameterValue=$subnetId1 ParameterKey=EC2VolumeSize,ParameterValue=$EC2VOL_SIZE ParameterKey=EC2VolumeType,ParameterValue=$EC2VOL_TYPE ParameterKey=AMIImage,ParameterValue=$AMI_IMAGE ParameterKey=DynamoDBName,ParameterValue=$DYNAMO_TABLE ParameterKey=MasterUsername,ParameterValue=$MASTER_USERNAME ParameterKey=MasterUserPwd,ParameterValue=$MASTER_USERPWD ParameterKey=DBName,ParameterValue=$DB_NAME ParameterKey=DBInstanceClass,ParameterValue=$DB_INSTANCE_CLASS ParameterKey=DBInstanceIdentifier,ParameterValue=$DB_INSTANCE_IDENTIFIER ParameterKey=DBEngine,ParameterValue=$DB_ENGINE ParameterKey=SubnetId2,ParameterValue=$subnetId2 ParameterKey=SubnetId3,ParameterValue=$subnetId3 ParameterKey=RDSSecurityGroup,ParameterValue=$rDSSecurityGroupId ParameterKey=BucketName,ParameterValue=$BUCKET_NAME ParameterKey=EC2RoleName,ParameterValue=$eC2RoleName
=======
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
>>>>>>> 17ab7d6fff12270986c87bec7d4d4eaca191b16e

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
