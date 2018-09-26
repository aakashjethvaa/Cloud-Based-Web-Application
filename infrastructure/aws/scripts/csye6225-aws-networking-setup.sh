#!/bin/bash
#
#DESCRIPTION
# This shell script contains the AWS commnd Line Interface to
# automatically create a custome VPC. 
#
#==========================================================
#NOTE
#CONTRIBUTOR: KOMAL, KIRAN, AAKASH, HEMANT
#ASSIGNMENT_2
#
#FINAL VALUES
AWS_REGION="us-east-1"
VPC_NAME="myVPC"
VPC_CIDR="10.0.0.0/16"
SUBNET_PUBLIC_CIDR_B="10.0.1.0/24"
SUBNET_PUBLIC_CIDR_A="10.0.0.0/24"
SUBNET_PUBLIC_CIDR_C="10.0.3.0/24"
SUBNET_REGION_A="us-east-1a"
SUBNET_REGION_B="us-east-1b"
SUBNET_REGION_C="us-east-1c"
SUBNET_REGION_D="us-east-1d"
#
#
#Create VPC
echo "creating VPC in $AWS_REGION.."

#VPC_ID=$(aws ec2 create-vpc \
 # --cidr-block $VPC_CIDR \
 # --query 'Vpc.{VpcId:VpcId}' \
 # --output text \
 # --region $AWS_REGION)
echo "  VPC ID '$VPC_ID' CREATED in '$AWS_REGION' region."

aws ec2 create-tags \
  --resources $VPC_ID \
  --tags "Key=Name,Value=$VPC_NAME" \
  --region $AWS_REGION
echo "  VPC ID '$VPC_ID' NAMED as '$VPC_NAME'."

echo "creating first subnet"

echo "Creating Public Subnet..."
SUBNET_PUBLIC_ID=$(aws ec2 create-subnet \
  --vpc-id $VPC_ID  \
  --cidr-block $SUBNET_PUBLIC_CIDR_A \
  --availability-zone $SUBNET_REGION_A \
  --query 'Subnet.{SubnetId:SubnetId}' \
  --output text \
  --region $AWS_REGION)
echo "  Subnet ID '$SUBNET_PUBLIC_ID' CREATED in '$SUBNET_REGION_A'" \
"Availability Zone."



