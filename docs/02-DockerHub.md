# Using DockerHub
DockerHub is a free cloud registry where you can manage Docker Images. [A Free account allows you to have one private repository,
and unlimited public repositories](https://hub.docker.com/billing-plans/).

If you decide to use DockerHub with this project, you must sign up for an account and make a **public** repository for the image.

When you do so, make note of the following details which you will need to complete configuration:

 * [ ] Username (e.g., `jdoe`)
 * [ ] Password
 * [ ] Repository namespace (e.g., `jdoe`)
 * [ ] Repository name (e.g., `hello-world-docker-aws`)
 
# Get authorization token for ECS_ENGINE_AUTH_DATA
In order for Jenkins to push to your repository, it only requires your username and password.

In order for your image to be deployed on an ECS instance, your docker repository needs to be public.

If you want to use a private repository, you must
 * craft the JSON for the **ECS_ENGINE_AUTH_DATA** value
 * set up an **S3** bucket to hold the **ECS_ENGINE_AUTH_DATA** environment value setting
 * modify the `ecs-cluster.template` to ensure your secret values are added to **EC2** instances created in the cluster
 
These activities are not covered in this documentation at this time.

**Next:** [Clone Git Repository](02-GitRepository.md)