<<<<<<< HEAD

STACK_NAME=$1

CODEDEPLOYEC2S3POLICYNAME="CodeDeploy-EC2-S3"
CODEDEPLOYSERVICEROLENAME="CodeDeploySerivceRole"

echo "Enter S3 Bucket name"
read name
CODEDEPLOYS3BUCKETNAME=$name

TRAVISUSER="travis"
CODEDEPLOYAPPNAME="CodeDeployApplication"
TRAVISUPLOADTOS3POLICYNAME="Travis-Upload-To-S3"
TRAVISCODEDEPLOYPOLICYNAME="Travis-Code-Deploy"
CODEDEPLOYEC2SERVICEROLENAME="CodeDeployEC2ServiceRole"
AWSREGION="us-east-1"
AWSACCOUNTID=""


aws cloudformation create-stack --stack-name $STACK_NAME --capabilities "CAPABILITY_NAMED_IAM" --template-body file://csye6225-cf-cicd.json --parameters ParameterKey=CodeDeployEC2ServiceRoleName,ParameterValue=$CODEDEPLOYEC2SERVICEROLENAME ParameterKey=TravisUploadtoS3PolicyName,ParameterValue=$TRAVISUPLOADTOS3POLICYNAME ParameterKey=TravisUser,ParameterValue=$TRAVISUSER ParameterKey=CodeDeployS3BucketName,ParameterValue=$CODEDEPLOYS3BUCKETNAME ParameterKey=CodeDeployApplicationName,ParameterValue=$CODEDEPLOYAPPNAME ParameterKey=AWSRegion,ParameterValue=$AWSREGION ParameterKey=AWSAccountID,ParameterValue=$AWSACCOUNTID ParameterKey=CodeDeployServiceRoleName,ParameterValue=$CODEDEPLOYSERVICEROLENAME ParameterKey=CodeDeployEC2S3PolicyName,ParameterValue=$CODEDEPLOYEC2S3POLICYNAME ParameterKey=TravisCodeDeployPolicyName,ParameterValue=$TRAVISCODEDEPLOYPOLICYNAME 


export STACK_STATUS=$(aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[][ [StackStatus ] ][]" --output text)

while [ $STACK_STATUS != "CREATE_COMPLETE" ]
do
  STACK_STATUS=`aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[][ [StackStatus ] ][]" --output text`
done
echo "Created Stack ${STACK_NAME} successfully!"
=======
#!/bin/bash
#Variables

stackname=$1


read -p "Enter your s3 upload artifact bucket name: " s3domainName
s3domain="code-deploy.csye6225-fall2018-$s3domainName.me.csye6225.com"
echo "S3 Bucket: $s3domain"

appname="csye6225CodeDeployApplication"
echo $appname
depname="csye6225CodeDeployApplication-depgroup"
echo $depname
accid=$(aws sts get-caller-identity --output text --query 'Account')
echo "AccountId: $accid"


createOutput=$(aws cloudformation create-stack --stack-name $stackname --capabilities CAPABILITY_NAMED_IAM --template-body file://csye6225-cf-ci-cd.json --parameters ParameterKey=s3domain,ParameterValue=$s3domain  ParameterKey=appname,ParameterValue=$appname ParameterKey=depname,ParameterValue=$depname ParameterKey=accid,ParameterValue=$accid)


if [ $? -eq 0 ]; then
	echo "Creating stack..."
	aws cloudformation wait stack-create-complete --stack-name $stackname
	echo "Stack created successfully. Stack Id below: "

	echo $createOutput

else
	echo "Error in creation of stack"
	echo $createOutput
fi;
>>>>>>> 17ab7d6fff12270986c87bec7d4d4eaca191b16e
