#!/bin/bash

# Script to delete the networking resources

######################################################

echo "Enter VPC name to delete networking resources"
read VPC_NAME

VPC_ID=$(aws ec2 describe-vpcs \
        --filter "Name=tag:Name,Values=$VPC_NAME" \
        --query 'Vpcs[*].{id:VpcId}' \
        --output text)
########################################################

echo "Enter Subnet name to delete"
read SUBNET_NAME1
SUBNET_ID1=$(aws ec2 describe-subnets \
        --filter "Name=tag:Name,Values=$SUBNET_NAME1" \
        --query 'Subnets[*].{id:SubnetId}' \
        --output text)
echo "$SUBNET_ID1 HERE IT IS $SUBNET_NAME1"

echo "Deleting Subnet $SUBNET_NAME1"
aws ec2 delete-subnet --subnet-id $SUBNET_ID1
echo "$SUBNET_NAME1 deleted!"

###########SUBNET2################################
echo "Enter Subnet name to delete"
read SUBNET_NAME2
SUBNET_ID2=$(aws ec2 describe-subnets \
        --filter "Name=tag:Name,Values=$SUBNET_NAME2" \
        --query 'Subnets[*].{id:SubnetId}' \
        --output text)
echo "$SUBNET_ID2 HERE IT IS $SUBNET_NAME2"

echo "Deleting Subnet $SUBNET_NAME2"
aws ec2 delete-subnet --subnet-id $SUBNET_ID2
echo "$SUBNET_NAME2 deleted!"
##############SUBNET3################################

echo "Enter Subnet name to delete"
read SUBNET_NAME3
SUBNET_ID3=$(aws ec2 describe-subnets \
        --filter "Name=tag:Name,Values=$SUBNET_NAME3" \
        --query 'Subnets[*].{id:SubnetId}' \
        --output text)
echo "$SUBNET_ID3 HERE IT IS $SUBNET_NAME3"

echo "Deleting Subnet $SUBNET_NAME3"
aws ec2 delete-subnet --subnet-id $SUBNET_ID3
echo "$SUBNET_NAME3 deleted!"
#######################################################
echo "Enter Subnet name to delete"
read SUBNET_NAME4
SUBNET_ID4=$(aws ec2 describe-subnets \
        --filter "Name=tag:Name,Values=$SUBNET_NAME4" \
        --query 'Subnets[*].{id:SubnetId}' \
        --output text)
echo "$SUBNET_ID4 HERE IT IS $SUBNET_NAME4"

echo "Deleting Subnet $SUBNET_NAME4"
aws ec2 delete-subnet --subnet-id $SUBNET_ID4
echo "$SUBNET_NAME4 deleted!"

########################################################
echo "Enter Subnet name to delete"
read SUBNET_NAME5
SUBNET_ID5=$(aws ec2 describe-subnets \
        --filter "Name=tag:Name,Values=$SUBNET_NAME5" \
        --query 'Subnets[*].{id:SubnetId}' \
        --output text)
echo "$SUBNET_ID5 HERE IT IS $SUBNET_NAME5"

echo "Deleting Subnet $SUBNET_NAME5"
aws ec2 delete-subnet --subnet-id $SUBNET_ID5
echo "$SUBNET_NAME5 deleted!"
#########################################################

echo "Enter Subnet name to delete"
read SUBNET_NAME6
SUBNET_ID6=$(aws ec2 describe-subnets \
        --filter "Name=tag:Name,Values=$SUBNET_NAME6" \
        --query 'Subnets[*].{id:SubnetId}' \
        --output text)
echo "$SUBNET_ID6 HERE IT IS $SUBNET_NAME6"

echo "Deleting Subnet $SUBNET_NAME6"
aws ec2 delete-subnet --subnet-id $SUBNET_ID6
echo "$SUBNET_NAME6 deleted!"


################################################################
#ROUTE_TABLE_ID=$(aws ec2 describe-route-tables --filters "Name=tag:Name,Values=$VPC_NAME" \
#		--query 'RouteTables[*].{id:RouteTableId}' \
#	       --output text)

echo "Please Enter Route table Id:"
read ROUTE_TABLE_ID

aws ec2 delete-route-table --route-table-id $ROUTE_TABLE_ID
echo "Route Table deleted"

#################################################################
echo "Detach your Internet Gateway from VPC"
#read IGW_ID
IGW_ID=$(aws ec2 describe-internet-gateways \
               --query 'InternetGateways[*].{id:InternetGatewayId}' \
              --output text)
echo "$IGW_ID ...................."

aws ec2 detach-internet-gateway --internet-gateway-id $IGW_ID --vpc-id $VPC_ID
################################################################

echo "Delete Internate gateway"
aws ec2 delete-internet-gateway --internet-gateway-id $IGW_ID


########################################################################
echo "Do you want to delete $VPC_NAME ?(yes/no)"
read ans

if [ $ans == yes ]
then
aws ec2 delete-vpc --vpc-id $VPC_ID
echo "VPC deleted!"
else
echo "Than you!"
fi

