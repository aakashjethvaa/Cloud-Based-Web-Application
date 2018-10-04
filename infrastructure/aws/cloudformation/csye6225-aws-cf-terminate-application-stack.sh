echo "Please enter the Stack Name"
read stack_name
echo "Starting deletion of Cloudformation Stack"
aws cloudformation delete-stack --stack-name $stack_name
echo $?
echo "Stack deleted successfully"

