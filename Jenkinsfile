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
                        script: 'cat docker-compose.yml | docker run -i --rm jlordiales/jyparser get -r .services.web.image'
                    ).trim()
                    LB_ROLE = sh(
                        returnStdout: true,
                        script: '''#!/bin/sh -e
                            echo " == get role arn == "
                            ROLES=`aws iam list-roles | jq '.Roles[] | select(.AssumeRolePolicyDocument.Statement[].Principal.Service=="ecs.amazonaws.com"  and .RoleName=="esc-service-role")'`

                            if [ "$ROLES" == "" ]; then
                              echo "No matching roles. Make sure ${SERVICE_ROLE} exists and has a Trust Relationship with the service `ecs.amazonaws.com`"
                              exit -1
                            fi

                            echo $ROLES | jq -r .Arn
                        ''' // end shell script
                    ).trim()
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
                        container = docker.build("${DOCKER_IMAGE_NAME}:v_${BUILD_NUMBER}")
                        container.push()
                    }
                }
            }
        }

        stage('deploy to ecs') {
            steps {
                sh '''#!/bin/sh -e
                    echo $LB_ROLE

                    echo " === Configuring ecs-cli ==="
                    /usr/local/bin/ecs-cli configure --region ${AWS_REGION} --cluster ${ECS_CLUSTER_NAME}

                    echo " === Create/Update Service === "
                    /usr/local/bin/ecs-cli compose service up \
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

