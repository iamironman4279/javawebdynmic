pipeline {
    agent any

    environment {
        DOCKER_COMPOSE_VERSION = '1.29.2'
        IMAGE_NAME = 'bankapp-tomcat'
        APP_PORT = '8082'
        SUDO_CREDENTIALS = credentials('sudo-credentials') // Replace with your actual Jenkins credential ID
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
                    sh "echo ${SUDO_CREDENTIALS} | sudo -S apt update"
                    sh "echo ${SUDO_CREDENTIALS} | sudo -S apt install -y python3-pip"
                    sh "echo ${SUDO_CREDENTIALS} | sudo -S pip3 install docker-compose==${DOCKER_COMPOSE_VERSION}"
                }
            }
        }

        stage('Build Docker Images') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:${env.BUILD_NUMBER} ."
                }
            }
        }

        stage('Setup Docker Network') {
            steps {
                script {
                    sh "echo ${SUDO_CREDENTIALS} | sudo -S docker network create bankapp-network || true"
                }
            }
        }

        stage('Deploy Docker Containers') {
            steps {
                script {
                    sh "echo ${SUDO_CREDENTIALS} | sudo -S docker-compose -f docker-compose.yml up -d --build"
                }
            }
        }

        stage('Check Docker Containers') {
            steps {
                script {
                    sh "echo ${SUDO_CREDENTIALS} | sudo -S docker ps -a"
                }
            }
        }

        stage('Finalize') {
            steps {
                script {
                    sh "echo ${SUDO_CREDENTIALS} | sudo -S docker-compose -f docker-compose.yml down"
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
