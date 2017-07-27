[Back to Top](../README.md)

# Provision Jenkins Server
For this task, we'll use a **CloudFormation** Template to quickly stand up a **Jenkins Stack**.

1. In AWS, go to **CLoudFormation** | **Create Stack**
1. **Upload a template to Amazon S3** then **choose file** and go to your clone directory, 
pick `{project_dir}/cloudformation/jenkins.template`,
then click **Next**
1. Fill in the parameters (defaults are probably fine)
    * **Stack name:** "`Jenkins`"
    * **EcsStackName:** '`EcsClusterStack`' (same name that you used for the Ecs Cluster Stack you created previously)
1. Click **Next**
1. Click **Next** after adding tags or notifications (if you like)
    * Click **Cost** to view the estimated cost of the cluster
1. Click the acknowledgement checkbox, then click **Create**
1. Wait for the stack to build. You can watch progress by clicking the **Events** tab in the detail pane.
1. After the stack has completed, go to the **Resources** tab and look for **WebServerGroup** (click the link, which will open in a new window).
This is the _Auto-Scaling Group_ for the Jenkins Server and will give us access to the EC2 Instance details.
1. Go to the **Instances** tab in the details pane, then click on the **Instance ID** listed there (there should be only 1).
1. Look for the **Public IP**. You'll be using that in the next step (as soon as the **Instance State** says "running").

**Next:** [Give Jenkins Access to the GitHub Repository](05-JenkinsGitHub.md)