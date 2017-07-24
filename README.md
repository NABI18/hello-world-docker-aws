# Hello World Test Project

This is a project to demonstrate dockerizing a Spring Boot application, pushing it to the GitLab Container Registry,
and deploying it to AWS (ECS Cluster).

## High Level Steps
1. [Set yourself up in AWS](./docs/01-AwsAccount.md) (account, key pair, decide your region, etc)
1. Set yourself up with a Docker Registry (either [GitLab](./docs/02-GitLabRegistry.md), or [DockerHub](./docs/02-DockerHub.md))
1. [Set up your Git Repository](docs/02-GitRepository.md)
1. [Create a simple ECS Cluster](./docs/03-ECSCluster.md) (with custom attribute "stack" = "testing")
1. [Provision a **Jenkins Server**](./docs/04-JenkinsServer.md) and give it **access and ability** to 
    1. [Clone from the GitLab repo](docs/05-JenkinsGitLab.md)
    1. [Build a Maven project](./docs/06-ConfigureMavenTool.md)
    1. Create a Docker Image 
    1. [Push to the GitLab Container Registry or DockerHub](./docs/07-DockerCredentials.md)
    1. Deploy to AWS ECS Cluster
1. [Configure a pipeline job in Jenkins](./docs/10-JenkinsPipeline.md)
1. [Clean up](./docs/cleanup.md)

## Prerequisites

 * You can execute `bash` commands (in Windows, download and use **GitBash**)
 * You have an AWS account where you have the necessary permissions to do the following (Administrator access preferable):
    * Import a Key Pair
    * Create a Stack using Cloud Formation
    * Create a EC2 Container Service Cluster (and necessary relevant actions)