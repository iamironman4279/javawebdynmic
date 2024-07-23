pipeline {
    agent any

    environment {
        IMAGE_NAME = 'bankapp-tomcat'
        DOCKER_CREDENTIALS_ID = '4279'
        DOCKER_REGISTRY = 'docker.io'
        DOCKER_REPO = 'hemanth42079/bankapp-tomcat'
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

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    sh "docker build -t ${IMAGE_NAME}:${env.BUILD_NUMBER} ."
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    // Log in to DockerHub
                    docker.withRegistry("https://${DOCKER_REGISTRY}", DOCKER_CREDENTIALS_ID) {
                        // Tag and push Docker image
                        sh "docker tag ${IMAGE_NAME}:${env.BUILD_NUMBER} ${DOCKER_REPO}:${env.BUILD_NUMBER}"
                        sh "docker push ${DOCKER_REPO}:${env.BUILD_NUMBER}"
                    }
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run Docker container
                    sh "docker run -d -p ${CONTAINER_PORT}:5000 --name ${IMAGE_NAME}_${env.BUILD_NUMBER} ${DOCKER_REPO}:${env.BUILD_NUMBER}"
                }
            }
        }

        stage('Finalize') {
            steps {
                script {
                    try {
                        // Print Docker container status
                        sh "docker ps -a"
                    } catch (Exception e) {
                        echo "Error in final stage: ${e.getMessage()}"
                    } finally {
                        // Clean up Docker containers
                        sh "docker rm -f \$(docker ps -a -q)"
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
