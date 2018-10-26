STACK_NAME=$1
echo "Enter Bucket Name to delete"
read BUCKET_NAME

aws s3 rb s3://$BUCKET_NAME --force

if [ $? -ne "0" ]
then 
	echo "Deletion of $BUCKET_NAME failed"
else
	echo "Deletion of $BUCKET_NAME Success"
fi
echo "Deleting $STACK_NAME"
  
aws cloudformation delete-stack --stack-name $STACK_NAME

aws cloudformation wait stack-delete-complete --stack-name $STACK_NAME

if [ $? -ne "0" ]
then 
	echo "Deletion of Stack failed"
else
	echo "Deletion of Stack Success"
fi
