pipeline {
    agent any

    environment {
        IMAGE_NAME = 'bankapp-tomcat'
        DOCKER_REPO = 'hemanth42079/bankapp-tomcat'
        DOCKER_TAG = 'latest' // Update this to the correct tag
        CONTAINER_NAME = 'bankapp_container'
        CONTAINER_PORT = '5000'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: 'main']], 
                          userRemoteConfigs: [[url: 'https://github.com/iamironman4279/javawebdynmic.git']]
                ])
            }
        }

        stage('Pull Docker Image') {
            steps {
                script {
                    // Pull Docker image from Docker Hub
                    sh "docker pull ${DOCKER_REPO}:${DOCKER_TAG}"
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Stop and remove existing container if it exists
                    sh "docker rm -f ${CONTAINER_NAME} || true"
                    
                    // Run Docker container on port 5000
                    sh "docker run -d -p ${CONTAINER_PORT}:5000 --name ${CONTAINER_NAME} ${DOCKER_REPO}:${DOCKER_TAG}"
                }
            }
        }

        stage('Verify') {
            steps {
                script {
                    // Verify that the container is running
                    sh "docker ps"
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully."
        }
        failure {
            echo "Pipeline failed."
        }
    }
}
