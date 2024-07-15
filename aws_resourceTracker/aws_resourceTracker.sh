#!/bin/bash
########
# Author: Vikram
# Date: 15-07-24
#
# Version: v1
#
# This script will report the AWS resource usage
########

set -x

# Define the output file
output_file="/home/ubuntu/resourceTracker.log"

# Add a header to the output file
echo "AWS Resource Usage Report - $(date)" > $output_file
echo "-----------------------------------" >> $output_file

# List S3 Buckets
echo -e "\nPrint list of S3 buckets:\n" | tee -a $output_file
aws s3 ls --query 'Buckets[*].Name' | tee -a $output_file

# Add space between sections
echo -e "\n-----------------------------------\n" | tee -a $output_file

# List EC2 instances
echo -e "Print list of EC2 instances:\n" | tee -a $output_file
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,InstanceType,State.Name,PublicIpAddress]' | tee -a $output_file

# Add space between sections
echo -e "\n-----------------------------------\n" | tee -a $output_file

# List Lambda functions
echo -e "Print list of Lambda functions:\n" | tee -a $output_file
aws lambda list-functions --query 'Functions[*].[FunctionName,Runtime,LastModified]' | tee -a $output_file

# Add space between sections
echo -e "\n-----------------------------------\n" | tee -a $output_file

# List IAM Users
echo -e "Print list of IAM Users with specific attributes:\n" | tee -a $output_file
aws iam list-users --query 'Users[*].[UserName,UserId,CreateDate,PasswordLastUsed]' | tee -a $output_file

# Add a footer
echo -e "\n-----------------------------------\n" | tee -a $output_file
echo "End of report" | tee -a $output_file






# ===========================================


#!/bin/bash
########
# Author: Vikram
# Date: 14-07-24
#
# Version: v1
#
# This script will report the aws resource usage
########


# set -x

# #AWS S3
# #AWS EC2
# #AWS Lambda
# #AWS IAM User

# #List S3 Buckets
# echo "Print list of S3 buckets"
# aws s3 ls > resourceTracker

# #List EC2 instances
# echo "Print list of EC2 buckets"
# aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'

# #List Lambda
# echo "Print list of lambda"
# aws lambda list-functions >> resourceTracker:q!

# #List IAM Users
# echo "Print list of IAM Users"
# aws iam list-users


# =========================================