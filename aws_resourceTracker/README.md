# AWS Resource Usage Script with Cron Job

## How to Ensure a Script Runs Every Day at a Specific Time

You can use a cron job to execute a script every day at a given point in time.

### Step-by-Step Guide

#### 1. Create the Script File

Create a file named `aws_resource_usage.sh`:
```
vim aws_resource_usage.sh
```


```
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

```

Save the file by pressing ESC and then :wq.


#### 2. Make the Script Executable
Before executing the script, make it executable using the chmod command:
```
chmod +x aws_resource_usage.sh
```

#### 3. Run the Script 
To generate the output, run the script:
```
./aws_resource_usage.sh
```

## Setting Up Crontab:
#### 1. Edit Crontab:
```
crontab -e
```	
#### 2. Add the Crontab Entry:
```
0 20 * * * /home/ubuntu/aws_resource_usage.sh
```
#### 3. Verify Crontab Entry:
```
crontab -l
```	
	

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
