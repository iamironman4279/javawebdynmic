pipeline {
    agent any

    environment {
        DOCKER_COMPOSE_VERSION = '1.29.2' // Update with your Docker Compose version
        IMAGE_NAME = 'bankapp-tomcat'    // Update with your desired image name
        APP_PORT = '8082'                // Application port
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], 
                          userRemoteConfigs: [[url: 'https://github.com/iamironman4279/javawebdynmic.git']]
                ])
            }
        }

        stage('Build Docker Images') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', '1234') {
                        def customImage = docker.build("${IMAGE_NAME}:${env.BUILD_NUMBER}")
                        customImage.push()
                    }
                }
            }
        }

        stage('Setup Docker Network') {
            steps {
                script {
                    sh "docker network create bankapp-network || true"
                }
            }
        }

        stage('Deploy Docker Containers') {
            steps {
                script {
                    sh "docker-compose -f docker-compose.yml up -d --build"
                }
            }
        }

        stage('Finalize') {
            steps {
                script {
                    try {
                        sh "docker ps -a"
                    } catch (Exception e) {
                        echo "Error in final stage: ${e.getMessage()}"
                    } finally {
                        sh "docker-compose -f docker-compose.yml down"
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
