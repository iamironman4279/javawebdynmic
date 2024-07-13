pipeline {
    agent any

    environment {
        DOCKER_COMPOSE_VERSION = '1.29.2' // Update with your Docker Compose version
        IMAGE_NAME = 'bankapp-tomcat'    // Update with your desired image name
        APP_PORT = '8082'                // Application port
        DOCKERHUB_CREDENTIALS = 'dockerhub-credentials' // Update with your Docker Hub credentials ID
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: 'main']], 
                          userRemoteConfigs: [[url: 'https://github.com/iamironman4279/javawebdynmic.git']]
                ])
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    // Update package index and install Python3 pip
                    sh 'sudo apt update'
                    sh 'sudo apt install -y python3-pip'
                    // Install Docker Compose via pip
                    sh 'sudo pip3 install docker-compose==${DOCKER_COMPOSE_VERSION}'
                }
            }
        }

        stage('Build Docker Images') {
            steps {
                script {
                    // Build Docker image
                    sh "docker build -t ${IMAGE_NAME}:${env.BUILD_NUMBER} ."
                }
            }
        }

        stage('Setup Docker Network') {
            steps {
                script {
                    // Create Docker network if it doesn't exist
                    sh "sudo docker network create bankapp-network || true"
                }
            }
        }

        stage('Deploy Docker Containers') {
            steps {
                script {
                    // Deploy Docker containers using docker-compose
                    sh "sudo docker-compose -f docker-compose.yml up -d --build"
                }
            }
        }

        stage('Finalize') {
            steps {
                script {
                    try {
                        // Print Docker container status
                        sh "sudo docker ps -a"
                    } catch (Exception e) {
                        echo "Error in final stage: ${e.getMessage()}"
                    } finally {
                        // Shut down Docker containers
                        sh "sudo docker-compose -f docker-compose.yml down"
                    }
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
