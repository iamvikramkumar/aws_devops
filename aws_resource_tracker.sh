#!/bin/bash
########
# Author: Vikram
# Date: 14-07-24
#
# Version: v1
#
# This script will report the aws resource usage
########


set -x

#AWS S3
#AWS EC2
#AWS Lambda
#AWS IAM User

#List S3 Buckets
echo "Print list of S3 buckets"
aws s3 ls > resourceTracker

#List EC2 instances
echo "Print list of EC2 buckets"
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'

#List Lambda
echo "Print list of lambda"
aws lambda list-functions >> resourceTracker:q!

#List IAM Users
echo "Print list of IAM Users"
aws iam list-users


