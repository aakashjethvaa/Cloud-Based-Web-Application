#!/bin/bash
#
#VARIABLES- AWS_REGION, VPC_CIDR, VPC_NAME
#SUBNET_PUBLIC_CIDR1, SUBNET_PUBLIC_AZ1, SUBNET_PUBLIC_NAME1(SAME FOR 2 AND 3)
#
#
#
# Create VPC
echo "------------------------------Creating VPC---------------------------"
echo "Provide region"
read AWS_REGION
echo "Provide VPC CIDR Block"
read VPC_CIDR
echo "Provide VPC Name"
read VPC_NAME


VPC_ID=$(aws ec2 create-vpc \
  --cidr-block $VPC_CIDR \
  --query 'Vpc.{VpcId:VpcId}' \
  --output text \
  --region $AWS_REGION)



# Add Name tag to VPC
aws ec2 create-tags \
  --resources $VPC_ID \
  --tags "Key=Name,Value=$VPC_NAME" \
  --region $AWS_REGION
echo "Successfully created VPC ID '$VPC_ID' NAMED as '$VPC_NAME' in '$AWS_REGION'."

echo "----------------------------------------------------------------------"

# Create Public Subnet

echo "----------------------------Creating Public Subnet #1---------------------------"
echo "Provide Subnet public CIDR"
read SUBNET_PUBLIC_CIDR1
echo "Provide Subnet public availibility Zone"
read SUBNET_PUBLIC_AZ1
echo "Provide Public Subnet Name"
read SUBNET_PUBLIC_NAME1

SUBNET_PUBLIC_ID1=$(aws ec2 create-subnet \
  --vpc-id $VPC_ID \
  --cidr-block $SUBNET_PUBLIC_CIDR1 \
  --availability-zone $SUBNET_PUBLIC_AZ1 \
  --query 'Subnet.{SubnetId:SubnetId}' \
  --output text \
  --region $AWS_REGION)


# Add Name tag to Public Subnet
aws ec2 create-tags \
  --resources $SUBNET_PUBLIC_ID1 \
  --tags "Key=Name,Value=$SUBNET_PUBLIC_NAME1" \
  --region $AWS_REGION
echo "Successfully created  Subnet ID '$SUBNET_PUBLIC_ID1' NAMED as '$SUBNET_PUBLIC_NAME1' in '$SUBNET_PUBLIC_AZ1'."


echo "----------------------------------------------------------------------"

echo "----------------------------Creating Public Subnet #2---------------------------"
echo "Provide Subnet public CIDR"
read SUBNET_PUBLIC_CIDR2
echo "Provide Subnet public availibility Zone"
read SUBNET_PUBLIC_AZ2
echo "Provide Public Subnet Name"
read SUBNET_PUBLIC_NAME2

SUBNET_PUBLIC_ID2=$(aws ec2 create-subnet \
  --vpc-id $VPC_ID \
  --cidr-block $SUBNET_PUBLIC_CIDR2 \
  --availability-zone $SUBNET_PUBLIC_AZ2 \
  --query 'Subnet.{SubnetId:SubnetId}' \
  --output text \
  --region $AWS_REGION)

# Add Name tag to Public Subnet
aws ec2 create-tags \
  --resources $SUBNET_PUBLIC_ID2 \
  --tags "Key=Name,Value=$SUBNET_PUBLIC_NAME2" \
  --region $AWS_REGION
echo "Successfully created  Subnet ID '$SUBNET_PUBLIC_ID2' NAMED as '$SUBNET_PUBLIC_NAME2' in '$SUBNET_PUBLIC_AZ2'."


echo "----------------------------------------------------------------------"
echo "----------------------------Creating Public Subnet #3---------------------------"

echo "Provide Subnet public CIDR"
read SUBNET_PUBLIC_CIDR3
echo "Provide Subnet public availibility Zone"
read SUBNET_PUBLIC_AZ3
echo "Provide Public Subnet Name"
read SUBNET_PUBLIC_NAME3

SUBNET_PUBLIC_ID3=$(aws ec2 create-subnet \
  --vpc-id $VPC_ID \
  --cidr-block $SUBNET_PUBLIC_CIDR3 \
  --availability-zone $SUBNET_PUBLIC_AZ3 \
  --query 'Subnet.{SubnetId:SubnetId}' \
  --output text \
  --region $AWS_REGION)

# Add Name tag to Public Subnet
aws ec2 create-tags \
  --resources $SUBNET_PUBLIC_ID3 \
  --tags "Key=Name,Value=$SUBNET_PUBLIC_NAME3" \
  --region $AWS_REGION

echo "Successfully created  Subnet ID '$SUBNET_PUBLIC_ID3' NAMED as" \
  "'$SUBNET_PUBLIC_NAME3' in '$SUBNET_PUBLIC_AZ3'."


echo "----------------------------------------------------------------------"

####################################################################
# Create Private Subnet


echo "----------------------------Creating Private Subnet #1---------------------------"

echo "Creating first Private Subnet..."
echo "Provide CIDR"
read SUBNET_PRIVATE_CIDR1
echo "Provide availibility Zone"
read SUBNET_PRIVATE_AZ1
echo "Provide Name"
read SUBNET_PRIVATE_NAME1

SUBNET_PRIVATE_ID1=$(aws ec2 create-subnet \
  --vpc-id $VPC_ID \
  --cidr-block $SUBNET_PRIVATE_CIDR1 \
  --availability-zone $SUBNET_PRIVATE_AZ1 \
  --query 'Subnet.{SubnetId:SubnetId}' \
  --output text \
  --region $AWS_REGION)

