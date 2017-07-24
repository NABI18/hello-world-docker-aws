# Using GitLab Container Registry
GitLab is an online Git repository manager with a wiki, issue tracking, and offers a private container registry for every project.
This is a convenient way to manage the source code of your project as well as the docker images in the same location.

The community edition of GitLab is a Free, Open source, self-hosted application, scalable to 25,000 users on one server, or a HA cluster.

As of this writing, accounts on [https://gitlab.com](https://gitlab.com) are free, and have unlimited private repositories.

If you decide to use GitLab Container Registry with this project, you must sign up for an account and make a **clone** of this
repository in GitLab (because you will not have permissions to push images to the registry on this project). Specific steps for doing so
are in the next page.

When you do so, make note of the following details which you will need to complete configuration:

 * [ ] Username (e.g., `jdoe`)
 * [ ] Password
 * [ ] Group name (e.g., `jdoe`)
 * [ ] Repository name (e.g., `hello-world-docker-aws`)
 
# Get authorization token for ECS_ENGINE_AUTH_DATA
In order for Jenkins to push to your repository, it only requires your username and password.

In order for your image to be deployed on an ECS instance, your cloned repository needs to be public.

If you want to use a private repository, you must
 * craft the JSON for the **ECS_ENGINE_AUTH_DATA** value
 * set up an **S3** bucket to hold the **ECS_ENGINE_AUTH_DATA** environment value setting
 * modify the `ecs-cluster.template` to ensure your secret values are added to **EC2** instances created in the cluster
 
These activities are not covered in this documentation at this time.

**Next:** [Clone Git Repository](02-GitRepository.md)