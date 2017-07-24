# Set yourself up in AWs
If you don't have an account yet, [sign up for free](https://aws.amazon.com/free).

Create an [IAM User](http://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started_create-admin-group.html) so that
you are not doing this work as the account root user. If you are creating this user for the purpose of running this project
as a test, give yourself **Administrator Access**. Configuring more granular permissions is outside the scope of this project documentation.

[Sign in](http://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started_how-users-sign-in.html) as your new user.

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

## Setup a Key Pair for SSH access to EC2 Instances
This project's documentation expects you to connect to the necessary instances using your user's default key (~/.ssh/id_rsa.pub).

If you choose to connect using an AWS generated Key Pair, you are expected to know how and when to use the `-i keypairfile.pem` option to do so.

This page on [GitHub Help on Generating a new SSH Key](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/) 
explains and walks through the process for **Mac** | **Windows** | **Linux** (be sure to click the link for your OS).

### Generate an SSH Key on your machine
Assuming you are going to run the test from the computer you are using right now, generate an SSH key:

1. **On Mac and/or Linux** or **GitBash** on Windows:
    ```shell
    # see if a key already exists
    ls ~/.ssh
    
    # if you see `id_rsa.pub` listed, then you already have a key, go to the next step
    
    # generate a key pair, and take all defaults 
    # (if you want to add a passphrase, add your key to the SSH Agent as well--see GitHub article linked above)
    ssh-keygen -t rsa -b 4096 -C "your_email@domain.com"
    ```
    
    >**Note:** The `-C "comment"` mentioned in the GitHub article is optional, and serves to identify your key from amongst a collection of keys.
    It is generally a good idea to specify your email if your key will be one of many keys authorized on a server so that
    an administrator might easily identify which key is your key, particularly if there is a need to remove unauthorized
    users from the authorized_keys file.

1. Put key into your clipboard:

  * On **Mac**: `pbcopy < ~/.ssh/id_rsa.pub`
  * On **Windows in GitBash**: `clip < ~/.ssh/id_rsa.pub`
  * On **Linux**: 
    ```shell
    # on linux open the key in an editor and copy to clipboard
    # prefer `vim` over `cat` to prevent public key from being displayed in bash history
    vim ~/.ssh/id_rsa.pub
        
    # exit editor using `:q!` (without quotes to prevent saving any accidental edits)
    ```

### Add this key pair to your selected region in AWS

1. Log into AWS and go to your region (use the drop down in the header bar)
1. Go to the EC2 Dashboard and click on **Key Pairs** in the left pane
1. Click **Import Key Pair**
    1. Name your key something useful like, your username and your machine name (e.g., `jdoe_Macbook-1`).
    This way, you can add a key pair for your other computer and you won't be too confused (e.g., `jdoe_Windows-1`)
    1. Paste your public key in and click **Import**
    
From now on, if you create an EC2 instance that you will need to SSH into, you can use this "existing key pair" and that
will allow you to connect without any fuss (e.g., `ssh ec2-user@my-new-ec2-instance-public-ip-or-dns`).

**Next:** Setting up a Docker Repository: Either use [GitLab Container Registry](./02-GitLabRegistry.md) or [DockerHub](./02-DockerHub.md).