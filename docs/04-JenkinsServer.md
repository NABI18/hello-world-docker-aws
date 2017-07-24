# Provision Jenkins Server
For this task, we'll use a **CloudFormation** Template to quickly stand up a **Jenkins Stack**.

1. If you haven't already, clone your repository to your local machine.
1. In AWS, go to **CLoudFormation** | **Create Stack**
1. **Upload a template to Amazon S3** then **choose file** and go to your clone directory and pick `{project_dir}/cloudformation/jenkins.template`
1. Fill in the parameters (defaults are probably fine)
    * **Stack name:** "`Jenkins`"
    * **EcsStackName:** '`EcsClusterStack`' (same name that you used for the Ecs Cluster Stack you created previously)
    * **SSHLocation:** (keep default or modify if you wish)
1. Click **Next**
1. Click **Next** after adding tags or notifications (if you like)
    * You might want to add a `Name` tag so you can find this instance in your list of `EC2` instances
1. Click the acknowledgement checkbox, then click **Create**
1. Wait for the stack to build. You can watch progress by clicking the **Events** tab in the detail pane.

**Next:** [Give Jenkins Access to the GitLab Repository](./05-JenkinsGitLab.md)