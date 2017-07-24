[Back to Top](../README.md)

# Cleaning up

## Delete the Service
Select the 'hello-world-service' and click **Update** and change **Number of tasks* to "`0`". 

Wait for **Running count** to be `0`, then **Delete** it.

## Stop the tasks
This essentially means "de-registering" the tasks that are **Active**.

When you are done de-registering the tasks, go back to the **Clusters** view and wait until there are no more "Pending Tasks."

## Delete stacks
Go to **CloudFormation** and delete the `Jenkins` stack first, then when that completes, delete the `EcsClusterStack`.

### Delete the Cluster Manually
Sometimes, the CloudFormation **Delete Stack** cannot completely delete the final item. Go to the **EC2 Container Service** 
and manually delete the cluster.

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