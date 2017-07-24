# Hello World Test Project

This is a project to demonstrate dockerizing a Spring Boot application, pushing it to DockerHub,
and deploying it to AWS (ECS Cluster).

## High Level Steps
1. [Setup SSH Keys](./docs/00-SSHKey.md)
1. [Set yourself up in AWS](./docs/01-AwsAccount.md) (account, key pair, decide your region, etc)
1. [Set yourself up with a Docker Registry](./docs/02-DockerHub.md))
1. [Set up your Git Repository](docs/02-GitRepository.md)
1. [Create a simple ECS Cluster](./docs/03-ECSCluster.md) (with custom attribute "stack" = "testing")
1. [Provision a **Jenkins Server**](./docs/04-JenkinsServer.md)
    1. [Put Jenkins Server Public Key on GitHub project](docs/05-JenkinsGitHub.md)
    1. [Configure for Maven](./docs/06-ConfigureMavenTool.md)
    1. [Add Docker Credentials](./docs/07-DockerCredentials.md)
1. [Create a pipeline job in Jenkins](./docs/10-JenkinsPipeline.md)
1. [Clean up](./docs/cleanup.md)

## Prerequisites

 * You can execute `bash` commands (in Windows, download and use **GitBash**)
 * You have an AWS account where you have the necessary permissions to do the following (Administrator access preferable):
    * Import a Key Pair
    * Create a Stack using Cloud Formation
    * Create a EC2 Container Service Cluster (and necessary relevant actions)
    
 * You are willing to create a DockerHub account and a free, public Docker repository called `hello-world-docker-aws`.