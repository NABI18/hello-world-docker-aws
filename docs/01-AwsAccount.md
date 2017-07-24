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
| sa-east-1 | South America (São Paulo) |

Log into AWS if you haven't already, and pick the region using the drop down in the top nav bar. 
This sets your region so that as you navigate around, you do not have to keep selecting the region. 

---
## Setup a Key Pair for SSH access to EC2 Instances
This project's documentation expects you to connect to the necessary instances using your user's default key (~/.ssh/id_rsa.pub).

Setup an SSH key for your operating system using the instructions on 
[GitHub Help on Generating a new SSH Key](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/).

1. Put Public key into your clipboard:

  * On **Mac**: `pbcopy < ~/.ssh/id_rsa.pub`
  * On **Windows in GitBash**: `clip < ~/.ssh/id_rsa.pub`
  * On **Linux**: 
    ```shell
    # on linux open the key in an editor and copy to clipboard
    # prefer `vim` over `cat` to prevent public key from being displayed in bash history
    vim ~/.ssh/id_rsa.pub
        
    # exit editor using `:q!` (without quotes to prevent saving any accidental edits)
    ```

### Paste your Public Key to an AWS Key Pair for your selected region

1. Go to the **EC2 Dashboard** and click on **Key Pairs** in the left pane
1. Click **Import Key Pair**
  * **Key pair name:** "`hello-world-ecs`" (if you call it something else, use that name instead)
  * **Public key contents:** (paste your public key)
1. Click **Import**
    
From now on, if you create an EC2 instance that you will need to SSH into, you can use this "existing key pair" and that
will allow you to connect without any fuss (e.g., `ssh ec2-user@<instance_ip>`).


**Next:** [Clone Git Repository](02-GitRepository.md)