How can you make sure that a certain script running   everyday x and y timestamp. 


CRON JOB

Using Cronjob we can execute this script every day at given point of time.


Create a file with the name of "aws_resource_usage.sh"

--> vim aws_resource_usage.sh

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


Save above file --> Press ESC Key then :wq

Note: Before execute the script give the permission and make it executable using chmod command

Now make the aws_resource_usage.sh executable
--> chmod +x aws_resource_usage.sh

Hit the below cmd to generate the output 
--> ./aws_resource_usage.sh

Setting Up Crontab:

	1. Make the Script Executable:
        chmod +x aws_resource_usage.sh

	2. Edit Crontab:
	crontab -e
	
	3. Add the Crontab Entry:
	0 20 * * * /home/ubuntu/aws_resource_usage.sh
	
	4. Verify Crontab Entry:
	Crontab -l
	
	

Breakdown of the Crontab Entry:
	• 0 20 * * * --> This is the scheduling part of the cron job.
		a. 0 --> The minute field. The script will run at the 0th minute of the hour.
		b. 20 --> The hour field. The script will run at the 20th hour (8 PM) of the day.
		c. * --> The day of the month field. The script will run every day of the month.
		d. * --> The month field. The script will run every month.
		e. * --> The day of the week field. The script will run every day of the week.

What this means:
	• The script will run every day.
	• It will run at 8:00 PM (20:00) server time.


How Crontab Works:
	• Crontab is a Unix utility that allows tasks to be automatically run in the background at specified times and intervals.
	• Each line in a crontab file represents a job, and consists of time and date fields, and the command to be executed.


Note: Before executing script you should have these prerequisite. 
	1. INSTALLED AWS CLI
	2. AWS CONIFGURE 
![Uploading image.png…]()