# Add Name tag to Private Subnet
aws ec2 create-tags \
  --resources $SUBNET_PRIVATE_ID1 \
  --tags "Key=Name,Value=$SUBNET_PRIVATE_NAME1" \
  --region $AWS_REGION

echo "Successfully created Subnet ID '$SUBNET_PRIVATE_ID1' NAMED as" \
  "'$SUBNET_PRIVATE_NAME1' in '$SUBNET_PRIVATE_AZ1'."


echo "----------------------------------------------------------------------"
echo "----------------------------Creating Private Subnet #2---------------------------"

echo "Provide CIDR"
read SUBNET_PRIVATE_CIDR2
echo "Provide availibility Zone"
read SUBNET_PRIVATE_AZ2
echo "Provide name"
read SUBNET_PRIVATE_NAME2


SUBNET_PRIVATE_ID2=$(aws ec2 create-subnet \
  --vpc-id $VPC_ID \
  --cidr-block $SUBNET_PRIVATE_CIDR2 \
  --availability-zone $SUBNET_PRIVATE_AZ2 \
  --query 'Subnet.{SubnetId:SubnetId}' \
  --output text \
  --region $AWS_REGION)
echo "creating subnet"

# Add Name tag to Private Subnet
aws ec2 create-tags \
  --resources $SUBNET_PRIVATE_ID2 \
  --tags "Key=Name,Value=$SUBNET_PRIVATE_NAME2" \
  --region $AWS_REGION

echo "Successfully created Subnet ID '$SUBNET_PRIVATE_ID2' NAMED as" \
  "'$SUBNET_PRIVATE_NAME2' in '$SUBNET_PRIVATE_AZ2'."


echo "----------------------------------------------------------------------"
echo "----------------------------Creating Private Subnet #3---------------------------"

echo "Provide CIDR"
read SUBNET_PRIVATE_CIDR3
echo "Provide Availibility Zone"
read SUBNET_PRIVATE_AZ3
echo "Provide Name"
read SUBNET_PRIVATE_NAME3


SUBNET_PRIVATE_ID3=$(aws ec2 create-subnet \
  --vpc-id $VPC_ID \
  --cidr-block $SUBNET_PRIVATE_CIDR3 \
  --availability-zone $SUBNET_PRIVATE_AZ3 \
  --query 'Subnet.{SubnetId:SubnetId}' \
  --output text \
  --region $AWS_REGION)

#Add Name tag to Private Subnet
aws ec2 create-tags \
  --resources $SUBNET_PRIVATE_ID3 \
  --tags "Key=Name,Value=$SUBNET_PRIVATE_NAME3" \
  --region $AWS_REGION

echo "Successfully created Subnet ID '$SUBNET_PRIVATE_ID3' NAMED as" \
  "'$SUBNET_PRIVATE_NAME3' in '$SUBNET_PRIVATE_AZ3'."

echo "----------------------------------------------------------------------"
#################################################################
# Create Internet gateway

echo "----------------------------Create Internet Gateway---------------------------"

IGW_ID=$(aws ec2 create-internet-gateway \
  --query 'InternetGateway.{InternetGatewayId:InternetGatewayId}' \
  --output text \
  --region $AWS_REGION)
echo "Successfully created Internet Gateway ID '$IGW_ID'"

############################################################
# Attach Internet gateway to your VPC
aws ec2 attach-internet-gateway \
  --vpc-id $VPC_ID \
  --internet-gateway-id $IGW_ID \
  --region $AWS_REGION
echo "Successfully attached Internet Gateway ID '$IGW_ID' to VPC NAME '$VPC_NAME'."

echo "----------------------------------------------------------------------"
#######################################################################

# Create Route Table

echo "----------------------------Create Route Table---------------------------"

ROUTE_TABLE_ID=$(aws ec2 create-route-table \
  --vpc-id $VPC_ID \
  --query 'RouteTable.{RouteTableId:RouteTableId}' \
  --output text \
  --region $AWS_REGION)

echo "Successfully created Route Table ID '$ROUTE_TABLE_ID'."

# Create route to Internet Gateway
RESULT=$(aws ec2 create-route \
  --route-table-id $ROUTE_TABLE_ID \
  --destination-cidr-block 0.0.0.0/0 \
  --gateway-id $IGW_ID \
  --region $AWS_REGION)

echo "Successfully added Route to '0.0.0.0/0' via Internet Gateway ID '$IGW_ID' to" \
  "Route Table ID '$ROUTE_TABLE_ID'."
# Associate Public Subnet with Route Table

RESULT1=$(aws ec2 associate-route-table  \
  --subnet-id $SUBNET_PUBLIC_ID1 \
  --route-table-id $ROUTE_TABLE_ID \
  --region $AWS_REGION)
echo "Successfully associated Public Subnet ID '$SUBNET_PUBLIC_ID1' with Route Table ID" \
  "'$ROUTE_TABLE_ID'."

RESULT2=$(aws ec2 associate-route-table  \
  --subnet-id $SUBNET_PUBLIC_ID2 \
  --route-table-id $ROUTE_TABLE_ID \
  --region $AWS_REGION)
echo "Successfully associated Public Subnet ID '$SUBNET_PUBLIC_ID2' with Route Table ID" \
  "'$ROUTE_TABLE_ID'."

RESULT3=$(aws ec2 associate-route-table  \
  --subnet-id $SUBNET_PUBLIC_ID3 \
  --route-table-id $ROUTE_TABLE_ID \
  --region $AWS_REGION)
echo "Successfully associated Public Subnet ID '$SUBNET_PUBLIC_ID3' with Route Table ID" \
  "'$ROUTE_TABLE_ID'."


aws ec2 describe-subnets --filters "Name=vpc-id,Values=$VPC_ID" --query 'Subnets[*].{ID:SubnetId,CIDR:CidrBlock}'

