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
#echo "Enter Private Subnet 1 CIDR block"
#read private_cidr_1
#echo "Enter Private Subnet 2 CIDR block"
#read private_cidr_2
#echo "Enter Private Subnet 3 CIDR block"
#read private_cidr_3
echo "Enter Availability Zone 1"
read az_1
echo "Enter Availability Zone 2"
read az_2
echo "Enter Availability Zone 3"
read az_3

echo "Generating CloudFormation template csye6225-cf-networking.json"


cat > csye6225-cf-networking.json << EOF
{
  "AWSTemplateFormatVersion" : "2010-09-09",
  "Description" : "Cloud Formation Template", 
 
  "Resources" : {
    "VPC" : {
	    "Type" : "AWS::EC2::VPC",
	    "Properties" : {
	        "CidrBlock" : "$cidr_block",
		"EnableDnsSupport" : "true",
 		"EnableDnsHostnames" : "true",
      		"InstanceTenancy" : "default",
		"Tags" : [ {"Key" : "Name", "Value" : "$vpc_name" } ]
		}
            },
    "PublicSubnet1" : {
	    "Type" : "AWS::EC2::Subnet",
	    "Properties" : {
 	        "AvailabilityZone" : "$az_1",
	        "VpcId" : { "Ref" : "VPC" },
	        "CidrBlock" : "$public_cidr_1",
		"MapPublicIpOnLaunch" : true,
	        "Tags" : [ {"Key" : "Name", "Value" : "$public_subnet_1" } ]
	      }
	    },
    "PublicSubnet2" : {
	    "Type" : "AWS::EC2::Subnet",
	    "Properties" : {
		"AvailabilityZone" : "$az_2",
	        "VpcId" : { "Ref" : "VPC" },
	        "CidrBlock" : "$public_cidr_2",
		"MapPublicIpOnLaunch" : true,
	        "Tags" : [ {"Key" : "Name", "Value" : "$public_subnet_2" } ]
	      }
	    },	
		
	"PublicSubnet3" : {
	    "Type" : "AWS::EC2::Subnet",
	    "Properties" : {
		"AvailabilityZone" : "$az_3",
	        "VpcId" : { "Ref" : "VPC" },
	        "CidrBlock" : "$public_cidr_3",
		"MapPublicIpOnLaunch" : true,
	        "Tags" : [ {"Key" : "Name", "Value" : "$public_subnet_3" } ]
	      }
	    }

	}
}
EOF

echo "Creating CloudFormation Stack"
aws cloudformation create-stack --stack-name $stack_name --template-body file://csye6225-cf-networking.json 





