[Back to Top](../README.md)

# Give Jenkins Access to GitHub

1. Go to the **EC2** Dashboard and find the Jenkins server (make sure it is fully initialized)
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

# exit vim with :q
```
Keep this window open.

## Add SSH public key to GitHub
This is to permit Jenkins to clone the repository. If you are using a different Git Repository, the process is very similar,
but might be accessed slightly differently.

1. Navigate to the Project, and select **Settings** | **Deploy Keys** | **Add Deploy Key**
1. Paste the key into the **Key** field and name it **Jenkins hello-world**
1. Click **Add Key** and type your password

## Test your connection to GitHub
1. Go back to the open SSH connection and try `ssh git@github.com`
    - it should say "Hi `<username>/hello-world-docker-aws`! You've successfully authenticated, but GitHub does not provide shell access"
    
## Initialize Jenkins
1. Paste the IP address for jenkins into a browser.

1. Go back to the open shell logged in as jenkins...

    ```shell
    # get the generated public key (needed for the next several steps)
    cat /var/lib/jenkins/secrets/initialAdminPassword
    ```
1. Paste the initial admin password into the prompt.
1. **Select plugins to install**
  1. Disable the following
      * **Ant Plugin**
      * **Gradle Plugin**
      * **Subversion Plugin**
  1. Click **Install**
1. Create your first admin user then **Save and Finish** | **Start Using Jenkins**

**Next:** [Configure Jenkins to do Maven Builds](./06-ConfigureMavenTool.md)