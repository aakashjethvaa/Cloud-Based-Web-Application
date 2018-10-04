echo "Enter Stack Name:"
read STACK_NAME

aws cloudformation delete-stack --stack-name $STACK_NAME

