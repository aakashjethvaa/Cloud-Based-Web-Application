echo "Please enter the Stack Name"
read stack_name
echo "Deploy bucket name"
read bucket_name
aws s3 rm s3://$bucket_name --recursive

echo "Storage bucket name"
read bucket_name1
aws s3 rm s3://$bucket_name1 --recursive

echo "Deleting Cloudformation Stack $stack_name"
aws cloudformation delete-stack --stack-name $stack_name

echo "Stack deleted successfully"
