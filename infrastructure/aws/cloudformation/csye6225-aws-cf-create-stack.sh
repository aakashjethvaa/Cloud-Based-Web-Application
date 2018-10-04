#!/bin/bash

echo "Enter Stack Name"
read stack_name
echo "Enter CIDR Block"
read cidr_block
echo "Enter Public Subnet 1 CIDR block"
read public_cidr_1
echo "Enter Public Subnet 2 CIDR block"
read public_cidr_2
echo "Enter Public Subnet 3 CIDR block"
read private_cidr_3
echo "Enter Private Subnet 1 CIDR block"
read private_cidr_1
echo "Enter Private Subnet 2 CIDR block"
read private_cidr_2
echo "Enter Private Subnet 3 CIDR block"
read private_cidr_3
echo "Enter Availability Zone 1"
read az_1
echo "Enter Availability Zone 2"
read az_2
echo "Enter Availability Zone 3"
read az_3

VPC=$stack_name"VPC"
CidrBlock=$cidr_block
PublicSubnetCIDR1=$public_cidr_1
PublicSubnetCIDR2=$public_cidr_2
PublicSubnetCIDR3=$public_cidr_3
PrivateSubnetCIDR1=$private_cidr_1
PrivateSubnetCIDR2=$private_cidr_2
PrivateSubnetCIDR3=$private_cidr_3
InternetGateway=$stack_name"InternetGateway"
RouteTable=$stack_name"PublicRouteTable"
AvailabilityZone1=$az_1
AvailabilityZone2=$az_2
AvailabilityZone3=$az_3

echo "Creating CloudFormation Stack"
aws cloudformation create-stack --stack-name $name --template-body file://csye6225-cf-networking.json 





