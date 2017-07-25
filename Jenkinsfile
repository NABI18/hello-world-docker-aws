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
        DOCKER_IMAGE_NAME = 'brightgarden/hello-world-docker-aws'
        AWS_REGION = 'us-west-2'
        DOCKER_REGISTRY = 'https://index.docker.io/v1/'
        ECS_CLUSTER_NAME = 'hello-world'
        LB_TARGET_GROUP_ARN = 'arn:aws:elasticloadbalancing:us-west-2:487471999079:targetgroup/default/9906552327c00177'
        LB_IAM_ROLE = 'ecs-container-service-task-role'
    }

    stages {

        stage('checkout') {
            steps {
                deleteDir()
                git branch: 'feature/add_alb',
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

                    echo " === Generating Task Definition === "
                    REGION="$AWS_REGION"
                    CLUSTER="$ECS_CLUSTER_NAME"
                    FAMILY=`cat taskdef.json | jq -r .family`
                    NAME=`cat taskdef.json | jq -r .containerDefinitions[].name`
                    PORT=`cat taskdef.json | jq -r .containerDefinitions[].portMappings[].containerPort`
                    SERVICE_NAME=${NAME}-service
                    REPOSITORY_URI="$DOCKER_IMAGE_NAME"

                    echo " === replacing BUILD_NUMBER and REPOSITORY_URI to create image name ==="
                    sed -e "s;%BUILD_NUMBER%;${BUILD_NUMBER};g" -e "s;%REPOSITORY_URI%;${REPOSITORY_URI};g" taskdef.json > ${NAME}-v_${BUILD_NUMBER}.json

                    echo " === registering the task definition === "
                    aws ecs register-task-definition --family ${FAMILY} --cli-input-json file://${WORKSPACE}/${NAME}-v_${BUILD_NUMBER}.json --region ${REGION}
                    SERVICES=`aws ecs describe-services --services ${SERVICE_NAME} --cluster ${CLUSTER} --region ${REGION}`
                    SERVICE_STATUS=`echo $SERVICES  | jq -r .services[].status`

                    #Get latest revision
                    REVISION=`aws ecs describe-task-definition --task-definition ${NAME} --region ${REGION} | jq .taskDefinition.revision`

                    #Create or update service
                    if [ "$SERVICE_STATUS" == "ACTIVE" ]; then
                      echo "entered existing service"
                      DESIRED_COUNT=`echo $SERVICES | jq .services[].desiredCount`
                      if [ ${DESIRED_COUNT} = "0" ]; then
                        DESIRED_COUNT="1"
                      else
                        echo "stopping current task definition..."
                        aws ecs update-service \
                          --cluster ${CLUSTER} \
                          --region ${REGION} \
                          --service ${SERVICE_NAME} \
                          --desired-count 0
                        sleep 30
                      fi
                      echo " == starting next revision == "
                      aws ecs update-service \
                        --cluster ${CLUSTER} \
                        --region ${REGION} \
                        --service ${SERVICE_NAME} \
                        --task-definition ${FAMILY}:${REVISION} --desired-count 1
                    else
                      echo "entered new service"
                      aws ecs create-service \
                        --service-name ${SERVICE_NAME} \
                        --desired-count 1 \
                        --task-definition ${FAMILY} \
                        --cluster ${CLUSTER} \
                        --region ${REGION} \
                        --load-balancers targetGroupArn=${LB_TARGET_GROUP_ARN},containerName=${NAME},containerPort=${PORT} \
                        --role ${LB_IAM_ROLE}
                    fi

                ''' // end shell script
            }
        }
    }

}

