# Script to delete the networking resources

echo "Delete Your Security group id"
SG_ID=""
aws ec2 delete-security-group --group-id $SG_ID

echo "Delete your Subnet"
SUBNET_ID=""
aws ec2 delete-subnet --subnet-id $SUBNET_ID

# PLACE A LOOK HERE


echo "Delete a route table"
ROUTE_TABLE_ID=""
aws ec2 delete-route-table --route-table-id $ROUTE_TABLE_ID

echo "Detach your Internet Gateway from VPC"
IG_ID=""
aws ec2 detach-internet-gateway --internet-gateway-id $IG_ID --vpc-id $VPC_ID

echo "Delete Internate gateway"
aws ec2 delete-internet-gateway --internet-gateway-id $IG_ID

echo "Delete VPC"
aws ec2 delete-vpc --vpc-id $VPC_ID
