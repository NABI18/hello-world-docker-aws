[Back to Top](../README.md)

# Configure a Build Job

1. In Jenkins, click **New Item**
1. **Item Name:** "`hello-world-pipeline`"
1. Click **Pipeline** | **OK**
1. Scroll down to the **Pipeline** section
  * **Definition:** "`Pipeline script from SCM`"
  * **SCM:** "`Git`"
    * **Repository URL:** "`git@github.com:simoncomputing/hello-world-docker-aws.git`" (your repository url)
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
    }
  ```

1. **`REGISTRY_CREDENTIAL_ID`** matches the ID of the [Docker Credentials you created previously](./07-DockerCredentials.md)
1. **`GIT_URL`** change to the **SSH** url for your project
1. **`DOCKER_IMAGE_NAME`** change to the `namespace/hello-world-docker-aws` for your docker repository
1. **`AWS_REGION`** change if needed
1. **`DOCKER_REGISTRY`** For DockerHub, use `https://index.docker.io/v1/`
1. **`ECS_CLUSTER_NAME`** this must match the value of your cluster (in AWS, go to **EC2 Container Service** | **Clusters** to check the name)

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
1. When the container has deployed, paste the Container Instance's public IP into a browser window to verify that you can see "Hello World".

# Make an edit and push
Make a modification (perhaps to the `src/main/java/com/simoncomputing/app/helloworld/controller/HomeController` file) and push. 
Wait up to 5 minutes for the Jenkins job to trigger.

 * Try changing "`Hello World" to something else to verify the change gets deployed.

**Finally:** [Clean up](./cleanup.md) if you are done.