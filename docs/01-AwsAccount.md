[Back to Top](../README.md)

# Set yourself up in AWS
If you are already logged into AWS, and have **Administrator Access**, go to "Pick a Region" below.

If you don't have an account yet, [sign up for free](https://aws.amazon.com/free).

Create an [IAM User](http://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started_create-admin-group.html) so that
you are not doing this work as the account root user. If you are creating this user for the purpose of running this project
as a test, give yourself **Administrator Access**. Configuring more granular permissions is outside the scope of this project documentation.

[Sign in](http://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started_how-users-sign-in.html) as your new user.

---
## Pick a region
You will use this region every time you do anything in AWS with respect to the project. 

Only the following regions are supported by this project's CloudFormation templates:

| Region | Region Name |
| ------ | ----------- |
| us-east-1 | US East (N. Virginia) |
| us-west-2 | US West (Oregon) |
| us-west-1 | US West (N. California) |
| eu-west-1 | EU (Ireland) |
| eu-central-1 | EU (Frankfurt) |
| ap-northeast-1 | Asia Pacific (Tokyo) |
| ap-southeast-1 | Asia Pacific (Singapore) |
| ap-southeast-2 | Asia Pacific (Syndey) |

1. Log into AWS if you haven't already, click on the **Services** drop down in the menu, and go to **EC2**.
1. Pick your region using the drop down in the top nav bar.
This sets your region so that as you navigate around, you do not have to keep selecting the region. 

---
## Paste your Public Key to an AWS Key Pair for your selected region

1. In the **EC2 Dashboard** and click on **Key Pairs** in the left pane
1. Click **Import Key Pair**
  * **Key pair name:** "`hello-world-ecs`" (if you call it something else, use that name instead)
  * **Public key contents:** (paste your public key [that you created](./00-SSHKey.md))
1. Click **Import**
    
From now on, if you create an EC2 instance that you will need to SSH into, you can use this "existing key pair" and that
will allow you to connect without any fuss (e.g., `ssh ec2-user@<instance_ip>`).

-- 
## Resources
 * [Creating Your First IAM Admin User and Group](http://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started_create-admin-group.html)
 * [Amazon EC2 Key Pairs](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)

**Next:** [Set yourself up in DockerHub](./02-DockerHub.md)