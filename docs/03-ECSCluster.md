[Back to Top](../README.md)

# Create the ECS Cluster
For this task, we'll use a **CloudFormation** Template to quickly stand up a **Stack**.

1. In AWS, use the **Services* dropdown to go to **CLoudFormation** | **Create Stack**
1. **Upload a template to Amazon S3** then **choose file** and go to your clone directory, 
pick `{project_dir}/cloudformation/ecs-cluster.yaml`,
then click **Next**
1. Fill in the parameters (for best results, launch into a new VPC)
    * **Stack name:** "`EcsClusterStack`"
    * **KeyName:** "`hello-world-ecs`" (if you used a different name for your key pair, select that here)
1. Click **Next**
1. Click **Next** after adding tags or notifications (if you like)
1. Click the acknowledgement checkbox, then click **Create**
1. Wait for the stack to build. You can watch progress by clicking the **Events** tab in the detail pane.
1. After the stack has completed building, click on the **Outputs** tab.

The outputs tab holds a variety of information, some of which are used by the next process to provision a Jenkins Server,
and some of which you will need when configuring the Jenkins Build Job for your repository and AWS Cluster.


**Next:** [Deploy the Jenkins Stack](./04-JenkinsServer.md)