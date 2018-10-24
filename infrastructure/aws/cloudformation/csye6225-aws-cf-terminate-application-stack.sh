echo "Please enter the Stack Name"
read stack_name
echo "Enter S3 bucket name to delete"
read bucket_name
echo "Starting deletion of Cloudformation Stack"
aws s3 rb s3://$bucket_name --force   
echo "removing everything from the bucket"
aws cloudformation delete-stack --stack-name $stack_name
echo $?
echo "Stack deleted successfully"

