[Back to Top](../README.md)

# Cleaning up

## Disable the Jenkins project
Go to the Project view, and click the **Disable Project** button. This will stop Jenkins from polling, as well as prevent
Jenkins for deploying to AWS while we are trying to shut things down.

## Delete the Service and Deregister task

1. Go to **EC2 Container Service** and go to the `hello-world` cluster.
1. Select the 'hello-world-service' and click **Update** and change **Number of tasks* to "`0`".
1. Go to **Task Definitions** in the left pane and click on the `hello-world` task.
1. Click the checkbox to select all revisions, then **Actions** | **Deregister**
1. Go back to the `hello-world-service` view.
1. Wait for **Running count** to be `0`, then **Delete** the service.

## Delete stacks
Go to **CloudFormation** and delete the `Jenkins` stack first, then when that completes, delete the `EcsClusterStack`.

You can watch the resources being deleted from the **Resources** tab.

### Delete the Cluster Manually
Sometimes, the CloudFormation **Delete Stack** cannot completely delete the final item because the associated EC2 instances are still shutting down. 
We don't delete the EC2 instances beforehand because the Auto-Scaler would just re-create a new one.

1. Go to the **EC2 Dashboard** and check the `ECS Instance` for your stack and wait until its state is `terminated`.
1. Go back to **CloudFormation** and attempt the delete again.

## S3
Go into **S3** on AWS and delete the bucket that holds the uploaded cloudformation templates. 
It has a name that begins with `cf-templates-`, and if you click into it, you will recognize the templates you uploaded
when you created the stacks. 

## Key Pairs
If desired, remove the key pairs you created for your local machine access.

## GitHub Deploy Keys
Since you just removed the Jenkins stack, the deploy key you added to GitHub is no longer valid. Go and delete it.

## Container Images
You might want to remove the images from your Docker Repository just to be tidy.

## Git Project
You might also want to delete your git project.