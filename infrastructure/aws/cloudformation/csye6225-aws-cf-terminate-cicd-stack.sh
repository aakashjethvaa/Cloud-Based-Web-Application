STACK_NAME=$1
echo Enter S3 bucket name
read bucket_name
aws s3 rb s3://$bucket_name --force

aws cloudformation delete-stack --stack-name $STACK_NAME

aws cloudformation wait stack-delete-complete --stack-name $STACK_NAME

if [ $? -ne "0" ]
then 
	echo "Deletion of Stack failed"
else
	echo "Deletion of Stack Success"
fi
