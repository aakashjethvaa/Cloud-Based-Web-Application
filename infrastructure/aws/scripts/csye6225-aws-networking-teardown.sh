#!/bin/bash

# Script to delete the networking resources

######################################################

echo "----------------------------Removing Networking Resources---------------------------"
echo "Please enter VPC name"
read VPC_NAME

VPC_ID=$(aws ec2 describe-vpcs \
        --filter "Name=tag:Name,Values=$VPC_NAME" \
        --query 'Vpcs[*].{id:VpcId}' \
        --output text)
########################################################

echo "----------------------------------------------------------------------"
echo "Please provide Subnet name to remove"
read SUBNET_NAME1
SUBNET_ID1=$(aws ec2 describe-subnets \
        --filter "Name=tag:Name,Values=$SUBNET_NAME1" \
        --query 'Subnets[*].{id:SubnetId}' \
        --output text)
echo "Found $SUBNET_ID1 for $SUBNET_NAME1"


aws ec2 delete-subnet --subnet-id $SUBNET_ID1
echo "Successfully removed $SUBNET_NAME1"

echo "----------------------------------------------------------------------"
###########SUBNET2################################
echo "Enter Subnet name to remove"
read SUBNET_NAME2
SUBNET_ID2=$(aws ec2 describe-subnets \
        --filter "Name=tag:Name,Values=$SUBNET_NAME2" \
        --query 'Subnets[*].{id:SubnetId}' \
        --output text)
echo "Found $SUBNET_ID2 for $SUBNET_NAME2"

aws ec2 delete-subnet --subnet-id $SUBNET_ID2
echo "Successfully removed $SUBNET_NAME2 "
##############SUBNET3################################

echo "Enter Subnet name to remove"
read SUBNET_NAME3
SUBNET_ID3=$(aws ec2 describe-subnets \
        --filter "Name=tag:Name,Values=$SUBNET_NAME3" \
        --query 'Subnets[*].{id:SubnetId}' \
        --output text)
echo "Found $SUBNET_ID3 for $SUBNET_NAME3"

aws ec2 delete-subnet --subnet-id $SUBNET_ID3
echo "Successfully removed $SUBNET_NAME3"


echo "----------------------------------------------------------------------"
#######################################################
echo "Enter Subnet name to remove"
read SUBNET_NAME4
SUBNET_ID4=$(aws ec2 describe-subnets \
        --filter "Name=tag:Name,Values=$SUBNET_NAME4" \
        --query 'Subnets[*].{id:SubnetId}' \
        --output text)
echo "Found $SUBNET_ID4 for $SUBNET_NAME4"

echo "Deleting Subnet $SUBNET_NAME4"
aws ec2 delete-subnet --subnet-id $SUBNET_ID4
echo "Successfully removed $SUBNET_NAME4"


echo "----------------------------------------------------------------------"
########################################################
echo "Enter Subnet name to remove"
read SUBNET_NAME5
SUBNET_ID5=$(aws ec2 describe-subnets \
        --filter "Name=tag:Name,Values=$SUBNET_NAME5" \
        --query 'Subnets[*].{id:SubnetId}' \
        --output text)
echo "Found $SUBNET_ID5 for $SUBNET_NAME5"

echo "Deleting Subnet $SUBNET_NAME5"
aws ec2 delete-subnet --subnet-id $SUBNET_ID5
echo "Successfully removed $SUBNET_NAME5"
#########################################################

echo "----------------------------------------------------------------------"
echo "Enter Subnet name to remove"
read SUBNET_NAME6
SUBNET_ID6=$(aws ec2 describe-subnets \
        --filter "Name=tag:Name,Values=$SUBNET_NAME6" \
        --query 'Subnets[*].{id:SubnetId}' \
        --output text)
echo "Found $SUBNET_ID6 for $SUBNET_NAME6"

echo "Deleting Subnet $SUBNET_NAME6"
aws ec2 delete-subnet --subnet-id $SUBNET_ID6
echo "Successfully removed $SUBNET_NAME6 "


################################################################
#ROUTE_TABLE_ID=$(aws ec2 describe-route-tables --filters "Name=tag:Name,Values=$VPC_NAME" \
#		--query 'RouteTables[*].{id:RouteTableId}' \
#	       --output text)

#ROUTE_TABLE_ID=(aws ec2 describe-route-tables 
#	--filters 'Name=route,Values=$VPC_ID' \
#		--query 'RouteTables[*].{id:RouteTableId}')

echo "----------------------------------------------------------------------"
echo "---------------------Removing Route Table-----------------------------"
aws ec2 describe-route-tables
echo "Enter RouteTable Id"

read ROUTE_TABLE_ID

aws ec2 delete-route-table --route-table-id $ROUTE_TABLE_ID
echo "Route Table removed"

echo "----------------------------------------------------------------------"
#################################################################
echo "--------------------Detach your Internet Gateway from VPC------------------"
read IGW_ID
#IGW_ID=$(aws ec2 describe-internet-gateways \
 #              --query 'InternetGateways[*].{id:InternetGatewayId}' \
  #            --output text)

aws ec2 detach-internet-gateway --internet-gateway-id $IGW_ID --vpc-id $VPC_ID
################################################################

aws ec2 delete-internet-gateway --internet-gateway-id $IGW_ID


echo "----------------------------------------------------------------------"
########################################################################
echo "Do you want to delete $VPC_NAME ?(yes/no)"
read ans

if [ $ans == yes ]
then
aws ec2 delete-vpc --vpc-id $VPC_ID
echo "VPC deleted!"
else
echo "Thank you!"
fi

