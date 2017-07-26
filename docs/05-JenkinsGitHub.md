[Back to Top](../README.md)

# Give Jenkins Access to GitHub

1. If you are not there already, go to the **EC2** Dashboard and find the Jenkins server (make sure it is fully initialized)
1. Get its **Public IP** 
1. Open a bash or **Git Bash** window:

```shell
# SSH to jenkins server
ssh ec2-user@<public_ip>

# generate SSH key for jenkins user
# log in as the jenkins user
sudo su -s /bin/bash jenkins

# verify you are logged in as "jenkins"
whoami

# generate the key (accept all defaults)
ssh-keygen

# get the generated public key and copy contents
vim ~/.ssh/id_rsa.pub

# copy everything starting from "ssh-rsa" to the end of the line that has something like "jenkins@ip-10-0-1-131"

# exit vim with :q
```
Keep this window open.

## Add SSH public key to GitHub
This is to permit Jenkins to clone the repository. If you are using a different Git Repository, the process is very similar,
but might be accessed slightly differently.

1. Navigate to the Project, and select **Settings** | **Deploy Keys** | **Add Deploy Key**
1. Name it **Jenkins hello-world**, and paste the key into the **Key** field
1. Click **Add Key** and type your password to save the Deploy Key

## Test your connection to GitHub
**DO NOT SKIP THIS STEP**

1. Go back to the open SSH connection and try `ssh git@github.com`
    - it should say "Hi `<username>/hello-world-docker-aws`! You've successfully authenticated, but GitHub does not provide shell access"

---
## Initialize Jenkins
1. Paste the IP address for jenkins into a browser.

1. Go back to the open shell logged in as jenkins...

    ```shell
    # get the generated public key (needed for the next several steps)
    cat /var/lib/jenkins/secrets/initialAdminPassword
    ```
1. Paste the initial admin password into the prompt.
1. **Select plugins to install** (Selecting plugins is more stable than installing recommended plugins)
  1. _Search for_ and **disable** the following
      * **Ant Plugin**
      * **Gradle Plugin**
      * **Subversion Plugin**
  1. Click **Install**
1. Create your first admin user then **Save and Finish** | **Start Using Jenkins**

---
## Close your SSH connection
You can now go back to your open terminal window to close your connection:

1. `exit` to log out of the `jenkins` user
1. `exit` to close the connection to the EC2 instance

___
## Resources
 * [Troubleshoot problems connecting to EC2 instances using SSH](https://aws.amazon.com/premiumsupport/knowledge-center/ec2-linux-ssh-troubleshooting/)


**Next:** [Configure Jenkins to do Maven Builds](./06-ConfigureMavenTool.md)