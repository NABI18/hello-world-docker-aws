# Set yourself up in GitHub
In order to work with this project and have it demonstrate CI/CD, you must have the ability to make a change to the code
file, and trigger a build.

This repository is public, but you may not be permitted to make changes. Therefore, you should **clone** this repository,
and stand up your own. Below are the steps to do so in GitHub.

## Clone the repository as an anonymous user
Use a terminal window, or **GitBash**:

```shell
# navigate to a directory where your project will reside (e.g., "/git")
mkdir ~/git
cd ~/git

# clone the project
git clone https://github.com/simoncomputing/hello-world-docker-aws.git

# go to your project directory
cd hello-world-docker-aws

# detach your clone from this repository (by deleting the hidden .git directory)
rm -rf .git

# reinitialize the repository
git init

# stage the files
git add .

# commit locally
git commit -m "first commit"

```

Keep this window open.

## Create your account
Go to [GitHub](https://github.com) and **Sign up for GitHub** if you do not have one already.

### Add your SSH key
You created this key in the previous step:

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

1. In GitHub, go to your profile picture, and click **Settings** | **SSH Keys**
1. Click **New SSH key**
1. Paste your key in, and give it a reasonable name (for instance, the name of the machine you are on)
1. Click **Add SSH Key**

## Create the repository
In this step, you will create a "remote" repository that Jenkins can access to pull code for the build.

1. Click the `+` button next to your profile picture, and select **New Repository** 
and give your repository the name "`hello-world-docker-aws`"
(if you name it anything else, be aware that you may have to modify some files).

1. **Make the repository PUBLIC**, and do not initialize the repository with anything.

1. Click **Create Repository**

We will be **pushing an existing repository from the command line**.

## Push your code to your new repository
In order to do this, you can copy the code snippet under the title **...or push an existing repository from the command line** and execute it.

Below are the steps with a small explanation for each command.
```shell
# set an alias to make pushes more sane (by convention, alias for remote is 'origin')
git remote add origin '<repo_url>'

# push to remote 'master' branch and make master default for git pull/push
git push --u origin master
```

**Next:** [Deploy the ECS Cluster](./03-ECSCluster.md)
