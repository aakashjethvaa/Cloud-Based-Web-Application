#!/bin/bash

echo "Enter Stack Name"
read stack_name
echo "Enter VPC Name"
read vpc_name
echo "Enter CIDR Block"
read cidr_block
echo "Enter Public Subnet 1 name"
read public_subnet_1
echo "Enter Public Subnet 1 CIDR block"
read public_cidr_1
echo "Enter Public Subnet 2 name"
read public_subnet_2
echo "Enter Public Subnet 2 CIDR block"
read public_cidr_2
echo "Enter Public Subnet 3 name"
read public_subnet_3
echo "Enter Public Subnet 3 CIDR block"
read public_cidr_3
echo "Enter Private Subnet 1 name"
read private_subnet_1
echo "Enter Private Subnet 1 CIDR block"
read private_cidr_1
echo "Enter Private Subnet 2 name"
read private_subnet_2
echo "Enter Private Subnet 2 CIDR block"
read private_cidr_2
echo "Enter Private Subnet 3 name"
read private_subnet_3
echo "Enter Private Subnet 3 CIDR block"
read private_cidr_3
echo "Enter Availability Zone 1"
read az_1
echo "Enter Availability Zone 2"
read az_2
echo "Enter Availability Zone 3"
read az_3

InternetGateway=$stack_name"InternetGateway"
RouteTable=$stack_name"PublicRouteTable"


echo "Creating CloudFormation Stack"

aws cloudformation create-stack --stack-name $stack_name --template-body file://csye6225-cf-networking.json --parameters ParameterKey=VpcName,ParameterValue=$vpc_name ParameterKey=CidrBlock,ParameterValue=$cidr_block ParameterKey=publicSubnet1,ParameterValue=$public_subnet_1 ParameterKey=PublicCidrBlock1,ParameterValue=$public_cidr_1 ParameterKey=publicSubnet2,ParameterValue=$public_subnet_2 ParameterKey=PublicCidrBlock2,ParameterValue=$public_cidr_2 ParameterKey=publicSubnet3,ParameterValue=$public_subnet_3 ParameterKey=PublicCidrBlock3,ParameterValue=$public_cidr_3 ParameterKey=privateSubnet1,ParameterValue=$private_subnet_1 ParameterKey=PrivateCidrBlock1,ParameterValue=$private_cidr_1 ParameterKey=privateSubnet2,ParameterValue=$private_subnet_2 ParameterKey=PrivateCidrBlock2,ParameterValue=$private_cidr_2 ParameterKey=privateSubnet3,ParameterValue=$private_subnet_3 ParameterKey=PrivateCidrBlock3,ParameterValue=$private_cidr_3 ParameterKey=AvailabilityZone1,ParameterValue=$az_1 ParameterKey=AvailabilityZone2,ParameterValue=$az_2 ParameterKey=AvailabilityZone3,ParameterValue=$az_3 ParameterKey=InternetGatewayName,ParameterValue=$InternetGateway ParameterKey=RouteTableName,ParameterValue=$RouteTable

echo "Completed Creation of Cloud Formation"





