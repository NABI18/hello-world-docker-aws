[Back to Top](../README.md)

# Using DockerHub
DockerHub is a free cloud registry where you can manage Docker Images. 

When we deploy Docker Images, first Jenkins creates the image, then pushes it to a Docker Repository or Registry. 
Then in a separate process, AWS pulls the image to deploy it as a container in the EC2 Container Service.

---
## Create a DockerHub Repository

You must [sign up for an account]((https://hub.docker.com/billing-plans/)) or log in.
 
 1. **Create Repository**
   * Repository Name: `hello-world-docker-aws`

When you do so, make note of the following details which you will need to complete configuration:

 * [ ] Username
 * [ ] Password
 * [ ] Repository namespace
 * [ ] Repository name (`hello-world-docker-aws`)
 
Because Jenkins needs access to push a new image to your DockerHub Repository, we need to configure credentials inside 
Jenkins to do so.

**Next:** [Deploy the ECS Cluster](./03-ECSCluster.md)