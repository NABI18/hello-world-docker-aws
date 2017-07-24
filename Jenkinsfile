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
        GIT_URL = 'git@gitlab.com:simoncomputing-public/hello-world-docker-aws.git'
        AwsRegion = 'us-west-2'
        DockerRegistry = 'https://registry.gitlab.com/simoncomputing-public/hello-world-docker-aws'
        DockerImageName = 'registry.gitlab.com/simoncomputing-public/hello-world-docker-aws'
        EcsClusterName = 'hello-world'
    }

    stages {

        stage('checkout') {
            steps {
                deleteDir()
                git branch: 'master',
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
                    docker.withRegistry("${DockerRegistry}", "${REGISTRY_CREDENTIAL_ID}") {
                        container = docker.build("${DockerImageName}:v_${BUILD_NUMBER}")
                        container.push()
                    }
                }
            }
        }

        stage('deploy to ecs') {
            steps {
                sh '''#!/bin/sh -e

                    echo " === Generating Task Definition === "
                    REGION="$AwsRegion"
                    CLUSTER="$EcsClusterName"
                    FAMILY=`cat taskdef.json | jq -r .family`
                    NAME=`cat taskdef.json | jq -r .containerDefinitions[].name`
                    SERVICE_NAME=${NAME}-service
                    REPOSITORY_URI="$DockerImageName"

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
                        aws ecs update-service --cluster ${CLUSTER} --region ${REGION} --service ${SERVICE_NAME} --desired-count 0
                        sleep 30
                      fi
                      echo " == starting next revision == "
                      aws ecs update-service --cluster ${CLUSTER} --region ${REGION} --service ${SERVICE_NAME} --task-definition ${FAMILY}:${REVISION} --desired-count 1
                    else
                      echo "entered new service"
                      aws ecs create-service --service-name ${SERVICE_NAME} --desired-count 1 --task-definition ${FAMILY} --cluster ${CLUSTER} --region ${REGION}
                    fi

                ''' // end shell script
            }
        }
    }

/*
    post {
        success {
            echo 'Build successful'
            updateGitlabCommitStatus name: 'jenkins', state: 'success'
        }

        failure {
            emailext (
                subject: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
                body: """<p>FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
                    <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>""",
                recipientProviders: [[$class: 'DevelopersRecipientProvider']]
            )
            updateGitlabCommitStatus name: 'jenkins', state: 'failed'
        }

        changed {
            echo 'Build result changed'
            script {
                if (currentBuild.result == null || currentBuild.result == 'SUCCESS') {
                    emailext (
                        subject: "SUCCESS: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
                        body: """<p>SUCCESS: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
                            <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>""",
                        recipientProviders: [[$class: 'DevelopersRecipientProvider']]
                    )
                }
            }

        }

        always {
            deleteDir()
        }
    }
    */

}

