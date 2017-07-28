[Back to Top](../README.md)

# Create the ECS Cluster
For this task, we'll use a **CloudFormation** Template to quickly stand up a **Stack**.

## Create the VPC
To isolate your work, you can create your own VPC. This is ideal if you intend to do a complete tear-down at the end 
and want to ensure you are removing all resources without impacting existing ones.

1. In AWS, use the **Services** dropdown to go to **CLoudFormation** | **Create Stack**
1. **Upload a template to Amazon S3** then **choose file** and go to your clone directory, 
pick `{project_dir}/cloudformation/vpc.yml`,
then click **Next**
1. Fill in the parameters (defaults are fine unless you stood up a VPC with this template using defaults already)
    * **Stack name:** "`VpcStack`"
1. Click **Next**
    * Add a Tag: `Name` | `hello-world vpc`
1. Click **Next** after adding tags or notifications (if you like)
    * Click **Cost** to view the estimated cost of the vpc
1. Wait for the stack to build. You can watch progress by clicking the **Events** tab in the detail pane.
1. After the stack has completed building, click on the **Outputs** tab.

The Outputs tab holds information that allows you to quickly see what is contained in the stack.

## Create the Cluster

1. In AWS, use the **Services* dropdown to go to **CLoudFormation** | **Create Stack**
1. **Upload a template to Amazon S3** then **choose file** and go to your clone directory, 
pick `{project_dir}/cloudformation/ecs-cluster.yml`,
then click **Next**
1. Fill in the parameters (for best results, launch into a new VPC)
    * **Stack name:** "`EcsClusterStack`"
    * **VpcId:** (select your VPC from the drop down)
    * **KeyName:** "`hello-world-ecs`" (if you used a different name for your key pair, select that here)
1. Click **Next**
1. Click **Next** after adding tags or notifications (if you like)
    * Click **Cost** to view the estimated cost of the cluster
1. Click the acknowledgement checkbox, then click **Create**
1. Wait for the stack to build. You can watch progress by clicking the **Events** tab in the detail pane.
1. After the stack has completed building, click on the **Outputs** tab.

The outputs tab holds a variety of information, some of which are used by the next process to provision a Jenkins Server,
and some of which you will need when configuring the Jenkins Build Job for your repository and AWS Cluster.


**Next:** [Deploy the Jenkins Stack](./04-JenkinsServer.md)