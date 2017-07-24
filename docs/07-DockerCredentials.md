# Jenkins Docker Credentials
In order to push a newly created image to a Container Registry, Jenkins needs to have your username and password stored 
as a credential.

For this step, you need to provide the **Username** and **Password** to the system you are using for the Container Registry:

  * DockerHub (use your DockerHub credentials)
  * GitLab (use your GitLab credentials)
  

## Steps

1. In Jenkins, go to **Credentials** | **(global)** | **Add Credential**
    * **Kind:** "`Username with password`"
    * **Scope:** "`Global`"
    * **Username:** (enter your username)
    * **Password:** (enter your password)
    * **ID:** "`DOCKER_REGISTRY_CREDENTIALS`" (must match the value in the environment variable `REGISTRY_CREDENTIAL_ID` in the [`Jenkinsfile`](https://gitlab.com/simoncomputing-public/hello-world-docker-aws/blob/master/Jenkinsfile))
    * **Description:** (Type a _very short_ name, like "`docker`" -- the credential will list on dropdowns as "`{your_username}/****** (docker)`")
1. Click **OK**

**Next:** [Create the Jenkins Pipeline Job](./10-JenkinsPipeline.md)