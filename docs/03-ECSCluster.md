[Back to Top](../README.md)

# Create the ECS Cluster
For this task, we'll use a **CloudFormation** Template to quickly stand up a **Stack**.

1. If you haven't already, clone your repository to your local machine.
1. In AWS, go to **CLoudFormation** | **Create Stack**
1. **Upload a template to Amazon S3** then **choose file** and go to your clone directory and pick `{project_dir}/cloudformation/ecs-cluster.template`
1. Fill in the parameters (for best results, launch into a new VPC)
    * **Stack name:** "`EcsClusterStack`"
    * **KeyName:** (select your machine key pair that you imported)
1. Click **Next**
1. Click **Next** after adding tags or notifications (if you like)
1. Click the acknowledgement checkbox, then click **Create**
1. Wait for the stack to build. You can watch progress by clicking the **Events** tab in the detail pane.

**Next:** [Deploy the Jenkins Stack](./04-JenkinsServer.md)