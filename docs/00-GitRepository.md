[Back to Top](../README.md)

# Set yourself up in GitHub
In order to work with this project and have it demonstrate CI/CD, you must have the ability to make a change to the code
file, and trigger a build.

This repository is public, but you may not be permitted to make changes. Therefore, you should **clone** this repository,
and stand up your own. Below are the steps to do so in GitHub.

---
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

---
## Create your account
Go to [GitHub]https://github.com) and **Sign up for GitHub** if you do not have an account already.

After you do, be sure to [Add a new SSH key to your GitHub account](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/),
so that you have access to push code to it from the command line.

---
## Create the repository
In this step, you will create a "remote" repository that Jenkins can access to pull code for the build.

1. Click the `+` button next to your profile picture, and select **New Repository** 
and give your repository the name "`hello-world-docker-aws`"
(if you name it anything else, be aware that you may have to modify some files).

1. **Make the repository PUBLIC**, and do not initialize the repository with anything.

1. Click **Create Repository**

We will be **pushing an existing repository from the command line**.

---
## Push your code to your new repository
In order to do this, you can copy the code snippet under the title "**...or push an existing repository from the command line**" and execute it.

Below are the steps with a small explanation for each command.
```shell
# set an alias to make pushes more sane (by convention, alias for remote is 'origin')
git remote add origin '<repo_url>'

# push to remote 'master' branch and make master default for git pull/push
git push --u origin master
```

---
## How to get the SSH URL for your repository
There are two urls for a GitHub project:

  * HTTPS: `https://github.com/simoncomputing/hello-world-docker-aws.git`
  * SSH: `git@github.com:simoncomputing/hello-world-docker-aws.git`
  
When you cloned this repository, you used the `HTTPS` url, which you can use "anonymously" (without logging in).

However, when you configure Jenkins to pull from your new repository, you need to give it the `SSH` url. Here is how you get it:

 1. On your project's main page, click the **Clone or download** button (it's _GREEN_).
   * If the pop-over says **Clone with HTTPS**, click on the **Use SSH** link.
   * If the pop-over says **Clone with SSH**, click the clipboard button to copy the SSH url into your clipboard.

---
## Resources
 * [Adding a new SSH key to your GitHub account](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/)

**Next:** [Set yourself up in AWS](01-AwsAccount.md)
