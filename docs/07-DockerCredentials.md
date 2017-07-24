[Back to Top](../README.md)
 
# Jenkins Docker Credentials

1. In Jenkins, go to **Credentials** | **(global)** | **Add Credential**
    * **Kind:** "`Username with password`"
    * **Scope:** "`Global`"
    * **Username:** (enter your username)
    * **Password:** (enter your password)
    * **ID:** "`DOCKER_REGISTRY_CREDENTIALS`" (must match the value in the environment variable `REGISTRY_CREDENTIAL_ID` in the [`Jenkinsfile`](https://github.com/simoncomputing/hello-world-docker-aws/blob/master/Jenkinsfile))
    * **Description:** (Type a _very short_ name, like "`docker`" -- the credential will list on dropdowns as "`{your_username}/****** (docker)`")
1. Click **OK**

**Next:** [Create the Jenkins Pipeline Job](./10-JenkinsPipeline.md)