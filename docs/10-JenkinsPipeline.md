[Back to Top](../README.md)

# Configure a Build Job

1. In Jenkins, click **New Item**
1. **Item Name:** "`hello-world-pipeline`"
1. Click **Pipeline** | **OK**
1. Scroll down to the **Pipeline** section
  * **Definition:** "`Pipeline script from SCM`"
  * **SCM:** "`Git`"
    * **Repository URL:** (<a href="https://github.com/simoncomputing/hello-world-docker-aws/blob/master/docs/00-GitRepository.md#how-to-get-the-ssh-url-for-your-repository" target="_blank">Your repository's SSH URL</a>)
    * **Lightweight Checkout:**  `[true]`
1. Click **Save**

# Modify JenkinsFile for your repository
Let's make some changes to the JenkinsFile to use your repositories (git and docker).

1. Open `Jenkinsfile` in an editor
1. Look for the `environments` section where you will see the following:

  ```groovy
    environment {
        REGISTRY_CREDENTIAL_ID = 'DOCKER_REGISTRY_CREDENTIALS'
        GIT_URL = 'git@github.com:simoncomputing/hello-world-docker-aws.git'
        DOCKER_IMAGE_NAME = 'simoncomputing-public/hello-world-docker-aws'
        AWS_REGION = 'us-east-1'
        DOCKER_REGISTRY = 'https://index.docker.io/v1/'
        ECS_CLUSTER_NAME = 'hello-world'
        
        // look in 'CloudFormation' -> 'Output' tab for "DefaultTarget" and "ServiceRole"
        DEFAULT_TARGET = 'arn:aws:elasticloadbalancing:us-east-1:487471999079:targetgroup/default/8eab6a3694cef2e2'
        SERVICE_ROLE = 'ecs-service-EcsClusterStack'
    }
  ```

| variable | description |
| -------- | ----------- |
| `REGISTRY_CREDENTIAL_ID` | matches the ID of the [Docker Credentials you created previously](./07-DockerCredentials.md) |
| `GIT_URL` | change to the **SSH** url for your project |
| `DOCKER_IMAGE_NAME` | change to the `namespace/hello-world-docker-aws` for your docker repository |
| `AWS_REGION` | change if needed |
| `DOCKER_REGISTRY` | For DockerHub, use `https://index.docker.io/v1/` |
| `ECS_CLUSTER_NAME` | this must match the value of your cluster (in AWS, go to **EC2 Container Service** -> **Clusters** to check the name) |
| `DEFAULT_TARGET` | This is the `arn` (identifier) of the LoadBalancer group. You can find this in the "Output" Tab of the EcsClusterStack CloudFormation. |
| `SERVICE_ROLE` | This is the name of an IAM role created for the services. The Jenkins Build needs it in order to create or update a Service. |

1. If you are impatient, change the polling interval from `5` minutes to a figure you prefer:

```groovy
    triggers {
        pollSCM('H/5 * * * *')
    }
``` 

 * `pollSCM('* * * * *')` - polls every minute
 
# Modify the docker-compose.yml file for your image repository
Let's change the `docker-compose.yml` file so the image it points to will be from your DockerHub repository.

1. Open `docker-compose.yml` in an editor
```yaml

version: '2'

services:
  web:
    image: simoncomputing-public/hello-world-docker-aws
    cpu_shares: 100
    mem_limit: 268435456
    ports:
      - 8080
```

1. Change `simoncomputing-public/hello-world-docker-aws` to your DockerHub image repository name
 
# Push your changes

1. Commit and push your changes

  ```shell
  # see what's changed
  git status

  # stage changes
  git add .

  # commit locally
  git commit -m "Configure build for current repo"

  # push
  git push
  ```

# Test
Go back to the job in Jenkins and click **Build Now**. The first time you run the build, you need to trigger it manually.
Thereafter, it will poll for changes every 5 minutes.
  
# Watch the deployment
1. Go to AWS **EC2 Container Service**
1. Click on **hello-world** to view the Cluster
1. Click the **Tasks** Tab to see the pending tasks
1. When the container has deployed, paste the **LoadBalancerUrl** 
(you can get this from the **Outputs** tab in the CloudFormation Stack details for `EcsClusterStack`) into a 
browser window to verify that you can see "Hello World".

# Make an edit and push
Make a modification (for instance, change `Hello World` to something else 
in `src/main/java/com/simoncomputing/app/helloworld/controller/HomeController` file) and push. 
Wait up to 5 minutes for the Jenkins job to trigger.

 >**Note:** You can click **Git Polling Log** in the Jenkins project to see when it last polled so you can make a guess
 when it will next poll (polls every 5 minutes).

 * Try changing "`Hello World" to something else to verify the change gets deployed.
 
1. Go to AWS **EC2 Container Service** and click on the cluster name `hello-world`
1. Click on the service name `hello-world-service`
1. Go to the **Events** tab
  * If you see a message that the "service hello-world-service has begun draining connections on 1 tasks," try refreshing
  your browser window to see the changes.
  

**Finally:** [Clean up](./cleanup.md) if you are done.