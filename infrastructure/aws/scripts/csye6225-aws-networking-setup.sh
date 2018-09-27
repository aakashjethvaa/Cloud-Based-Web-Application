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
echo "Enter AWS region"
read AWS_REGION
echo "Enter VPC name"
read VPC_NAME
echo "Enter VPC cidr"
read VPC_CIDR 

#SUBNET_PUBLIC_CIDR="10.0.1.0/24"
#SUBNET_PUBLIC_CIDR_A="10.0.0.0/24"
#SUBNET_PUBLIC_CIDR_C="10.0.2.0/24"
#SUBNET_REGION_A="us-east-1a"
#SUBNET_REGION_B="us-east-1b"
#SUBNET_REGION_C="us-east-1c"
#SUBNET_REGION_D="us-east-1d"
#
#
#Create VPC
echo "creating VPC in $AWS_REGION.."

VPC_ID=$(aws ec2 create-vpc \
  --cidr-block $VPC_CIDR \
  --query 'Vpc.{VpcId:VpcId}' \
  --output text \
  --region $AWS_REGION)
echo "  VPC ID '$VPC_ID' CREATED in '$AWS_REGION' region."

aws ec2 create-tags \
  --resources $VPC_ID \
  --tags "Key=Name,Value=$VPC_NAME" \
  --region $AWS_REGION
echo "  VPC ID '$VPC_ID' NAMED as '$VPC_NAME'."


echo "Creating Public Subnet..."
echo "Enter Subnet public cidr"
read SUBNET_CIDR
echo "Enter Subnet region"
read SUBNET_REGION
SUBNET_PUBLIC_ID=$(aws ec2 create-subnet \
  --vpc-id $VPC_ID  \
  --cidr-block $SUBNET_CIDR \
  --availability-zone $SUBNET_REGION \
  --query 'Subnet.{SubnetId:SubnetId}' \
  --output text \
  --region $AWS_REGION)
echo "  Subnet ID '$SUBNET_ID' CREATED in '$SUBNET_REGION'" \
"Availability Zone."

# Add Name tag to Public Subnet
aws ec2 create-tags \
  --resources $SUBNET_ID \
  --tags "Key=Name,Value=$SUBNET_NAME" \
  --region $AWS_REGION
echo "  Subnet ID '$SUBNET_ID' NAMED as" \
"'$SUBNET_NAME'."

##################################################################
#create one more subnet

echo "Do you want to create another subnet in this VPC?(y/N)"
read x

# now check if $x is "y"
if [ "$x" = "y" ]; then

echo "Creating Subnet..."
echo "Enter Subnet cidr .."
read SUBNET_CIDR
echo "Enter Subnet region"
read SUBNET_REGION
echo "Enter Subnet Name"
read SUBNET_NAME

SUBNET_ID=$(aws ec2 create-subnet \
  --vpc-id $VPC_ID  \
  --cidr-block $SUBNET_CIDR \
  --availability-zone $SUBNET_REGION \
  --query 'Subnet.{SubnetId:SubnetId}' \
  --output text \
  --region $AWS_REGION)
echo "  Subnet ID '$SUBNET_ID' CREATED in '$SUBNET_REGION'" \
"Availability Zone."

# Add Name tag to Public Subnet
aws ec2 create-tags \
  --resources $SUBNET_ID \
  --tags "Key=Name,Value=$SUBNET_NAME" \
  --region $AWS_REGION
echo "  Subnet ID '$SUBNET_ID' NAMED as" \
"'$SUBNET_NAME'."

fi

####################################################
echo "Make your subnet public"
echo "Create an Internet Gateway"

IGW_ID=$(aws ec2 create-internet-gateway \
  --query 'InternetGateway.{InternetGatewayId:InternetGatewayId}' \
  --output text \
  --region $AWS_REGION)
echo "  Internet Gateway ID '$IGW_ID' CREATED."
echo "Attaching Internet gateway to VPC ID..."

aws ec2 attach-internet-gateway \
  --vpc-id $VPC_ID \
  --internet-gateway-id $IGW_ID \
  --region $AWS_REGION
echo "  Internet Gateway ID '$IGW_ID' ATTACHED to VPC ID '$VPC_ID'."


# Create Route Table
echo "Creating Route Table..."
ROUTE_TABLE_ID=$(aws ec2 create-route-table \
  --vpc-id $VPC_ID \
  --query 'RouteTable.{RouteTableId:RouteTableId}' \
  --output text \
  --region $AWS_REGION)
echo "  Route Table ID '$ROUTE_TABLE_ID' CREATED."


# Create route to Internet Gateway
RESULT=$(aws ec2 create-route \
  --route-table-id $ROUTE_TABLE_ID \
  --destination-cidr-block 0.0.0.0/0 \
  --gateway-id $IGW_ID \
  --region $AWS_REGION)
echo "  Route to '0.0.0.0/0' via Internet Gateway ID '$IGW_ID' ADDED to" \
"Route Table ID '$ROUTE_TABLE_ID'."

# Associate Public Subnet with Route Table

RESULT=$(aws ec2 associate-route-table  \
  --subnet-id $SUBNET_ID \
  --route-table-id $ROUTE_TABLE_ID \
  --region $AWS_REGION)
echo "  Public Subnet ID '$SUBNET__ID' ASSOCIATED with Route Table ID" \
"'$ROUTE_TABLE_ID'."

############################################################




