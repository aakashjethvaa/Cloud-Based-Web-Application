#!/bin/bash
# Create VPC
echo "Creating VPC"
echo "Enter AWS region"
read AWS_REGION
echo "Enter VPC cidr"
read VPC_CIDR


VPC_ID=$(aws ec2 create-vpc \
  --cidr-block $VPC_CIDR \
  --query 'Vpc.{VpcId:VpcId}' \
  --output text \
  --region $AWS_REGION)
echo "  VPC ID '$VPC_ID' CREATED in '$AWS_REGION' region."

echo "Enter VPC name"
read VPC_NAME
# Add Name tag to VPC
aws ec2 create-tags \
  --resources $VPC_ID \
  --tags "Key=Name,Value=$VPC_NAME" \
  --region $AWS_REGION
echo " VPC ID '$VPC_ID' NAMED as '$VPC_NAME'."


# Create Public Subnet
echo "Creating first Public Subnet..."
echo "Enter Subnet public CIDR"
read SUBNET_PUBLIC_CIDR1
echo "Enter Subnet public availibility Zone"
read SUBNET_PUBLIC_AZ1
echo "Enter public subnet 1 name"
read SUBNET_PUBLIC_NAME1

SUBNET_PUBLIC_ID1=$(aws ec2 create-subnet \
  --vpc-id $VPC_ID \
  --cidr-block $SUBNET_PUBLIC_CIDR1 \
  --availability-zone $SUBNET_PUBLIC_AZ1 \
  --query 'Subnet.{SubnetId:SubnetId}' \
  --output text \
  --region $AWS_REGION)
echo "  Subnet ID '$SUBNET_PUBLIC_ID1' CREATED in '$SUBNET_PUBLIC_AZ1'" \
  "Availability Zone."

# Add Name tag to Public Subnet
aws ec2 create-tags \
  --resources $SUBNET_PUBLIC_ID1 \
  --tags "Key=Name,Value=$SUBNET_PUBLIC_NAME1" \
  --region $AWS_REGION
echo "  Subnet ID '$SUBNET_PUBLIC_ID1' NAMED as" \
  "'$SUBNET_PUBLIC_NAME1'."


echo "Creating second Public Subnet..."
echo "Enter Subnet public CIDR"
read SUBNET_PUBLIC_CIDR2
echo "Enter Subnet public availibility Zone"
read SUBNET_PUBLIC_AZ2
echo "Enter public subnet 2 name"
read SUBNET_PUBLIC_NAME2

SUBNET_PUBLIC_ID2=$(aws ec2 create-subnet \
  --vpc-id $VPC_ID \
  --cidr-block $SUBNET_PUBLIC_CIDR2 \
  --availability-zone $SUBNET_PUBLIC_AZ2 \
  --query 'Subnet.{SubnetId:SubnetId}' \
  --output text \
  --region $AWS_REGION)
echo "  Subnet ID '$SUBNET_PUBLIC_ID2' CREATED in '$SUBNET_PUBLIC_AZ2'" \
  "Availability Zone."

# Add Name tag to Public Subnet
aws ec2 create-tags \
  --resources $SUBNET_PUBLIC_ID2 \
  --tags "Key=Name,Value=$SUBNET_PUBLIC_NAME2" \
  --region $AWS_REGION
echo "  Subnet ID '$SUBNET_PUBLIC_ID2' NAMED as" \
  "'$SUBNET_PUBLIC_NAME2'."


echo "Creating third Public Subnet..."
echo "Enter Subnet public CIDR"
read SUBNET_PUBLIC_CIDR3
echo "Enter Subnet public availibility Zone"
read SUBNET_PUBLIC_AZ3
echo "Enter public subnet 3 name"
read SUBNET_PUBLIC_NAME3

SUBNET_PUBLIC_ID3=$(aws ec2 create-subnet \
  --vpc-id $VPC_ID \
  --cidr-block $SUBNET_PUBLIC_CIDR3 \
  --availability-zone $SUBNET_PUBLIC_AZ3 \
  --query 'Subnet.{SubnetId:SubnetId}' \
  --output text \
  --region $AWS_REGION)
echo "  Subnet ID '$SUBNET_PUBLIC_ID3' CREATED in '$SUBNET_PUBLIC_AZ3'" \
  "Availability Zone."

# Add Name tag to Public Subnet
aws ec2 create-tags \
  --resources $SUBNET_PUBLIC_ID3 \
  --tags "Key=Name,Value=$SUBNET_PUBLIC_NAME3" \
  --region $AWS_REGION
echo "  Subnet ID '$SUBNET_PUBLIC_ID3' NAMED as" \
  "'$SUBNET_PUBLIC_NAME3'."


# Create Private Subnet

echo "Creating Private Subnet..."
echo "Creating first Private Subnet..."
echo "Enter Subnet private CIDR1"
read SUBNET_PRIVATE_CIDR1
echo "Enter Subnet private availibility Zone1"
read SUBNET_PRIVATE_AZ1
echo "Enter private subnet 1 name"
read SUBNET_PRIVATE_NAME1


SUBNET_PRIVATE_ID1=$(aws ec2 create-subnet \
  --vpc-id $VPC_ID \
  --cidr-block $SUBNET_PRIVATE_CIDR1 \
  --availability-zone $SUBNET_PRIVATE_AZ1 \
  --query 'Subnet.{SubnetId:SubnetId}' \
  --output text \
  --region $AWS_REGION)
