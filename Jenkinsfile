pipeline {
    agent any

    triggers {
        pollSCM('H/5 * * * *')
    }

    tools {
        maven 'maven-3.5.0'
    }

    environment {
        REGISTRY_CREDENTIAL_ID = 'DOCKER_REGISTRY_CREDENTIALS'
        GIT_URL = 'git@github.com:simoncomputing/hello-world-docker-aws.git'
        DOCKER_IMAGE_NAME = 'simoncomputing-public/hello-world-docker-aws'
        AWS_REGION = 'us-east-1'
        DOCKER_REGISTRY = 'https://index.docker.io/v1/'
        ECS_CLUSTER_NAME = 'hello-world'

        // look in 'CloudFormation' -> 'Output' tab for "DefaultTarget" and "ServiceRole"
        DEFAULT_TARGET = 'arn:aws:elasticloadbalancing:us-east-1:487471999079:targetgroup/default/8eab6a3694cef2e2'
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


        stage('build jar') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('build docker image') {
            steps {
                script {
                    docker.withRegistry("${DOCKER_REGISTRY}", "${REGISTRY_CREDENTIAL_ID}") {
                        container = docker.build("${DOCKER_IMAGE_NAME}:v_${BUILD_NUMBER}")
                        container.push()
                    }
                }
            }
        }

        stage('deploy to ecs') {
            steps {
                sh '''#!/bin/sh -e

                    echo " == get role arn == "
                    ROLES=`aws iam list-roles | jq '.Roles[] | select(.AssumeRolePolicyDocument.Statement[].Principal.Service=="ecs.amazonaws.com"  and .RoleName=="esc-service-role")'`

                    if [ "$ROLES" == "" ]; then
                      echo "No matching roles. Make sure ${SERVICE_ROLE} exists and has a Trust Relationship with the service `ecs.amazonaws.com`"
                      exit -1
                    fi

                    LB_ROLE=`echo $ROLES | jq -r .Arn`

                    echo " === Configuring ecs-cli ==="
                    ecs-cli configure --region ${AWS_REGION} --cluster ${ECS_CLUSTER_NAME}

                    echo " === Create/Update Service === "
                    ecs-cli compose service up \
                    --deployment-min-healthy-percent 0 \
                    --target-group-arn ${DEFAULT_TARGET} \
                    --container-name hello-world \
                    --container-port 8080 \
                    --role ${LB_ROLE}

                ''' // end shell script
            }
        }
    }

}

