# Configure Maven Tool in Jenkins
In this step, we tell Jenkins to configure a Maven Installation (tool) with the relevant version number.
This will allow us to build the maven project.

1. In Jenkins, go to **Manage Jenkins** | **Global Tool Configuration**
  * Please _IGNORE_ the "Maven Configuration" at the top of the page
1. Scroll down to the **Add Maven** button and click it
  * **Name:** "`maven-3.5.0`" (must match the `maven` tool configured in the [`Jenkinsfile`](https://gitlab.com/simoncomputing-public/hello-world-docker-aws/blob/master/Jenkinsfile))
  * **Install Automatically:** `[yes]`
  * **Install from Apache:** 
    * **Version:** "`3.5.0`"
1. Click **Save** at the bottom

**Next:** [Store your Docker Credentials in Jenkins](./07-DockerCredentials.md)