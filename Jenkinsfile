pipeline {
    agent any

    triggers {
        pollSCM('* * * * *')
    }

    tools {
        maven 'maven-3.5.0'
    }

    environment {
        REGISTRY_CREDENTIAL_ID = 'DOCKER_REGISTRY_CREDENTIALS'
        GIT_URL = 'git@github.com:simoncomputing/hello-world-docker-aws.git'
        AWS_REGION = 'us-west-2'
        DOCKER_REGISTRY = 'https://index.docker.io/v1/'
        ECS_CLUSTER_NAME = 'hello-world'

        // look in 'CloudFormation' -> 'Output' tab for "DefaultTarget" and "ServiceRole"
        DEFAULT_TARGET = 'arn:aws:elasticloadbalancing:us-west-2:487471999079:targetgroup/default/3333deca3d9fa2e3'
        SERVICE_ROLE = 'ecs-service-EcsClusterStack'
    }

    stages {

        stage('checkout') {
            steps {
                deleteDir()
                git branch: 'feature/feature_dockercompose',
                        url: "${GIT_URL}"
            }
        }

        stage('prepare environment') {
            steps {
                script {
                    DOCKER_IMAGE_NAME = sh(
                        returnStdout: true,
                        script: 'cat docker-compose.yml | docker run -i --rm jlordiales/jyparser get -r .services.hello_world.image'
                    ).trim()
                    echo "debug 1"
                    echo "[${DOCKER_IMAGE_NAME}]"
                    DOCKER_IMAGE_AND_TAG = "${DOCKER_IMAGE_NAME}:v_${BUILD_NUMBER}"
                    echo "[${DOCKER_IMAGE_AND_TAG}]"
                    shell_cmd = "cat docker-compose.yml | docker run -i --rm jlordiales/jyparser set .services.hello_world.image \\\"${DOCKER_IMAGE_AND_TAG}\\\""
                    sh shell_cmd
                    sh 'cat docker-compose.yml'
                    echo "  end debug 1"
                }
            }
        }


        stage('build jar') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('build docker image') {
            steps {
                script {
                    docker.withRegistry("${DOCKER_REGISTRY}", "${REGISTRY_CREDENTIAL_ID}") {
                        container = docker.build("${DOCKER_IMAGE_AND_TAG}")
                        container.push()
                    }
                }
            }
        }

        stage('deploy to ecs') {
            steps {
                sh '''#!/bin/sh -e

                    echo " === Configuring ecs-cli ==="
                    /usr/local/bin/ecs-cli configure --region ${AWS_REGION} --cluster ${ECS_CLUSTER_NAME}

                    echo " === Create/Update Service === "
                    /usr/local/bin/ecs-cli compose service up \
                    --deployment-min-healthy-percent 0 \
                    --target-group-arn ${DEFAULT_TARGET} \
                    --container-name hello_world \
                    --container-port 8080 \
                    --role ${SERVICE_ROLE}

                ''' // end shell script
            }
        }
    }

}

