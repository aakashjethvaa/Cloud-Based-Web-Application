# csye6225-fall2018-repo-template
Team Member Details:
1. Kiran Panchal panchal.k@husky.neu.edu
2. Komal Suthar suthar.k@husky.neu.edu
3. Hemant Kamathhh kamath.h@husky.neu.edu
4. Aakash Jethva jethva.a@husky.neu.edu

WebDev Application:
Technologies : Sts eclipse, IntelliJ, Postman, Sql Workbench, Maria DB,DynamoDB

Using JPA annotations first created a User Pojo 
Later Extended JPA Repository to User Repository
Incorporated User Controller and deviced all JPA annotations
Later added the BCryptPasswordEncoderBean used for hashing passwords.
Using @ManyToOne annotation  mapped Transaction pojo to User pojo
Extended JPA Repository to Transaction Repository
Incorporated Transaction Controller and deviced all JPA annotations
Incorporated Authentication and Authorization on Transaction using User Credentials

AWS Cloud Formation:

Run the csye6225-aws-cf-create-stack.sh bash script from the folder csye6225-fall2018/infrastructure/aws/cloudformation
command: ./csye6225-aws-cf-create-stack.sh 

User should enter the stack name
This will create cloud formation stack on aws

To delete the stack: 
Run the csye6225-aws-cf-terminate-stack.sh bash script from the folder csye6225-fall2018/infrastructure/aws/cloudformation
command: ./csye6225-aws-cf-terminate-stack.sh 

user should enter the name of the stack to be deleted
This will delete the cloud formation stack on aws

--------------------------------------------------------------
Cloud formation 
-S3 Bucket generation
-RDS instance creation
-DynamoDB
-Subnet Groups

Web Application 

-Returning Successful API calls
-Storing image on the local disk and application S3 bucket
-Update the application.json
-Handling all the API Validations
-Adding the AWS configuration to the Web application

All Set!
