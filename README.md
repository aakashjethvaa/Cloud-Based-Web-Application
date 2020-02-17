
# Csye6225-fall2018-repo-template
WebDev Applicationn and Tools : Sts eclipse, IntelliJ, Postman, Sql Workbench.

Designed and Build Fault tolerant web application which was hosted on AWS with attachments
added and uploaded to S3 bucket, stored metadata in AWS RDS(MySQL) using entity framework
• Automated creation of every AWS resource via bash scripts and AWS Cloudformation
• Implemented CI/CD pipeline using Git forking workflow, Travis CI and AWS CodeDeploy
• Leveraged Autoscaling groups to manage EC2 instances based on CloudWatch Alarms
• Designed security groups to control flow of traffic between ELB, EC2 and RDS instances
• Restricted access to AWS resources such AWS S3 buckets using IAM Roles and Policies
• Enabled automatic capturing of application server logs using AWS CloudWatch
• Designed routing policies to map HTTPS traffic on Elastic Load Balancer to HTTP on EC2
• Issued a DNS name from Namecheap and mapped it on AWS Route53
• Engineered a “password reset functionality” using AWS SNS, SES, Lambda and Dynamo DB

AWS Cloud Formation:

Run the csye6225-aws-cf-create-stack.sh bash script
This will create cloud formation stack on aws

To delete the stack: 
Run the csye6225-aws-cf-terminate-stack.sh bash script
This will delete the cloud formation stack on aws

--------------------------------------------------------------

Cloud formation 
-S3 Bucket generation
-RDS instance creation
-DynamoDB
-Subnet Groups

Web Applicationn 

-Returning Successful API calls
-Storing image on the local disk and application S3 bucket
-Update the application.json
-Handling all the API Validations
-Adding the AWS configuration to the Web application