echo "  Subnet ID '$SUBNET_PRIVATE_ID1' CREATED in '$SUBNET_PRIVATE_AZ1'" \
  "Availability Zone."

# Add Name tag to Private Subnet
aws ec2 create-tags \
  --resources $SUBNET_PRIVATE_ID1 \
  --tags "Key=Name,Value=$SUBNET_PRIVATE_NAME1" \
  --region $AWS_REGION
echo "  Subnet ID '$SUBNET_PRIVATE_ID1' NAMED as '$SUBNET_PRIVATE_NAME1'."


echo "Creating second Private Subnet..."
echo "Enter Subnet private CIDR2"
read SUBNET_PRIVATE_CIDR2
echo "Enter Subnet private availibility Zone2"
read SUBNET_PRIVATE_AZ2
echo "Enter private subnet 2 name"
read SUBNET_PRIVATE_NAME2


SUBNET_PRIVATE_ID2=$(aws ec2 create-subnet \
  --vpc-id $VPC_ID \
  --cidr-block $SUBNET_PRIVATE_CIDR2 \
  --availability-zone $SUBNET_PRIVATE_AZ2 \
  --query 'Subnet.{SubnetId:SubnetId}' \
  --output text \
  --region $AWS_REGION)
echo "  Subnet ID '$SUBNET_PRIVATE_ID2' CREATED in '$SUBNET_PRIVATE_AZ2'" \
  "Availability Zone."

# Add Name tag to Private Subnet
aws ec2 create-tags \
  --resources $SUBNET_PRIVATE_ID2 \
  --tags "Key=Name,Value=$SUBNET_PRIVATE_NAME2" \
  --region $AWS_REGION
echo "  Subnet ID '$SUBNET_PRIVATE_ID2' NAMED as '$SUBNET_PRIVATE_NAME2'."


echo "Creating third Private Subnet..."
echo "Enter Subnet private CIDR3"
read SUBNET_PRIVATE_CIDR3
echo "Enter Subnet private availibility Zone3"
read SUBNET_PRIVATE_AZ3
echo "Enter private subnet 3 name"
read SUBNET_PRIVATE_NAME3


SUBNET_PRIVATE_ID3=$(aws ec2 create-subnet \
  --vpc-id $VPC_ID \
  --cidr-block $SUBNET_PRIVATE_CIDR3 \
  --availability-zone $SUBNET_PRIVATE_AZ3 \
  --query 'Subnet.{SubnetId:SubnetId}' \
  --output text \
  --region $AWS_REGION)
echo "  Subnet ID '$SUBNET_PRIVATE_ID3' CREATED in '$SUBNET_PRIVATE_AZ3'" \
  "Availability Zone."

 Add Name tag to Private Subnet
aws ec2 create-tags \
  --resources $SUBNET_PRIVATE_ID3 \
  --tags "Key=Name,Value=$SUBNET_PRIVATE_NAME3" \
  --region $AWS_REGION
echo "  Subnet ID '$SUBNET_PRIVATE_ID3' NAMED as '$SUBNET_PRIVATE_NAME3'."

# Create Internet gateway
echo "Creating Internet Gateway..."
IGW_ID=$(aws ec2 create-internet-gateway \
  --query 'InternetGateway.{InternetGatewayId:InternetGatewayId}' \
  --output text \
  --region $AWS_REGION)
echo "  Internet Gateway ID '$IGW_ID' CREATED."

# Attach Internet gateway to your VPC
aws ec2 attach-internet-gateway \
  --vpc-id $VPC_ID \
  --internet-gateway-id $IGW_ID \
  --region $AWS_REGION
echo "  Internet Gateway ID '$IGW_ID' ATTACHED to VPC ID '$VPC_ID'."

#######################################################################

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
RESULT1=$(aws ec2 associate-route-table  \
  --subnet-id $SUBNET_PUBLIC_ID1 \
  --route-table-id $ROUTE_TABLE_ID \
  --region $AWS_REGION)
echo "  Public Subnet ID '$SUBNET_PUBLIC_ID1' ASSOCIATED with Route Table ID" \
  "'$ROUTE_TABLE_ID'."

RESULT2=$(aws ec2 associate-route-table  \
  --subnet-id $SUBNET_PUBLIC_ID2 \
  --route-table-id $ROUTE_TABLE_ID \
  --region $AWS_REGION)
echo "  Public Subnet ID '$SUBNET_PUBLIC_ID2' ASSOCIATED with Route Table ID" \
  "'$ROUTE_TABLE_ID'."

RESULT3=$(aws ec2 associate-route-table  \
  --subnet-id $SUBNET_PUBLIC_ID3 \
  --route-table-id $ROUTE_TABLE_ID \
  --region $AWS_REGION)
echo "  Public Subnet ID '$SUBNET_PUBLIC_ID3' ASSOCIATED with Route Table ID" \
  "'$ROUTE_TABLE_ID'."


aws ec2 describe-subnets --filters "Name=vpc-id,Values=$VPC_ID" --query 'Subnets[*].{ID:SubnetId,CIDR:CidrBlock}'

